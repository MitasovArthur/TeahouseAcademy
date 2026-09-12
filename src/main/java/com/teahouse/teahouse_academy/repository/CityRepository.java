package com.teahouse.teahouse_academy.repository;

import com.teahouse.teahouse_academy.model.entity.CityEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CityRepository extends JpaRepository<CityEntity, Long> {
    boolean existsByName(String name);
}
