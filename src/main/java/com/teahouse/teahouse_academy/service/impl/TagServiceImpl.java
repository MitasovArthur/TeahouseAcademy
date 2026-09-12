package com.teahouse.teahouse_academy.service.impl;

import com.teahouse.teahouse_academy.model.entity.TagEntity;
import com.teahouse.teahouse_academy.repository.TagRepository;
import com.teahouse.teahouse_academy.service.TagService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class TagServiceImpl implements TagService {

    private final TagRepository tagRepository;

    public List<TagEntity> getAllTags() {
        return tagRepository.findAll(Sort.by(Sort.Direction.ASC, "name"));
    }

    @Override
    @Transactional
    public List<TagEntity> getOrCreateTags(List<String> tagNames) {
        if (tagNames == null || tagNames.isEmpty()) {
            return new ArrayList<>();
        }

        List<TagEntity> result = new ArrayList<>();
        for (String name : tagNames) {
            String cleanName = name.trim();
            if (!cleanName.isEmpty()) {
                TagEntity tag = tagRepository.findByNameIgnoreCase(cleanName)
                        .orElseGet(() -> tagRepository.save(TagEntity.builder().name(cleanName).build()));
                result.add(tag);
            }
        }
        return result;
    }
}