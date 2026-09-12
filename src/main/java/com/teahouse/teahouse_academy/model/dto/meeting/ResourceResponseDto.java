package com.teahouse.teahouse_academy.model.dto.meeting;

import com.teahouse.teahouse_academy.model.enumProject.ResourceType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ResourceResponseDto {
    private Long id;
    private String fileName;
    private String title;
    private String url;
    private ResourceType type;
}