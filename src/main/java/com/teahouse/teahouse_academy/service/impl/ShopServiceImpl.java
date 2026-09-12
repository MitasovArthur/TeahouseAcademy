package com.teahouse.teahouse_academy.service.impl;

import com.teahouse.teahouse_academy.model.dto.shop.ShopRequestDto;
import com.teahouse.teahouse_academy.model.entity.CityEntity;
import com.teahouse.teahouse_academy.model.entity.ShopEntity;
import com.teahouse.teahouse_academy.repository.ShopRepository;
import com.teahouse.teahouse_academy.repository.UserRepository;
import com.teahouse.teahouse_academy.service.CityService;
import com.teahouse.teahouse_academy.service.ShopService;
import com.teahouse.teahouse_academy.service.UserService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ShopServiceImpl implements ShopService {

    private final ShopRepository shopRepository;
    private final CityService cityService;
    private final UserRepository userRepository;

    @Override
    public List<ShopEntity> getAll() {
        return shopRepository.findAll();
    }

    @Override
    public ShopEntity getById(Long id) {
        return shopRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Shop not finding is id: " + id));
    }

    @Override
    @Transactional
    public ShopEntity create(ShopRequestDto requestDto) {
        CityEntity city = cityService.getById(requestDto.getCityId());

        ShopEntity shop = new ShopEntity();
        shop.setName(requestDto.getName());
        shop.setAddress(requestDto.getAddress());
        shop.setCity(city);

        return shopRepository.save(shop);
    }

    @Override
    @Transactional
    public ShopEntity update(Long id, ShopRequestDto requestDto) {
        ShopEntity existing = getById(id);

        CityEntity city = cityService.getById(requestDto.getCityId());

        existing.setName(requestDto.getName());
        existing.setAddress(requestDto.getAddress());
        existing.setCity(city);

        return shopRepository.save(existing);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        if (!shopRepository.existsById(id)) {
            throw new EntityNotFoundException("Store not found with id:" + id);
        }
        if (userRepository.existsByShopId(id)) {
            throw new IllegalStateException("Cannot delete: the store has active employees");
        }
        shopRepository.deleteById(id);
    }

}
