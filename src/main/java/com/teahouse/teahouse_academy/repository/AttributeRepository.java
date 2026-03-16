package com.teahouse.teahouse_academy.repository;

import com.teahouse.teahouse_academy.model.entity.AttributeEntity;
import com.teahouse.teahouse_academy.model.enumProject.CategoryAttribute;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AttributeRepository extends JpaRepository<AttributeEntity, Long> {

    List<AttributeEntity> findByCategoryInOrderByNameAsc(List<CategoryAttribute> categories);

    List<AttributeEntity> findByCategoryOrderByNameAsc(CategoryAttribute category);

    @Query("""
        SELECT DISTINCT a FROM AttributeEntity a
        LEFT JOIN FETCH a.children
        WHERE a.category = :category
        ORDER BY a.name
    """)
    List<AttributeEntity> findCountriesWithRegions(@Param("category") CategoryAttribute category);
}