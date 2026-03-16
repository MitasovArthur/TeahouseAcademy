package com.teahouse.teahouse_academy.service.impl;

import com.teahouse.teahouse_academy.model.dto.tea.TeaFilterRequest;
import com.teahouse.teahouse_academy.model.dto.tea.TeaRequestDto;
import com.teahouse.teahouse_academy.model.entity.AttributeEntity;
import com.teahouse.teahouse_academy.model.entity.TeaEntity;
import com.teahouse.teahouse_academy.repository.AttributeRepository;
import com.teahouse.teahouse_academy.repository.TeaRepository;
import com.teahouse.teahouse_academy.service.TeaService;
import com.teahouse.teahouse_academy.specification.TeaSpecification;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TeaServiceImpl implements TeaService {

    private final TeaRepository teaRepository;
    private final AttributeRepository attributeRepository;

    @Override
    @Transactional(readOnly = true)
    public Page<TeaEntity> getAll(Pageable page) {
        return teaRepository.findAll(page);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<TeaEntity> search(TeaFilterRequest filter, Pageable pageable) {
        Specification<TeaEntity> spec = Specification
                .where(TeaSpecification.hasKeyword(filter.getKeyword()))
                .and(TeaSpecification.hasType(filter.getType()));

        return teaRepository.findAll(spec, pageable);
    }

    @Override
    @Transactional(readOnly = true)
    public TeaEntity getById(Long id) {
        return teaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Tea not found with id: " + id));
    }

    @Override
    @Transactional
    public TeaEntity create(TeaRequestDto requestDto) {
        if (teaRepository.existsByCodeTea(requestDto.getCodeTea())) {
            throw new IllegalArgumentException("Code already exists");
        }
        TeaEntity tea = new TeaEntity();
        tea.setName(requestDto.getName());
        tea.setCodeTea(requestDto.getCodeTea());
        tea.setType(requestDto.getType());
        tea.setDescription(requestDto.getDescription());

        List<AttributeEntity> attributes = attributeRepository
                .findAllById(requestDto.getAttributeIds());
        tea.setAttributes(attributes);

        return teaRepository.save(tea);
    }

    @Override
    @Transactional
    public TeaEntity update(Long id, TeaRequestDto requestDto) {

        TeaEntity existing = teaRepository
                .findById(id)
                .orElseThrow(() -> new RuntimeException("Cannot update. Tea not found with id: " + id));

        existing.setCodeTea(requestDto.getCodeTea());

        if (!existing.getCodeTea().equals(requestDto.getCodeTea())
                && teaRepository.existsByCodeTea(requestDto.getCodeTea())) {
            throw new IllegalArgumentException("Tea with this code already exists");
        }

        existing.setType(requestDto.getType());
        existing.setName(requestDto.getName());
        existing.setDescription(requestDto.getDescription());

        List<AttributeEntity> attributes = attributeRepository
                .findAllById(requestDto.getAttributeIds());
        existing.setAttributes(attributes);

        return teaRepository.save(existing);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        if (!teaRepository.existsById(id)) {
            throw new RuntimeException("Cannot delete. Tea not found with id: " + id);
        }
        teaRepository.deleteById(id);
    }
}