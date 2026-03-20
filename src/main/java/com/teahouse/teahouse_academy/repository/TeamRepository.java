package com.teahouse.teahouse_academy.repository;

import com.teahouse.teahouse_academy.model.entity.TeamEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TeamRepository extends JpaRepository<TeamEntity, Long> {
}
