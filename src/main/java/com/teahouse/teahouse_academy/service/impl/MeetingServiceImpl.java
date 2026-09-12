package com.teahouse.teahouse_academy.service.impl;

import com.teahouse.teahouse_academy.model.dto.meeting.MeetingRequestDto;
import com.teahouse.teahouse_academy.model.dto.submission.LinkDto;
import com.teahouse.teahouse_academy.model.entity.MeetingEntity;
import com.teahouse.teahouse_academy.model.entity.MeetingResourceEntity;
import com.teahouse.teahouse_academy.model.enumProject.ResourceType;
import com.teahouse.teahouse_academy.model.enumProject.TeamStatus;
import com.teahouse.teahouse_academy.repository.MeetingRepository;
import com.teahouse.teahouse_academy.repository.MeetingResourceRepository;
import com.teahouse.teahouse_academy.service.MeetingService;
import com.teahouse.teahouse_academy.service.StorageService;
import com.teahouse.teahouse_academy.service.TagService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MeetingServiceImpl implements MeetingService {

    private final MeetingRepository meetingRepository;
    private final MeetingResourceRepository meetingResourceRepository;
    private final StorageService storageService;
    private final TagService tagService;

    @Override
    public List<MeetingEntity> getMeetingsInProgress() {
        return meetingRepository.findAllByIsCompletedFalseOrderByDateAsc();
    }

    @Override
    public List<MeetingEntity> getMeetingsInArchive() {
        return meetingRepository.findAllByIsCompletedTrueOrderByDateDesc();
    }

    @Override
    public List<MeetingEntity> getActivityMeetingWithDetail() {
        return meetingRepository.findAllActiveWithDetails();
    }

    @Override
    public List<MeetingEntity> searchKnowledgeBase(String query, List<String> tags) {
        boolean filterByTags = (tags != null && !tags.isEmpty());
        return meetingRepository.searchKnowledgeBase(query, tags, filterByTags);
    }

    @Override
    public MeetingEntity getById(Long id) {
        return meetingRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Meeting not found with id: " + id));
    }

    @Override
    @Transactional
    public MeetingEntity create(MeetingRequestDto requestDto) {
        if (requestDto.getDate().isBefore(LocalDate.now())) {
            throw new IllegalArgumentException("Cannot create a collection in the past");
        }

        MeetingEntity meeting = MeetingEntity.builder()
                .name(requestDto.getName())
                .description(requestDto.getDescription())
                .isOnline(requestDto.getIsOnline())
                .isCompleted(false)
                .date(requestDto.getDate())
                .build();

        return meetingRepository.save(meeting);
    }

    @Override
    @Transactional
    public MeetingEntity update(Long meetingId, MeetingRequestDto dto) {
        MeetingEntity meeting = getById(meetingId);
        checkMeetingIsOpen(meeting, "Unable to edit completed collection");

        meeting.setName(dto.getName());
        meeting.setDescription(dto.getDescription());
        meeting.setDate(dto.getDate());
        meeting.setIsOnline(dto.getIsOnline());

        return meetingRepository.save(meeting);
    }

    @Override
    @Transactional
    public void delete(Long meetingId) {
        MeetingEntity meeting = getById(meetingId);
        checkMeetingIsOpen(meeting, "Unable to delete completed collection");

        meetingRepository.delete(meeting);
    }

    @Transactional
    @Override
    public void addMaterialsMulti(Long meetingId, List<LinkDto> links, List<MultipartFile> files) {
        MeetingEntity meeting = getById(meetingId);
        checkMeetingIsOpen(meeting, "Unable to add materials to a completed collection");

        if (links != null) {
            for (LinkDto link : links) {
                if (link.getUrl() == null || link.getUrl().isBlank()) continue;

                String title = (link.getTitle() != null && !link.getTitle().isBlank()) ? link.getTitle() : "Корисне посилання";
                String typeStr = (link.getType() != null && !link.getType().isBlank()) ? link.getType() : "LINK";

                MeetingResourceEntity resource = new MeetingResourceEntity();
                resource.setTitle(title);
                resource.setType(ResourceType.valueOf(typeStr));
                resource.setUrl(link.getUrl());
                resource.setMeeting(meeting);
                meeting.getResources().add(resource);
            }
        }

        if (files != null) {
            for (MultipartFile file : files) {
                if (file.isEmpty()) continue;

                String originalName = file.getOriginalFilename();
                ResourceType fileType = ResourceType.fromFileName(originalName);

                var result = storageService.uploadFile(file, "teahouse_materials");

                MeetingResourceEntity resource = new MeetingResourceEntity();
                resource.setTitle(originalName);
                resource.setFileName(originalName);
                resource.setType(fileType);
                resource.setFileKey(result.fileKey());
                resource.setUrl(result.url());
                resource.setMeeting(meeting);
                meeting.getResources().add(resource);
            }
        }

        meetingRepository.save(meeting);
    }

    @Override
    @Transactional
    public void deleteResource(Long resourceId) {
        MeetingResourceEntity resource = meetingResourceRepository.findById(resourceId)
                .orElseThrow(() -> new EntityNotFoundException("Cannot delete. Resource not found with id: " + resourceId));

        checkMeetingIsOpen(resource.getMeeting(), "Unable to delete items from a completed collection");

        if (resource.getFileKey() != null) {
            storageService.deleteFile(resource.getFileKey());
        }

        meetingResourceRepository.deleteById(resourceId);
    }

    @Override
    @Transactional
    public void completeMeeting(Long meetingId, List<String> tagNames) {
        MeetingEntity meeting = getById(meetingId);
        boolean hasPendingReviews = meeting.getTeams().stream()
                .anyMatch(team -> team.getStatus() == TeamStatus.SUBMITTED);
        if (hasPendingReviews) {
            throw new IllegalStateException("pending_reviews");
        }

        meeting.setIsCompleted(true);
        List<com.teahouse.teahouse_academy.model.entity.TagEntity> tags = tagService.getOrCreateTags(tagNames);
        meeting.setTags(tags);

        meetingRepository.save(meeting);
    }

    private void checkMeetingIsOpen(MeetingEntity meeting, String errorMessage) {
        if (Boolean.TRUE.equals(meeting.getIsCompleted())) {
            throw new IllegalStateException(errorMessage);
        }
    }
}