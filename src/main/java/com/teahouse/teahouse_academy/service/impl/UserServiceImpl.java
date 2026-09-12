package com.teahouse.teahouse_academy.service.impl;

import com.teahouse.teahouse_academy.model.dto.user.UserUpdateRequest;
import com.teahouse.teahouse_academy.model.entity.UserEntity;
import com.teahouse.teahouse_academy.model.enumProject.RoleUser;
import com.teahouse.teahouse_academy.repository.UserRepository;
import com.teahouse.teahouse_academy.service.ShopService;
import com.teahouse.teahouse_academy.service.UserService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final ShopService shopService;

    @Override
    public List<UserEntity> getAll() {
        return userRepository.findAll();
    }

    @Override
    public List<UserEntity> getActiveEmployees() {
        return userRepository.findByRoleNot(RoleUser.ADMIN);
    }

    @Override
    public UserEntity getById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("User not found with id: " + id));
    }

    @Override
    @Transactional
    public UserEntity update(Long id, UserUpdateRequest updateDto) {
        UserEntity existing = getById(id);

        if (!existing.getEmail().equals(updateDto.getEmail())) {
            checkEmailUnique(updateDto.getEmail());
        }

        existing.setFirstName(updateDto.getFirstName());
        existing.setLastName(updateDto.getLastName());
        existing.setEmail(updateDto.getEmail());
        existing.setRole(updateDto.getRole());
        existing.setShop(updateDto.getShopId() != null ? shopService.getById(updateDto.getShopId()) : null);

        return userRepository.save(existing);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        if (!userRepository.existsById(id)) {
            throw new EntityNotFoundException("Cannot delete. User not found with id: " + id);
        }
        userRepository.deleteById(id);
    }

    @Override
    @Transactional
    public void updateFromAdmin(Long id, Long shopId, String role) {
        UserEntity user = getById(id);
        if (shopId != null) {
            user.setShop(shopService.getById(shopId));
        } else {
            user.setShop(null);
        }

        user.setRole(RoleUser.valueOf(role));
        userRepository.save(user);
    }

    private void checkEmailUnique(String email) {
        if (userRepository.existsByEmail(email)) {
            throw new IllegalArgumentException("Email already exists: " + email);
        }
    }
}