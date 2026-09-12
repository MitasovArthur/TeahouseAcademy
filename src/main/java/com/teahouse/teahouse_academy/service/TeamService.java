package com.teahouse.teahouse_academy.service;

import com.teahouse.teahouse_academy.model.dto.team.TeamManualCreateDto;
import com.teahouse.teahouse_academy.model.entity.TeamEntity;

import java.util.List;

public interface TeamService {
    TeamEntity getById(Long id);

    List<TeamEntity> getTeamsPendingReview();

    long countPendingReviews();

    List<TeamEntity> generateTeamsByShops(Long meetingId);

    void generateSingleTeamForAll(Long meetingId);

    TeamEntity createManualTeam(TeamManualCreateDto requestDto);

    TeamEntity updateTeam(Long teamId, String name, String topic, List<Long> userIds);

    void handleAdminFeedback(Long teamId, String feedback, String action);

    void delete(Long id);

    TeamEntity save(TeamEntity team);
}