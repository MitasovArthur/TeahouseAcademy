package com.teahouse.teahouse_academy.model.dto.submission;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SubmissionCreateDto {

    @NotNull
    private Long teamId;

    @NotBlank()
    private String url;
}