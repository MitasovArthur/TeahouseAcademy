package com.teahouse.teahouse_academy.service;

import com.teahouse.teahouse_academy.model.entity.TagEntity;

import java.util.List;

public interface TagService {
    List<TagEntity> getAllTags();

    List<TagEntity> getOrCreateTags(List<String> tagNames);
}
