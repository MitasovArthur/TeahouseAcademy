package com.teahouse.teahouse_academy.repository;

import com.teahouse.teahouse_academy.model.entity.TeamEntity;
import com.teahouse.teahouse_academy.model.enumProject.TeamStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TeamRepository extends JpaRepository<TeamEntity, Long> {

    List<TeamEntity> findAllByStatus(TeamStatus status);

    long countByStatus(TeamStatus status);

}