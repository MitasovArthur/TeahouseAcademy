package com.teahouse.teahouse_academy.model.dto.knowledge;

import com.teahouse.teahouse_academy.model.enumProject.ResourceType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class KnowledgeBaseSubmissionDto {
    private String fileName;
    private String url;
    private ResourceType type;
}