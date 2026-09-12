package com.teahouse.teahouse_academy.service;

import com.teahouse.teahouse_academy.model.dto.submission.LinkDto;
import com.teahouse.teahouse_academy.model.dto.submission.SubmissionCreateDto;
import com.teahouse.teahouse_academy.model.entity.SubmissionEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface SubmissionService {

    SubmissionEntity getById(Long id);

    List<SubmissionEntity> getAllSubmissions();

    void deleteById(Long id);

    @Transactional
    SubmissionEntity save(SubmissionEntity submission);

    void submitWorkMulti(Long teamId, List<LinkDto> links, List<MultipartFile> files);
}