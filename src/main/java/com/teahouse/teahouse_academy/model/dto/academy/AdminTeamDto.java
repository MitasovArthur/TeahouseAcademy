package com.teahouse.teahouse_academy.model.dto.academy;

import com.teahouse.teahouse_academy.model.dto.user.UserSelectionResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AdminTeamDto {
    private Long id;
    private String name;
    private String topic;
    private List<UserSelectionResponse> teamMembers;
}