package com.teahouse.teahouse_academy.repository;

import com.teahouse.teahouse_academy.model.entity.TagEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TagRepository extends JpaRepository<TagEntity, Long> {
    Optional<TagEntity> findByNameIgnoreCase(String name);
}