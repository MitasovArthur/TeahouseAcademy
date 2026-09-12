package com.teahouse.teahouse_academy.repository;

import com.teahouse.teahouse_academy.model.entity.MeetingEntity;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MeetingRepository extends JpaRepository<MeetingEntity, Long> {

    List<MeetingEntity> findAllByIsCompletedFalseOrderByDateAsc();

    List<MeetingEntity> findAllByIsCompletedTrueOrderByDateDesc();

    @EntityGraph(attributePaths = {"teams", "teams.users", "resources"})
    @Query("SELECT m FROM MeetingEntity m WHERE m.isCompleted = false")
    List<MeetingEntity> findAllActiveWithDetails();

    @Query("SELECT DISTINCT m FROM MeetingEntity m LEFT JOIN m.tags t " +
            "WHERE m.isCompleted = true " +
            "AND (:query IS NULL OR :query = '' OR LOWER(m.name) LIKE LOWER(CONCAT('%', :query, '%'))) " +
            "AND (:filterByTags = false OR t.name IN :tags)")
    List<MeetingEntity> searchKnowledgeBase(
            @Param("query") String query,
            @Param("tags") List<String> tags,
            @Param("filterByTags") boolean filterByTags
    );
}
