package com.teahouse.teahouse_academy.repository;

import com.teahouse.teahouse_academy.model.entity.ShopEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ShopRepository extends JpaRepository<ShopEntity, Long> {
    List<ShopEntity> findByCityId(Long cityId);
    boolean existsByCityId(Long cityId);
}
