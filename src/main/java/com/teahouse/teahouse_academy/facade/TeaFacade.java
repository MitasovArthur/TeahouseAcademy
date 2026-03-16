package com.teahouse.teahouse_academy.facade;

import com.teahouse.teahouse_academy.mapper.TeaMapper;
import com.teahouse.teahouse_academy.model.dto.attribute.AttributeShortDto;
import com.teahouse.teahouse_academy.model.dto.tea.TeaDto;
import com.teahouse.teahouse_academy.model.dto.tea.TeaFilterRequest;
import com.teahouse.teahouse_academy.model.dto.tea.TeaRequestDto;
import com.teahouse.teahouse_academy.model.entity.AttributeEntity;
import com.teahouse.teahouse_academy.model.entity.TeaEntity;
import com.teahouse.teahouse_academy.model.enumProject.CategoryAttribute;
import com.teahouse.teahouse_academy.model.enumProject.TypeTea;
import com.teahouse.teahouse_academy.service.AttributeService;
import com.teahouse.teahouse_academy.service.TeaService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

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

    public TeaDto createNewTea(TeaRequestDto teaRequestDto) {
        return mapper.toDto(teaService.create(teaRequestDto));
    }

    public TeaDto updateTea(Long id, TeaRequestDto teaRequestDto) {
        return mapper.toDto(teaService.update(id, teaRequestDto));
    }

    public void deleteTea(Long id) {
        teaService.delete(id);
    }

    public Map<String, List<String>> getComponentsDictionary() {
        return attributeService.getComponentsGroupedByLetter();
    }

    public Map<String, List<String>> getRegionsDictionary() {
        return attributeService.getRegionsGroupedByCountry();
    }

    public TeaDto getById(Long id) {
        return mapper.toDto(teaService.getById(id));
    }

    public TeaRequestDto getRequestDtoById(Long id) {
        TeaEntity teaEntity = teaService.getById(id);

        TeaRequestDto request = new TeaRequestDto();
        request.setCodeTea(teaEntity.getCodeTea());
        request.setName(teaEntity.getName());
        request.setType(teaEntity.getType());
        request.setDescription(teaEntity.getDescription());
        request.setAttributeIds(
                teaEntity.getAttributes().stream()
                        .map(AttributeEntity::getId)
                        .toList()
        );
        return request;
    }

    public List<AttributeShortDto> getAllAttributes() {
        return attributeService.getAllAttributes();
    }

    public List<AttributeShortDto> getComponents() {
        return attributeService.getByCategory(CategoryAttribute.COMPONENT);
    }

    public List<AttributeShortDto> getCountries() {
        return attributeService.getByCategory(CategoryAttribute.COUNTRY);
    }

    public List<AttributeShortDto> getRegions() {
        return attributeService.getByCategory(CategoryAttribute.REGION);
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