package com.teahouse.teahouse_academy.mapper;

import com.teahouse.teahouse_academy.model.dto.attribute.AttributeShortDto;
import com.teahouse.teahouse_academy.model.dto.tea.TeaDto;
import com.teahouse.teahouse_academy.model.dto.tea.TeaRequestDto;
import com.teahouse.teahouse_academy.model.dto.tea.TeaShortDto;
import com.teahouse.teahouse_academy.model.entity.AttributeEntity;
import com.teahouse.teahouse_academy.model.entity.TeaEntity;
import com.teahouse.teahouse_academy.model.enumProject.CategoryAttribute;
import org.mapstruct.*;

import java.util.List;

@Mapper(componentModel = "spring",
        unmappedTargetPolicy = ReportingPolicy.ERROR)
public interface TeaMapper {

    @Mapping(target = "componentsShort", ignore = true)
    @Mapping(target = "countriesShort", ignore = true)
    @Mapping(target = "reviewShort", ignore = true) // Игнорируем, если пока не реализовано
    TeaDto toDto(TeaEntity entity);

    @AfterMapping
    default void mapAttributesToDto(TeaEntity entity, @MappingTarget TeaDto dto) {
        if (entity.getAttributes() != null) {
            List<AttributeShortDto> components = entity.getAttributes().stream()
                    .filter(attr -> attr.getCategory() == CategoryAttribute.COMPONENT)
                    .map(this::toAttributeShortDto)
                    .toList();
            dto.setComponentsShort(components);

            List<AttributeShortDto> countries = entity.getAttributes().stream()
                    .filter(attr -> attr.getCategory() == CategoryAttribute.COUNTRY)
                    .map(this::toAttributeShortDto)
                    .toList();
            dto.setCountriesShort(countries);
        }
    }

    TeaShortDto toShortDto(TeaEntity entity);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "attributes", ignore = true)
    @Mapping(target = "reviews", ignore = true)
    TeaEntity toEntity(TeaRequestDto dto);

    AttributeShortDto toAttributeShortDto(AttributeEntity attributeEntity);

    @Mapping(target = "attributeIds", source = "attributes")
    TeaRequestDto toRequestDto(TeaEntity entity);

    default Long mapAttributeToId(AttributeEntity attribute) {
        if (attribute == null) {
            return null;
        }
        return attribute.getId();
    }
}