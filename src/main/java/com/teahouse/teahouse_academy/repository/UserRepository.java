package com.teahouse.teahouse_academy.repository;

import com.teahouse.teahouse_academy.model.entity.UserEntity;
import com.teahouse.teahouse_academy.model.enumProject.RoleUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<UserEntity, Long> {

    List<UserEntity> findByRoleNot(RoleUser role);

    Optional<UserEntity> findByEmail(String email);

    boolean existsByEmail(String email);

    boolean existsByShopId(Long shopId);
}