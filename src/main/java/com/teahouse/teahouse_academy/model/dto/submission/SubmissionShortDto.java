package com.teahouse.teahouse_academy.model.dto.submission;

import com.teahouse.teahouse_academy.model.enumProject.ResourceType;
import lombok.Data;

@Data
public class SubmissionShortDto {
    private Long id;
    private String fileLink;
    private String fileName;
    private ResourceType type;
}