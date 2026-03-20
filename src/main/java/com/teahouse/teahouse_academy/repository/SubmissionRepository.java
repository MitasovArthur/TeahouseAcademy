package com.teahouse.teahouse_academy.repository;

import com.teahouse.teahouse_academy.model.entity.SubmissionEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SubmissionRepository extends JpaRepository<SubmissionEntity, Long> {
}
