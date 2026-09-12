package com.teahouse.teahouse_academy.service;

import com.teahouse.teahouse_academy.model.dto.meeting.MeetingRequestDto;
import com.teahouse.teahouse_academy.model.dto.submission.LinkDto;
import com.teahouse.teahouse_academy.model.entity.MeetingEntity;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface MeetingService {

    List<MeetingEntity> getMeetingsInProgress();

    List<MeetingEntity> getMeetingsInArchive();

    List<MeetingEntity> getActivityMeetingWithDetail();

    List<MeetingEntity> searchKnowledgeBase(String query, List<String> tags);

    MeetingEntity getById(Long id);

    MeetingEntity create(MeetingRequestDto requestDto);

    MeetingEntity update(Long id, MeetingRequestDto requestDto);

    void delete(Long id);

    void addMaterialsMulti(Long meetingId, List<LinkDto> links, List<MultipartFile> files);

    void deleteResource(Long resourceId);

    void completeMeeting(Long meetingId, List<String> tagNames);

}