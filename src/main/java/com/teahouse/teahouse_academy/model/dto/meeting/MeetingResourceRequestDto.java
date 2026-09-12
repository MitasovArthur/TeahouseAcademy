package com.teahouse.teahouse_academy.model.dto.meeting;

import com.teahouse.teahouse_academy.model.enumProject.ResourceType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MeetingResourceRequestDto {

    @NotBlank
    private String title;

    @NotBlank
    private String url;

    @NotNull
    private ResourceType type;
}
