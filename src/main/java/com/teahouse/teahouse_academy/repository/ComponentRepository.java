package com.teahouse.teahouse_academy.repository;

import com.teahouse.teahouse_academy.model.entity.ComponentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ComponentRepository extends JpaRepository<ComponentEntity, Long> {
}
