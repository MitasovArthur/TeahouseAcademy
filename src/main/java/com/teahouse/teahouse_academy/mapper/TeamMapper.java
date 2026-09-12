package com.teahouse.teahouse_academy.mapper;

import com.teahouse.teahouse_academy.model.dto.submission.SubmissionShortDto;
import com.teahouse.teahouse_academy.model.dto.team.TeamResponseDto;
import com.teahouse.teahouse_academy.model.dto.teamComment.TeamCommentResponseDto;
import com.teahouse.teahouse_academy.model.entity.SubmissionEntity;
import com.teahouse.teahouse_academy.model.entity.TeamCommentEntity;
import com.teahouse.teahouse_academy.model.entity.TeamEntity;
import com.teahouse.teahouse_academy.model.entity.UserEntity;
import com.teahouse.teahouse_academy.model.enumProject.TeamStatus;
import org.mapstruct.Context;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring",
        unmappedTargetPolicy = ReportingPolicy.ERROR,
        uses = {DateMapper.class},
        imports = {TeamStatus.class})
public interface TeamMapper {

    DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm");

    @Mapping(source = "topic", target = "subtopic")
    @Mapping(source = "users", target = "userFullNames")
    @Mapping(target = "status", expression = "java(teamEntity.getStatus() != null ? teamEntity.getStatus() : TeamStatus.IN_PROGRESS)")
    @Mapping(target = "isSubmitted", expression = "java(isTeamSubmitted(teamEntity.getStatus()))")
    @Mapping(target = "isMyTeam", expression = "java(checkIsMyTeam(teamEntity.getUsers(), userId))")
    @Mapping(target = "submissionDate", expression = "java(getLatestSubmissionDate(teamEntity))")
    @Mapping(source = "submissions", target = "submissions")
    TeamResponseDto toTeamResponse(TeamEntity teamEntity, @Context Long userId);

    @Mapping(target = "createdAt", source = "createdAt", qualifiedByName = "asStringDateTime")
    TeamCommentResponseDto toCommentResponse(TeamCommentEntity comment);

    default String mapWorkerName(UserEntity user) {
        if (user == null) {
            return null;
        }
        return user.getFirstName() + " " + user.getLastName();
    }

    default boolean isTeamSubmitted(TeamStatus status) {
        return status == TeamStatus.SUBMITTED || status == TeamStatus.DONE;
    }

    default boolean checkIsMyTeam(Set<UserEntity> users, @Context Long userId) {
        if (users == null || userId == null) return false;
        return users.stream().anyMatch(u -> u.getId().equals(userId));
    }

    default String getLatestSubmissionDate(TeamEntity teamEntity) {
        if (!isTeamSubmitted(teamEntity.getStatus()) || teamEntity.getSubmissions() == null) {
            return null;
        }
        LocalDateTime latestDate = teamEntity.getSubmissions().stream()
                .max(Comparator.comparing(SubmissionEntity::getCreatedAt))
                .map(SubmissionEntity::getCreatedAt)
                .orElse(null);

        return latestDate != null ? latestDate.format(DATE_TIME_FORMATTER) : null;
    }

    default List<String> extractSubmissionUrls(TeamEntity teamEntity) {
        if (!isTeamSubmitted(teamEntity.getStatus()) || teamEntity.getSubmissions() == null) {
            return Collections.emptyList();
        }
        return teamEntity.getSubmissions().stream()
                .map(SubmissionEntity::getFileLink)
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    @Mapping(target = "fileName", expression = "java(entity.getFileName() != null ? entity.getFileName() : \"Зовнішнє посилання\")")
    SubmissionShortDto toSubmissionShortDto(SubmissionEntity entity);
}