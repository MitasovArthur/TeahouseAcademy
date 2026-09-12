package com.teahouse.teahouse_academy.repository;

import com.teahouse.teahouse_academy.model.entity.TeamCommentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TeamCommentRepository extends JpaRepository<TeamCommentEntity, Long> {
    List<TeamCommentEntity> findByTeamIdOrderByCreatedAtDesc(Long teamId);
}