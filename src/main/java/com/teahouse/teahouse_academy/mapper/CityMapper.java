package com.teahouse.teahouse_academy.mapper;

import com.teahouse.teahouse_academy.model.dto.city.CityRequestDto;
import com.teahouse.teahouse_academy.model.dto.city.CityShortDto;
import com.teahouse.teahouse_academy.model.entity.CityEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.ERROR)
public interface CityMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "shops", ignore = true)
    CityEntity toEntity(CityRequestDto cityRequestDto);

    CityShortDto toCityShort(CityEntity cityEntity);
}
