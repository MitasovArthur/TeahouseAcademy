package com.teahouse.teahouse_academy.facade;

import com.teahouse.teahouse_academy.mapper.TeaMapper;
import com.teahouse.teahouse_academy.model.dto.attribute.AttributeShortDto;
import com.teahouse.teahouse_academy.model.dto.tea.TeaDto;
import com.teahouse.teahouse_academy.model.dto.tea.TeaFilterRequest;
import com.teahouse.teahouse_academy.model.dto.tea.TeaRequestDto;
import com.teahouse.teahouse_academy.model.entity.AttributeEntity;
import com.teahouse.teahouse_academy.model.enumProject.CategoryAttribute;
import com.teahouse.teahouse_academy.model.enumProject.TypeTea;
import com.teahouse.teahouse_academy.service.AttributeService;
import com.teahouse.teahouse_academy.service.TeaService;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class TeaFacade {

    private final TeaService teaService;
    private final AttributeService attributeService;
    private final TeaMapper mapper;

    public Page<TeaDto> search(String keyword, String type, Pageable pageable) {
        TeaFilterRequest filter = new TeaFilterRequest();
        filter.setKeyword(keyword);
        filter.setType(parseTeaType(type));
        return teaService.search(filter, pageable).map(mapper::toDto);
    }

    public void createNewTea(TeaRequestDto teaRequestDto) {
        teaService.create(teaRequestDto);
    }

    public void updateTea(Long id, TeaRequestDto teaRequestDto) {
        teaService.update(id, teaRequestDto);
    }

    public void deleteTea(Long id) {
        teaService.delete(id);
    }

    public TeaDto getById(Long id) {
        return mapper.toDto(teaService.getById(id));
    }

    public TeaRequestDto getRequestDtoById(Long id) {
        return mapper.toRequestDto(teaService.getById(id));
    }

    public List<AttributeShortDto> getComponents() {
        return attributeService.getByCategory(CategoryAttribute.COMPONENT).stream()
                .map(mapper::toAttributeShortDto)
                .toList();
    }

    public List<AttributeShortDto> getCountries() {
        return attributeService.getByCategory(CategoryAttribute.COUNTRY).stream()
                .map(mapper::toAttributeShortDto)
                .toList();
    }

    public List<AttributeShortDto> getRegions() {
        return attributeService.getByCategory(CategoryAttribute.REGION).stream()
                .map(mapper::toAttributeShortDto)
                .toList();
    }

    @Cacheable("components")
    public Map<String, List<String>> getComponentsDictionary() {
        List<AttributeEntity> components = attributeService.getByCategory(CategoryAttribute.COMPONENT);

        Map<String, List<String>> grouped = new TreeMap<>();
        for (AttributeEntity attr : components) {
            String name = attr.getName();
            if (name == null || name.isBlank()) continue;
            String letter = name.substring(0, 1).toUpperCase();
            grouped.computeIfAbsent(letter, k -> new ArrayList<>()).add(name);
        }
        return grouped;
    }

    @Cacheable("regions")
    public Map<String, List<String>> getRegionsDictionary() {
        List<AttributeEntity> countries = attributeService.getCountriesWithRegions();

        return countries.stream()
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

    private TypeTea parseTeaType(String type) {
        if (type == null || type.isBlank()) return null;
        try {
            return TypeTea.valueOf(type);
        } catch (IllegalArgumentException e) {
            return null;
        }
    }
}