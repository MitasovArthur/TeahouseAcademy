package com.teahouse.teahouse_academy.facade;

import com.teahouse.teahouse_academy.mapper.KnowledgeMapper;
import com.teahouse.teahouse_academy.model.dto.knowledge.KnowledgeBaseDetailDto;
import com.teahouse.teahouse_academy.model.dto.knowledge.KnowledgeBaseItemDto;
import com.teahouse.teahouse_academy.model.dto.knowledge.KnowledgeBaseMeetingDto;
import com.teahouse.teahouse_academy.model.entity.MeetingEntity;
import com.teahouse.teahouse_academy.service.MeetingService;
import com.teahouse.teahouse_academy.service.SubmissionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class KnowledgeBaseFacade {

    private final MeetingService meetingService;
    private final SubmissionService submissionService;

    private final KnowledgeMapper knowledgeMapper;

    public List<KnowledgeBaseItemDto> getKnowledgeBaseData() {
        return submissionService.getAllSubmissions().stream()
                .map(knowledgeMapper::toKnowledgeBaseItem)
                .collect(Collectors.toList());
    }

    public List<KnowledgeBaseMeetingDto> getKnowledgeBaseMeetings(String query, List<String> tagFilters) {
        return meetingService.searchKnowledgeBase(query, tagFilters).stream()
                .sorted(Comparator.comparing(MeetingEntity::getDate).reversed())
                .map(knowledgeMapper::toKnowledgeBaseMeeting)
                .collect(Collectors.toList());
    }

    public KnowledgeBaseDetailDto getKnowledgeBaseMeetingDetail(Long meetingId) {
        MeetingEntity meeting = meetingService.getById(meetingId);
        return knowledgeMapper.toKnowledgeBaseDetail(meeting);
    }
}
