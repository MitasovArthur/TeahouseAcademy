package com.teahouse.teahouse_academy.service;

import com.teahouse.teahouse_academy.model.entity.TeaEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;


public interface TeaService {

    Page<TeaEntity> getAll(Pageable page);

    TeaEntity getById(Long id);

    TeaEntity create(TeaEntity tea);

    TeaEntity update(TeaEntity updateTea);

    void delete(Long id);


}