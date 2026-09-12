package com.teahouse.teahouse_academy.model.dto.knowledge;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class KnowledgeBaseTeamDto {
    private String name;
    private String topic;
    private List<KnowledgeBaseSubmissionDto> submissions;
}