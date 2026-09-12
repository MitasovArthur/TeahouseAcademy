package com.teahouse.teahouse_academy.service.impl;

import com.teahouse.teahouse_academy.model.dto.submission.LinkDto;
import com.teahouse.teahouse_academy.model.entity.SubmissionEntity;
import com.teahouse.teahouse_academy.model.entity.TeamEntity;
import com.teahouse.teahouse_academy.model.enumProject.ResourceType;
import com.teahouse.teahouse_academy.model.enumProject.TeamStatus;
import com.teahouse.teahouse_academy.repository.SubmissionRepository;
import com.teahouse.teahouse_academy.service.StorageService;
import com.teahouse.teahouse_academy.service.SubmissionService;
import com.teahouse.teahouse_academy.service.TeamService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class SubmissionServiceImpl implements SubmissionService {

    private final SubmissionRepository submissionRepository;
    private final TeamService teamService;
    private final StorageService storageService;

    @Override
    public SubmissionEntity getById(Long id) {
        return submissionRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Submission not found with id: " + id));
    }

    @Override
    public List<SubmissionEntity> getAllSubmissions() {
        return submissionRepository.findAll();
    }

    @Override
    @Transactional
    public void deleteById(Long id) {
        SubmissionEntity existing = getById(id);
        TeamEntity team = existing.getTeam();

        long currentCount = submissionRepository.countByTeamId(team.getId());

        if (existing.getFileKey() != null && !existing.getFileKey().isEmpty()) {
            storageService.deleteFile(existing.getFileKey());
        }

        submissionRepository.delete(existing);

        if (currentCount == 1) {
            team.setStatus(TeamStatus.IN_PROGRESS);
        }
    }

    @Override
    @Transactional
    public SubmissionEntity save(SubmissionEntity submission) {
        return submissionRepository.save(submission);
    }

    @Transactional
    @Override
    public void submitWorkMulti(Long teamId, List<LinkDto> links, List<MultipartFile> files) {
        TeamEntity team = teamService.getById(teamId);
        LocalDateTime now = LocalDateTime.now();

        if (links != null) {
            for (LinkDto link : links) {
                if (link.getUrl() == null || link.getUrl().isBlank()) continue;

                String title = (link.getTitle() != null && !link.getTitle().isBlank()) ? link.getTitle() : "Посилання";
                String typeStr = (link.getType() != null && !link.getType().isBlank()) ? link.getType() : "LINK";

                saveSubmission(team, link.getUrl(), null, title, ResourceType.valueOf(typeStr), now);
            }
        }

        if (files != null) {
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    String originalName = file.getOriginalFilename();
                    ResourceType fileType = ResourceType.fromFileName(originalName);

                    var result = storageService.uploadFile(file, "teahouse_academy/submissions");
                    saveSubmission(team, result.url(), result.fileKey(), originalName, fileType, now);
                }
            }
        }
        team.setStatus(TeamStatus.SUBMITTED);
    }

    private void saveSubmission(TeamEntity team, String link, String key, String fileName, ResourceType type, LocalDateTime time) {
        SubmissionEntity submission = SubmissionEntity.builder()
                .team(team)
                .fileLink(link)
                .fileKey(key)
                .fileName(fileName)
                .type(type)
                .createdAt(time)
                .build();
        submissionRepository.save(submission);
    }
}