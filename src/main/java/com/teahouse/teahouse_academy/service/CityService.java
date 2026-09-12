package com.teahouse.teahouse_academy.service;

import com.teahouse.teahouse_academy.model.dto.city.CityRequestDto;
import com.teahouse.teahouse_academy.model.entity.CityEntity;

import java.util.List;

public interface CityService {
    List<CityEntity> getAll();

    CityEntity getById(Long id);

    CityEntity create(CityRequestDto requestDto);

    CityEntity update(Long id, CityRequestDto requestDto);

    void delete(Long id);
}
