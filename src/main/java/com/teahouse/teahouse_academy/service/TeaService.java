package com.teahouse.teahouse_academy.service;

import com.teahouse.teahouse_academy.model.dto.tea.TeaFilterRequest;
import com.teahouse.teahouse_academy.model.dto.tea.TeaRequestDto;
import com.teahouse.teahouse_academy.model.entity.TeaEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;


public interface TeaService {

    Page<TeaEntity> getAll(Pageable page);

    Page<TeaEntity> search(TeaFilterRequest filter, Pageable pageable);

    TeaEntity getById(Long id);

    TeaEntity create(TeaRequestDto requestDto);

    TeaEntity update(Long id, TeaRequestDto requestDto);

    void delete(Long id);

}