package com.teahouse.teahouse_academy.service;

import com.teahouse.teahouse_academy.model.dto.user.UserUpdateRequest;
import com.teahouse.teahouse_academy.model.entity.UserEntity;

import java.util.List;

public interface UserService {
    List<UserEntity> getAll();

    List<UserEntity> getActiveEmployees();

    UserEntity getById(Long id);

    UserEntity update(Long id, UserUpdateRequest updateDto);

    void delete(Long id);

    void updateFromAdmin(Long id, Long shopId, String role);

}