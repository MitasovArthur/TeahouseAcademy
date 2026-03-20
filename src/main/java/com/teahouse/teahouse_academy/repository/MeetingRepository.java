package com.teahouse.teahouse_academy.repository;

import com.teahouse.teahouse_academy.model.entity.MeetingEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MeetingRepository extends JpaRepository<MeetingEntity, Long> {
}
