package com.teahouse.teahouse_academy.facade;

import com.teahouse.teahouse_academy.mapper.AcademyMapper;
import com.teahouse.teahouse_academy.mapper.UserMapper;
import com.teahouse.teahouse_academy.model.dto.academy.AdminMeetingDto;
import com.teahouse.teahouse_academy.model.dto.user.UserSelectionResponse;
import com.teahouse.teahouse_academy.model.entity.MeetingEntity;
import com.teahouse.teahouse_academy.service.MeetingService;
import com.teahouse.teahouse_academy.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Component
@RequiredArgsConstructor
public class AdminAcademyFacade {

    private final UserService userService;
    private final MeetingService meetingService;

    private final AcademyMapper academyMapper;
    private final UserMapper userMapper;

    public List<AdminMeetingDto> getActiveMeetings() {
        List<MeetingEntity> activeMeetings = meetingService.getMeetingsInProgress();
        return mapMeetingList(activeMeetings);
    }

    public List<AdminMeetingDto> getArchivedMeetings() {
        List<MeetingEntity> archivedMeetings = meetingService.getMeetingsInArchive();
        return mapMeetingList(archivedMeetings);
    }

    private List<AdminMeetingDto> mapMeetingList(List<MeetingEntity> meetings) {
        List<UserSelectionResponse> allUsers = getUsersForTeamCreation();

        return meetings.stream().map(meeting -> {
            Set<Long> assignedUserIds = new HashSet<>();
            return academyMapper.toAdminMeeting(meeting, assignedUserIds, allUsers);
        }).toList();
    }

    public List<UserSelectionResponse> getUsersForTeamCreation() {
        return userService.getActiveEmployees().stream()
                .map(userMapper::toUserSelection)
                .toList();
    }
}