package com.teahouse.teahouse_academy.model.dto.meeting;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MeetingRequestDto {

    @NotBlank
    private String name;

    @NotBlank
    private String description;

    @NotNull
    private LocalDate date;

    @NotNull
    private Boolean isOnline;
}
