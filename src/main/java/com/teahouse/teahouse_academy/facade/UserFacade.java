package com.teahouse.teahouse_academy.facade;

import com.teahouse.teahouse_academy.mapper.UserMapper;
import com.teahouse.teahouse_academy.model.dto.user.AdminUserResponse;
import com.teahouse.teahouse_academy.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class UserFacade {

    private final UserService userService;

    private final UserMapper userMapper;

    public List<AdminUserResponse> getAllUsersForAdmin() {
        return userService.getAll().stream()
                .map(userMapper::toAdminResponse)
                .collect(Collectors.toList());
    }
}