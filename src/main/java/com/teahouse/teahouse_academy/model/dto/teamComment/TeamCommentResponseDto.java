package com.teahouse.teahouse_academy.model.dto.teamComment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TeamCommentResponseDto {
    private String text;
    private String actionType;
    private String createdAt;
}