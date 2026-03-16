package com.teahouse.teahouse_academy.service;

import com.teahouse.teahouse_academy.model.dto.attribute.AttributeShortDto;
import com.teahouse.teahouse_academy.model.enumProject.CategoryAttribute;

import java.util.List;
import java.util.Map;

public interface AttributeService {

    List<AttributeShortDto> getAllAttributes();

    Map<String, List<String>> getComponentsGroupedByLetter();

    Map<String, List<String>> getRegionsGroupedByCountry();

    List<AttributeShortDto> getByCategory(CategoryAttribute category);
}