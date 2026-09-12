package com.teahouse.teahouse_academy.mapper;

import com.teahouse.teahouse_academy.model.dto.user.AdminUserResponse;
import com.teahouse.teahouse_academy.model.dto.user.UserRegistrationRequest;
import com.teahouse.teahouse_academy.model.dto.user.UserSelectionResponse;
import com.teahouse.teahouse_academy.model.dto.user.UserUpdateRequest;
import com.teahouse.teahouse_academy.model.entity.UserEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring",
        unmappedTargetPolicy = ReportingPolicy.ERROR)
public interface UserMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "teams", ignore = true)
    @Mapping(target = "role", ignore = true)
    @Mapping(target = "shop", ignore = true)
    UserEntity toEntity(UserRegistrationRequest userRegistration);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "password", ignore = true)
    @Mapping(target = "teams", ignore = true)
    @Mapping(target = "shop", ignore = true)
    void updateEntity(UserUpdateRequest request,
                      @MappingTarget UserEntity user);

    @Mapping(target = "shopName", source = "shop.name", defaultValue = "Без магазину")
    @Mapping(target = "fullName", expression = "java(userEntity.getFirstName() + \" \" + userEntity.getLastName())")
    UserSelectionResponse toUserSelection(UserEntity userEntity);

    @Mapping(target = "shopName", source = "shop.name", defaultValue = "Не призначено")
    @Mapping(target = "shopId", source = "shop.id")
    @Mapping(target = "fullName", expression = "java(userEntity.getFirstName() + \" \" + userEntity.getLastName())")
    AdminUserResponse toAdminResponse(UserEntity userEntity);
}
