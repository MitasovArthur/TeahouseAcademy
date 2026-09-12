package com.teahouse.teahouse_academy.facade;

import com.teahouse.teahouse_academy.mapper.AcademyMapper;
import com.teahouse.teahouse_academy.model.dto.academy.AcademyDashboardResponseDto;
import com.teahouse.teahouse_academy.model.entity.MeetingEntity;
import com.teahouse.teahouse_academy.model.entity.UserEntity;
import com.teahouse.teahouse_academy.model.enumProject.RoleUser;
import com.teahouse.teahouse_academy.service.MeetingService;
import com.teahouse.teahouse_academy.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@RequiredArgsConstructor
public class DashboardFacade {

    private final UserService userService;
    private final MeetingService meetingService;

    private final AcademyMapper academyMapper;

    public List<AcademyDashboardResponseDto> getDashboardData(Long userId) {
        UserEntity currentUser = userService.getById(userId);
        boolean isAdmin = currentUser.getRole() == RoleUser.ADMIN;

        List<MeetingEntity> activeMeetings = meetingService.getActivityMeetingWithDetail();

        if (!isAdmin) {
            activeMeetings = activeMeetings.stream()
                    .filter(m -> m.getTeams() != null && m.getTeams().stream()
                            .anyMatch(team -> team.getUsers() != null && team.getUsers().contains(currentUser)))
                    .toList();
        }

        return activeMeetings.stream()
                .map(meeting -> academyMapper.toDashboard(meeting, userId))
                .toList();
    }
}

