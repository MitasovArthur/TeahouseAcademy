package com.teahouse.teahouse_academy.mapper;

import com.teahouse.teahouse_academy.model.dto.attribute.AttributeShortDto;
import com.teahouse.teahouse_academy.model.dto.tea.TeaDto;
import com.teahouse.teahouse_academy.model.dto.tea.TeaRequestDto;
import com.teahouse.teahouse_academy.model.dto.tea.TeaShortDto;
import com.teahouse.teahouse_academy.model.entity.AttributeEntity;
import com.teahouse.teahouse_academy.model.entity.TeaEntity;
import com.teahouse.teahouse_academy.model.enumProject.CategoryAttribute;
import org.mapstruct.AfterMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import java.util.List;

@Mapper(componentModel = "spring")
public interface TeaMapper {

    @Mapping(target = "componentsShort", ignore = true)
    TeaDto toDto(TeaEntity entity);

    @AfterMapping
    default void mapAttributesToDto(TeaEntity entity, @MappingTarget TeaDto dto) {
        if (entity.getAttributes() != null) {
            List<AttributeShortDto> components = entity.getAttributes().stream()
                    .filter(attr -> attr.getCategory() == CategoryAttribute.COMPONENT)
                    .map(this::toAttributeShortDto)
                    .toList();
            dto.setComponentsShort(components);
        }
    }

    TeaShortDto toShortDto(TeaEntity entity);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "attributes", ignore = true)
    TeaEntity toEntity(TeaRequestDto dto);

    AttributeShortDto toAttributeShortDto(AttributeEntity attributeEntity);
}