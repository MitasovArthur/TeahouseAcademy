package com.teahouse.teahouse_academy.model.dto.academy;

import com.teahouse.teahouse_academy.model.dto.meeting.ResourceResponseDto;
import com.teahouse.teahouse_academy.model.dto.user.UserSelectionResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AdminMeetingDto {
    private Long id;
    private String name;
    private String description;
    private String date;
    private String format;
    private int teamsCount;
    private int resourcesCount;
    private List<AdminTeamDto> teams;
    private List<UserSelectionResponse> availableUsers;
    private boolean isPast;
    private List<ResourceResponseDto> resources;
}