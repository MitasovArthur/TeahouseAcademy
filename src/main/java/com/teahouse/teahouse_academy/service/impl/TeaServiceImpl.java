package com.teahouse.teahouse_academy.service.impl;

import com.teahouse.teahouse_academy.model.entity.TeaEntity;
import com.teahouse.teahouse_academy.repository.TeaRepository;
import com.teahouse.teahouse_academy.service.TeaService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class TeaServiceImpl implements TeaService {

    private final TeaRepository teaRepository;

    @Override
    @Transactional(readOnly = true)
    public Page<TeaEntity> getAll(Pageable page) {
        return teaRepository.findAll(page);
    }

    @Override
    @Transactional(readOnly = true)
    public TeaEntity getById(Long id) {
        return teaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Tea not found with id: " + id));
    }

    @Override
    @Transactional
    public TeaEntity create(TeaEntity tea) {
        if (teaRepository.existsByCodeTea(tea.getCodeTea())) {
            throw new RuntimeException("Tea with this code already exists: " + tea.getCodeTea());
        }
        return teaRepository.save(tea);
    }

    @Override
    @Transactional
    public TeaEntity update(TeaEntity updateTea) {
        if (updateTea.getId() == null || !teaRepository.existsById(updateTea.getId())) {
            throw new RuntimeException("Cannot update. Tea not found with id: " + updateTea.getId());
        }
        return teaRepository.save(updateTea);
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