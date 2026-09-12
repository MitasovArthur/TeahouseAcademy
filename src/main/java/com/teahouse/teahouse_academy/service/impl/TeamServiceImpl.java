package com.teahouse.teahouse_academy.service.impl;

import com.teahouse.teahouse_academy.model.dto.team.TeamManualCreateDto;
import com.teahouse.teahouse_academy.model.entity.*;
import com.teahouse.teahouse_academy.model.enumProject.RoleUser;
import com.teahouse.teahouse_academy.model.enumProject.TeamStatus;
import com.teahouse.teahouse_academy.repository.TeamCommentRepository;
import com.teahouse.teahouse_academy.repository.TeamRepository;
import com.teahouse.teahouse_academy.service.MeetingService;
import com.teahouse.teahouse_academy.service.TeamService;
import com.teahouse.teahouse_academy.service.UserService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class TeamServiceImpl implements TeamService {

    private final TeamRepository teamRepository;
    private final TeamCommentRepository teamCommentRepository;
    private final MeetingService meetingService;
    private final UserService userService;

    @Override
    public TeamEntity getById(Long id) {
        return teamRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Team not found with id: " + id));
    }

    @Override
    public List<TeamEntity> getTeamsPendingReview() {
        return teamRepository.findAllByStatus(TeamStatus.SUBMITTED);
    }

    @Override
    public long countPendingReviews() {
        return teamRepository.countByStatus(TeamStatus.SUBMITTED);
    }

    @Override
    @Transactional
    public List<TeamEntity> generateTeamsByShops(Long meetingId) {
        MeetingEntity meeting = meetingService.getById(meetingId);
        checkIfMeetingCompleted(meeting);

        Map<String, TeamEntity> existingTeamsByName = buildExistingTeamsMap(meeting);
        Set<Long> globallyAssignedIds = collectAssignedUserIds(meeting);

        Map<ShopEntity, List<UserEntity>> freeUsersByShop = userService.getActiveEmployees()
                .stream()
                .filter(u -> u.getShop() != null)
                .filter(u -> isAvailableForShopTeam(u, globallyAssignedIds, existingTeamsByName))
                .collect(Collectors.groupingBy(UserEntity::getShop));

        List<TeamEntity> result = new ArrayList<>();

        for (var entry : freeUsersByShop.entrySet()) {
            String shopName = entry.getKey().getName();
            List<UserEntity> shopUsers = entry.getValue();

            TeamEntity team = existingTeamsByName.containsKey(shopName)
                    ? updateExistingTeam(existingTeamsByName.get(shopName), shopUsers)
                    : createNewTeam(shopName, meeting, shopUsers);

            result.add(team);
        }

        return teamRepository.saveAll(result);
    }

    @Override
    @Transactional
    public void generateSingleTeamForAll(Long meetingId) {
        MeetingEntity meeting = meetingService.getById(meetingId);
        checkIfMeetingCompleted(meeting);

        boolean alreadyExists = meeting.getTeams() != null &&
                meeting.getTeams().stream()
                        .anyMatch(t -> "Основна група".equals(t.getName()));

        if (alreadyExists) {
            throw new IllegalStateException("A general group already exists for this gathering");
        }

        List<UserEntity> availableUsers = getAvailableUsersForMeeting(meetingId);
        if (availableUsers.isEmpty()) {
            throw new IllegalStateException("There are no free members to create a group");
        }

        TeamEntity singleTeam = TeamEntity.builder()
                .name("Основна група")
                .topic("Спільне обговорення")
                .meeting(meeting)
                .users(new HashSet<>(availableUsers))
                .status(TeamStatus.IN_PROGRESS)
                .build();

        teamRepository.save(singleTeam);
    }

    @Override
    @Transactional
    public TeamEntity createManualTeam(TeamManualCreateDto requestDto) {
        MeetingEntity meeting = meetingService.getById(requestDto.getMeetingId());
        checkIfMeetingCompleted(meeting);

        Set<UserEntity> users = getUsersFromIds(requestDto.getUserIds());

        TeamEntity team = TeamEntity.builder()
                .name(requestDto.getName())
                .topic(requestDto.getSubtopic())
                .meeting(meeting)
                .users(users)
                .status(TeamStatus.IN_PROGRESS)
                .build();

        return teamRepository.save(team);
    }

    @Override
    @Transactional
    public TeamEntity updateTeam(Long teamId, String name, String topic, List<Long> userIds) {
        TeamEntity team = getById(teamId);
        checkIfMeetingCompleted(team.getMeeting());

        team.setName(name);
        team.setTopic(topic);
        team.setUsers(getUsersFromIds(userIds));

        return teamRepository.save(team);
    }

    @Override
    @Transactional
    public void handleAdminFeedback(Long teamId, String feedback, String action) {
        TeamEntity team = getById(teamId);

        if (feedback != null && !feedback.trim().isEmpty()) {
            TeamCommentEntity newComment = TeamCommentEntity.builder()
                    .team(team)
                    .text(feedback.trim())
                    .actionType("approve".equals(action) ? "APPROVE" : "COMMENT")
                    .createdAt(LocalDateTime.now())
                    .build();

            teamCommentRepository.save(newComment);
        }

        if ("approve".equals(action)) {
            team.setStatus(TeamStatus.DONE);
        } else {
            team.setStatus(TeamStatus.IN_PROGRESS);
        }

        teamRepository.save(team);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        TeamEntity team = getById(id);
        checkIfMeetingCompleted(team.getMeeting());
        teamRepository.delete(team);
    }

    @Override
    @Transactional
    public TeamEntity save(TeamEntity team) {
        return teamRepository.save(team);
    }

    private Map<String, TeamEntity> buildExistingTeamsMap(MeetingEntity meeting) {
        return meeting.getTeams().stream()
                .collect(Collectors.toMap(TeamEntity::getName, t -> t, (t1, t2) -> t1));
    }

    private Set<Long> collectAssignedUserIds(MeetingEntity meeting) {
        return meeting.getTeams().stream()
                .flatMap(t -> t.getUsers().stream())
                .map(UserEntity::getId)
                .collect(Collectors.toSet());
    }

    private boolean isAvailableForShopTeam(UserEntity user,
                                           Set<Long> assignedIds,
                                           Map<String, TeamEntity> existingTeams) {
        if (!assignedIds.contains(user.getId())) return true;
        String shopName = user.getShop().getName();
        TeamEntity existingTeam = existingTeams.get(shopName);
        return existingTeam != null && existingTeam.getUsers().contains(user);
    }

    private TeamEntity updateExistingTeam(TeamEntity team, List<UserEntity> newUsers) {
        team.getUsers().clear();
        team.getUsers().addAll(newUsers);
        return team;
    }

    private TeamEntity createNewTeam(String name, MeetingEntity meeting, List<UserEntity> users) {
        return TeamEntity.builder()
                .name(name)
                .meeting(meeting)
                .users(new HashSet<>(users))
                .status(TeamStatus.IN_PROGRESS)
                .build();
    }

    private List<UserEntity> getAvailableUsersForMeeting(Long meetingId) {
        MeetingEntity meeting = meetingService.getById(meetingId);
        List<UserEntity> allActiveUsers = userService.getActiveEmployees();

        Set<Long> assignedUserIds = collectAssignedUserIds(meeting);

        return allActiveUsers.stream()
                .filter(user -> !assignedUserIds.contains(user.getId()))
                .collect(Collectors.toList());
    }

    private void checkIfMeetingCompleted(MeetingEntity meeting) {
        if (Boolean.TRUE.equals(meeting.getIsCompleted())) {
            throw new IllegalStateException("The meeting is now closed");
        }
    }

    private Set<UserEntity> getUsersFromIds(List<Long> userIds) {
        return userIds.stream()
                .map(userService::getById)
                .collect(Collectors.toSet());
    }
}