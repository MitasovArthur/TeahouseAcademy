package com.teahouse.teahouse_academy.service;

import com.teahouse.teahouse_academy.model.dto.attribute.AttributeRequestDto;
import com.teahouse.teahouse_academy.model.entity.AttributeEntity;
import com.teahouse.teahouse_academy.model.enumProject.CategoryAttribute;

import java.util.List;

public interface AttributeService {
    AttributeEntity getById(Long id);

    List<AttributeEntity> getAllAttributesById(List<Long> ids);

    List<AttributeEntity> getByCategory(CategoryAttribute category);

    List<AttributeEntity> getCountriesWithRegions();

    AttributeEntity create(AttributeRequestDto requestDto);

    AttributeEntity update(Long id, AttributeRequestDto requestDto);

    void delete(Long id);
}