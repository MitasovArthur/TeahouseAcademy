package com.teahouse.teahouse_academy.mapper;

import com.teahouse.teahouse_academy.model.dto.shop.ShopDto;
import com.teahouse.teahouse_academy.model.dto.shop.ShopRequestDto;
import com.teahouse.teahouse_academy.model.entity.ShopEntity;
import com.teahouse.teahouse_academy.model.entity.UserEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.ERROR)
public interface ShopMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(source = "cityId", target = "city.id")
    @Mapping(target = "workers", ignore = true)
    ShopEntity toShopEntity(ShopRequestDto shopRequestDto);

    @Mapping(source = "city.id", target = "cityId")
    @Mapping(source = "city.name", target = "cityName")
    @Mapping(target = "employeeCount", expression = "java(shopEntity.getWorkers() != null ? shopEntity.getWorkers().size() : 0)")
    @Mapping(source = "workers", target = "workerNames")
    ShopDto toShopDto(ShopEntity shopEntity);

    default String mapWorkerName(UserEntity user) {
        if (user == null) {
            return null;
        }

        return user.getFirstName() + " " + user.getLastName();
    }
}