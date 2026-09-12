package com.teahouse.teahouse_academy.service.impl;

import com.teahouse.teahouse_academy.model.dto.attribute.AttributeRequestDto;
import com.teahouse.teahouse_academy.model.entity.AttributeEntity;
import com.teahouse.teahouse_academy.model.enumProject.CategoryAttribute;
import com.teahouse.teahouse_academy.repository.AttributeRepository;
import com.teahouse.teahouse_academy.service.AttributeService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AttributeServiceImpl implements AttributeService {

    private final AttributeRepository attributeRepository;

    @Override
    public AttributeEntity getById(Long id) {
        return attributeRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Attribute not found with id: " + id));
    }

    @Override
    public List<AttributeEntity> getAllAttributesById(List<Long> ids) {
        return attributeRepository.findAllById(ids);
    }

    @Override
    public List<AttributeEntity> getByCategory(CategoryAttribute category) {
        return attributeRepository.findByCategoryOrderByNameAsc(category);
    }

    @Override
    public List<AttributeEntity> getCountriesWithRegions() {
        return attributeRepository.findCountriesWithRegions(CategoryAttribute.COUNTRY);
    }

    @Override
    @Transactional
    @CacheEvict(value = {"components", "regions"}, allEntries = true)
    public AttributeEntity create(AttributeRequestDto requestDto) {
        AttributeEntity attribute = new AttributeEntity();
        attribute.setName(requestDto.getName());
        attribute.setCategory(requestDto.getCategory());

        if (requestDto.getParentId() != null) {
            AttributeEntity parent = getById(requestDto.getParentId());
            attribute.setParent(parent);
        }

        return attributeRepository.save(attribute);
    }

    @Override
    @Transactional
    @CacheEvict(value = {"components", "regions"}, allEntries = true)
    public AttributeEntity update(Long id, AttributeRequestDto requestDto) {
        AttributeEntity existing = getById(id);
        existing.setName(requestDto.getName());
        existing.setCategory(requestDto.getCategory());
        assignParent(existing, requestDto.getParentId());

        return attributeRepository.save(existing);
    }

    @Override
    @Transactional
    @CacheEvict(value = {"components", "regions"}, allEntries = true)
    public void delete(Long id) {
        if (!attributeRepository.existsById(id)) {
            throw new EntityNotFoundException("Cannot delete. Attribute not found with id: " + id);
        }
        attributeRepository.deleteById(id);
    }

    private void assignParent(AttributeEntity attribute, Long parentId) {
        if (parentId != null) {
            attribute.setParent(getById(parentId));
        } else {
            attribute.setParent(null);
        }
    }
}