package com.teahouse.teahouse_academy.service.impl;

import com.teahouse.teahouse_academy.model.dto.attribute.AttributeShortDto;
import com.teahouse.teahouse_academy.model.entity.AttributeEntity;
import com.teahouse.teahouse_academy.model.enumProject.CategoryAttribute;
import com.teahouse.teahouse_academy.repository.AttributeRepository;
import com.teahouse.teahouse_academy.service.AttributeService;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AttributeServiceImpl implements AttributeService {

    private final AttributeRepository attributeRepository;

    @Override
    @Cacheable("components")
    public Map<String, List<String>> getComponentsGroupedByLetter() {
        List<String> names = attributeRepository
                .findByCategoryInOrderByNameAsc(
                        List.of(CategoryAttribute.COMPONENT)
                )
                .stream()
                .map(AttributeEntity::getName)
                .toList();

        return groupByFirstLetter(names);
    }

    @Override
    @Cacheable("regions")
    public Map<String, List<String>> getRegionsGroupedByCountry() {
        return attributeRepository
                .findCountriesWithRegions(CategoryAttribute.COUNTRY)
                .stream()
                .collect(Collectors.toMap(
                        AttributeEntity::getName,
                        country -> country.getChildren().stream()
                                .map(AttributeEntity::getName)
                                .sorted()
                                .toList(),
                        (a, b) -> a,
                        LinkedHashMap::new
                ));
    }

    private Map<String, List<String>> groupByFirstLetter(List<String> names) {
        Map<String, List<String>> grouped = new TreeMap<>();
        for (String name : names) {
            if (name == null || name.isBlank()) continue;
            String letter = name.substring(0, 1).toUpperCase();
            grouped.computeIfAbsent(letter, k -> new ArrayList<>()).add(name);
        }
        return grouped;
    }

    @Override
    public List<AttributeShortDto> getAllAttributes() {
        return attributeRepository.findAll().stream()
                .map(a -> new AttributeShortDto(a.getId(), a.getName()))
                .toList();
    }

    @Override
    public List<AttributeShortDto> getByCategory(CategoryAttribute category) {
        return attributeRepository.findByCategoryOrderByNameAsc(category).stream()
                .map(a -> new AttributeShortDto(a.getId(), a.getName()))
                .toList();
    }
}