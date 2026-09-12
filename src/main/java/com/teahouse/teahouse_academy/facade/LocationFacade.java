package com.teahouse.teahouse_academy.facade;

import com.teahouse.teahouse_academy.mapper.CityMapper;
import com.teahouse.teahouse_academy.mapper.ShopMapper;
import com.teahouse.teahouse_academy.model.dto.city.CityRequestDto;
import com.teahouse.teahouse_academy.model.dto.city.CityShortDto;
import com.teahouse.teahouse_academy.model.dto.shop.ShopDto;
import com.teahouse.teahouse_academy.model.dto.shop.ShopRequestDto;
import com.teahouse.teahouse_academy.service.CityService;
import com.teahouse.teahouse_academy.service.ShopService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class LocationFacade {

    private final ShopService shopService;
    private final CityService cityService;

    private final ShopMapper shopMapper;
    private final CityMapper cityMapper;

    public List<ShopDto> getAllShopsWithStats() {
        return shopService.getAll().stream()
                .map(shopMapper::toShopDto)
                .collect(Collectors.toList());
    }

    public List<CityShortDto> getAllCities() {
        return cityService.getAll().stream()
                .map(cityMapper::toCityShort)
                .collect(Collectors.toList());
    }

    public void createShop(ShopRequestDto dto) {
        shopService.create(dto);
    }

    public void updateShop(Long id, ShopRequestDto dto) {
        shopService.update(id, dto);
    }

    public void deleteShop(Long id) {
        shopService.delete(id);
    }

    public void createCity(CityRequestDto dto) {
        cityService.create(dto);
    }
}