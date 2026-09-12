package com.teahouse.teahouse_academy.model.dto.team;

import com.teahouse.teahouse_academy.model.dto.submission.SubmissionShortDto;
import com.teahouse.teahouse_academy.model.dto.teamComment.TeamCommentResponseDto;
import com.teahouse.teahouse_academy.model.enumProject.TeamStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TeamResponseDto {
    private Long id;
    private String name;
    private String subtopic;
    private List<String> userFullNames;
    private TeamStatus status;
    private boolean isSubmitted;
    private boolean isMyTeam;
    private String submissionDate;
    private List<SubmissionShortDto> submissions;
    private List<TeamCommentResponseDto> comments;
}