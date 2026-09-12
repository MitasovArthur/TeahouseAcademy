package com.teahouse.teahouse_academy.mapper;

import com.teahouse.teahouse_academy.model.dto.knowledge.*;
import com.teahouse.teahouse_academy.model.entity.MeetingEntity;
import com.teahouse.teahouse_academy.model.entity.SubmissionEntity;
import com.teahouse.teahouse_academy.model.entity.TagEntity;
import com.teahouse.teahouse_academy.model.entity.TeamEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring",
        unmappedTargetPolicy = ReportingPolicy.ERROR,
        uses = {ResourceMapper.class, DateMapper.class})
public interface KnowledgeMapper {

    @Mapping(target = "format", expression = "java(meetingEntity.getIsOnline() ? \"Онлайн\" : \"Офлайн\")")
    @Mapping(target = "teamCount", expression = "java(meetingEntity.getTeams() != null ? meetingEntity.getTeams().size() : 0)")
    @Mapping(source = "date", target = "dateMonthYear", qualifiedByName = "asMonthYear")
    KnowledgeBaseMeetingDto toKnowledgeBaseMeeting(MeetingEntity meetingEntity);

    @Mapping(target = "format", expression = "java(meetingEntity.getIsOnline() ? \"Онлайн\" : \"Офлайн\")")
    @Mapping(source = "resources", target = "adminResources")
    @Mapping(source = "date", target = "fullDate", qualifiedByName = "asFullDate")
    KnowledgeBaseDetailDto toKnowledgeBaseDetail(MeetingEntity meetingEntity);

    @Mapping(target = "topic", source = "topic", defaultValue = "Загальна тема")
    KnowledgeBaseTeamDto toKnowledgeBaseTeam(TeamEntity teamEntity);

    @Mapping(source = "fileLink", target = "url")
    @Mapping(target = "fileName", expression = "java(submissionEntity.getFileName() != null ? submissionEntity.getFileName() : \"Зовнішнє посилання\")")
    KnowledgeBaseSubmissionDto toKnowledgeBaseSubmission(SubmissionEntity submissionEntity);

    @Mapping(target = "teamName", source = "team.name", defaultValue = "Невідома команда")
    @Mapping(target = "title", ignore = true)
    @Mapping(target = "description", ignore = true)
    @Mapping(source = "createdAt", target = "monthYear", qualifiedByName = "asMonthYear")
    KnowledgeBaseItemDto toKnowledgeBaseItem(SubmissionEntity submission);

    default String mapTagToString(TagEntity tag) {
        if (tag == null) return null;
        return tag.getName();
    }

    default boolean isFile(SubmissionEntity entity) {
        return entity.getFileName() != null && !entity.getFileName().isBlank();
    }

    default String getDisplayName(SubmissionEntity entity) {
        return isFile(entity) ? entity.getFileName() : "Зовнішнє посилання";
    }
}