package com.teahouse.teahouse_academy.repository;

import com.teahouse.teahouse_academy.model.entity.TeaEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TeaRepository extends JpaRepository<TeaEntity,Long> {
}
