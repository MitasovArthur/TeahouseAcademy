package com.teahouse.teahouse_academy.model.dto.team;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TeamManualCreateDto {
    @NotBlank
    private String name;

    private String subtopic;

    @NotNull
    private Long meetingId;

    @NotEmpty
    private List<Long> userIds;
}
