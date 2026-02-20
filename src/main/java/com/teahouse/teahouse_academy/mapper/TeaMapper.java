package com.teahouse.teahouse_academy.mapper;

import com.teahouse.teahouse_academy.model.dto.tea.TeaCreateDto;
import com.teahouse.teahouse_academy.model.dto.tea.TeaDto;
import com.teahouse.teahouse_academy.model.dto.tea.TeaShortDto;
import com.teahouse.teahouse_academy.model.dto.tea.TeaUpdateDto;
import com.teahouse.teahouse_academy.model.entity.TeaEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface TeaMapper {
    TeaDto toDto(TeaEntity entity);

    TeaShortDto toShortDto(TeaEntity entity);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "components", ignore = true)
    TeaEntity toEntity(TeaCreateDto dto);

    void updateEntity(TeaUpdateDto dto, @MappingTarget TeaEntity entity);
}
