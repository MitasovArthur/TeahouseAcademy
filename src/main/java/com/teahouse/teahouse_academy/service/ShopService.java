package com.teahouse.teahouse_academy.service;

import com.teahouse.teahouse_academy.model.dto.shop.ShopRequestDto;
import com.teahouse.teahouse_academy.model.entity.ShopEntity;

import java.util.List;

public interface ShopService {
    List<ShopEntity> getAll();

    ShopEntity getById(Long id);

    ShopEntity create(ShopRequestDto requestDto);

    ShopEntity update(Long id, ShopRequestDto requestDto);

    void delete(Long id);
}
