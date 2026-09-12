package com.teahouse.teahouse_academy.model.dto.academy;

import com.teahouse.teahouse_academy.model.dto.meeting.ResourceResponseDto;
import com.teahouse.teahouse_academy.model.dto.team.TeamResponseDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AcademyDashboardResponseDto {
    private Long meetingId;
    private String meetingName;
    private String description;
    private String date;
    private boolean isOnline;
    private Integer totalTeamsCount;
    private Integer submittedTeamsCount;
    private List<ResourceResponseDto> resources;
    private List<TeamResponseDto> teams;
}
