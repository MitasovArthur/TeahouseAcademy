package com.teahouse.teahouse_academy.service.impl;

import com.teahouse.teahouse_academy.model.dto.city.CityRequestDto;
import com.teahouse.teahouse_academy.model.entity.CityEntity;
import com.teahouse.teahouse_academy.repository.CityRepository;
import com.teahouse.teahouse_academy.repository.ShopRepository;
import com.teahouse.teahouse_academy.service.CityService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class CityServiceImpl implements CityService {

    private final CityRepository cityRepository;
    private final ShopRepository shopRepository;

    @Override
    public List<CityEntity> getAll() {
        return cityRepository.findAll();
    }

    @Override
    public CityEntity getById(Long id) {
        return cityRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("City not found with id: " + id));
    }

    @Override
    @Transactional
    public CityEntity create(CityRequestDto requestDto) {
        if (cityRepository.existsByName(requestDto.getName())) {
            throw new IllegalArgumentException("City with name already exists");
        }

        CityEntity city = new CityEntity();
        city.setName(requestDto.getName());

        return cityRepository.save(city);
    }

    @Override
    @Transactional
    public CityEntity update(Long id, CityRequestDto requestDto) {
        CityEntity existing = getById(id);

        if (!existing.getName().equals(requestDto.getName())
                && cityRepository.existsByName(requestDto.getName())) {
            throw new IllegalArgumentException("City with this name already exists");
        }

        existing.setName(requestDto.getName());

        return cityRepository.save(existing);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        if (!cityRepository.existsById(id)) {
            throw new EntityNotFoundException("Cannot delete. City not found with id: " + id);
        }

        if (shopRepository.existsByCityId(id)) {
            throw new IllegalStateException("Cannot delete city because it has associated shops");
        }
        cityRepository.deleteById(id);
    }
}