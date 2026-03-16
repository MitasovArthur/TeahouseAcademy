package com.teahouse.teahouse_academy.specification;

import com.teahouse.teahouse_academy.model.entity.AttributeEntity;
import com.teahouse.teahouse_academy.model.entity.TeaEntity;
import com.teahouse.teahouse_academy.model.enumProject.CategoryAttribute;
import com.teahouse.teahouse_academy.model.enumProject.TypeTea;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

public final class TeaSpecification {

    private TeaSpecification() {}

    public static Specification<TeaEntity> hasKeyword(String keyword) {
        return (root, query, cb) -> {
            if (keyword == null || keyword.isBlank()) return null;

            query.distinct(true);
            Join<TeaEntity, AttributeEntity> attrs =
                    root.join("attributes", JoinType.LEFT);
            String pattern = "%" + keyword.toLowerCase() + "%";

            return cb.or(
                    cb.like(cb.lower(root.get("name")), pattern),
                    cb.like(cb.lower(root.get("description")), pattern),
                    cb.like(cb.lower(attrs.get("name")), pattern)
            );
        };
    }

    public static Specification<TeaEntity> hasType(TypeTea type) {
        return (root, query, cb) ->
                type == null ? null : cb.equal(root.get("type"), type);
    }

    public static Specification<TeaEntity> hasAttributeInCategories(
            String attributeName,
            List<CategoryAttribute> categories) {
        return (root, query, cb) -> {
            if (attributeName == null || attributeName.isBlank()) return null;

            query.distinct(true);
            Join<TeaEntity, AttributeEntity> attrs =
                    root.join("attributes", JoinType.LEFT);

            String pattern = "%" + attributeName.toLowerCase() + "%";

            return cb.and(
                    attrs.get("category").in(categories),
                    cb.like(cb.lower(attrs.get("name")), pattern)
            );
        };
    }
}
