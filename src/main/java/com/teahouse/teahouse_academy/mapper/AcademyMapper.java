package com.teahouse.teahouse_academy.mapper;

import com.teahouse.teahouse_academy.model.dto.academy.AcademyDashboardResponseDto;
import com.teahouse.teahouse_academy.model.dto.academy.AdminMeetingDto;
import com.teahouse.teahouse_academy.model.dto.academy.AdminTeamDto;
import com.teahouse.teahouse_academy.model.dto.user.UserSelectionResponse;
import com.teahouse.teahouse_academy.model.entity.MeetingEntity;
import com.teahouse.teahouse_academy.model.entity.TeamEntity;
import com.teahouse.teahouse_academy.model.enumProject.TeamStatus;
import org.mapstruct.*;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring",
        unmappedTargetPolicy = ReportingPolicy.ERROR,
        uses = {ResourceMapper.class,
                TeamMapper.class,
                UserMapper.class,
                DateMapper.class})
public interface AcademyMapper {

    @Mapping(source = "id", target = "meetingId")
    @Mapping(source = "name", target = "meetingName")
    @Mapping(source = "date", target = "date", qualifiedByName = "asString")
    @Mapping(target = "totalTeamsCount", expression = "java(meetingEntity.getTeams() != null ? meetingEntity.getTeams().size() : 0)")
    @Mapping(target = "submittedTeamsCount", expression = "java(countSubmittedTeams(meetingEntity))")
    AcademyDashboardResponseDto toDashboard(MeetingEntity meetingEntity, @Context Long userId);

    default int countSubmittedTeams(MeetingEntity meetingEntity) {
        return meetingEntity.getTeams() != null ? (int) meetingEntity.getTeams().stream()
                .filter(t -> t.getStatus() == TeamStatus.SUBMITTED || t.getStatus() == TeamStatus.DONE)
                .count() : 0;
    }

    @Mapping(source = "users", target = "teamMembers")
    AdminTeamDto toAdminTeam(TeamEntity teamEntity, @Context Set<Long> assignedUserIds);

    @AfterMapping
    default void collectAssignedUsers(TeamEntity team, @Context Set<Long> assignedUserIds) {
        if (team.getUsers() != null && assignedUserIds != null) {
            team.getUsers().forEach(u -> assignedUserIds.add(u.getId()));
        }
    }

    @Mapping(source = "date", target = "date", qualifiedByName = "asString")
    @Mapping(target = "format", expression = "java(meetingEntity.getIsOnline() ? \"Онлайн\" : \"Офлайн\")")
    @Mapping(target = "teamsCount", expression = "java(meetingEntity.getTeams() != null ? meetingEntity.getTeams().size() : 0)")
    @Mapping(target = "resourcesCount", expression = "java(meetingEntity.getResources() != null ? meetingEntity.getResources().size() : 0)")
    @Mapping(target = "isPast", expression = "java(Boolean.TRUE.equals(meetingEntity.getIsCompleted()))")
    @Mapping(target = "availableUsers", ignore = true)
    AdminMeetingDto toAdminMeeting(MeetingEntity meetingEntity,
                                   @Context Set<Long> assignedUserIds,
                                   @Context List<UserSelectionResponse> allUsers);

    @AfterMapping
    default void setAvailableUsers(@MappingTarget AdminMeetingDto.AdminMeetingDtoBuilder dtoBuilder,
                                   @Context Set<Long> assignedUserIds,
                                   @Context List<UserSelectionResponse> allUsers) {
        if (allUsers != null && assignedUserIds != null) {
            List<UserSelectionResponse> available = allUsers.stream()
                    .filter(u -> !assignedUserIds.contains(u.getId()))
                    .collect(Collectors.toList());
            dtoBuilder.availableUsers(available);
        }
    }
}