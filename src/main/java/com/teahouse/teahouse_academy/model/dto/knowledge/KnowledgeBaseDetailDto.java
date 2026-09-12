package com.teahouse.teahouse_academy.model.dto.knowledge;

import com.teahouse.teahouse_academy.model.dto.meeting.ResourceResponseDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class KnowledgeBaseDetailDto {
    private Long id;
    private String name;
    private String fullDate;
    private String format;
    private List<ResourceResponseDto> adminResources;
    private List<KnowledgeBaseTeamDto> teams;
}