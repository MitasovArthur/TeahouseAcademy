package com.teahouse.teahouse_academy.repository;

import com.teahouse.teahouse_academy.model.entity.SubmissionEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SubmissionRepository extends JpaRepository<SubmissionEntity, Long> {
    List<SubmissionEntity> findByTeamId(Long teamId);

    boolean existsByTeamId(Long teamId);

    long countByTeamId(Long teamId);
}
