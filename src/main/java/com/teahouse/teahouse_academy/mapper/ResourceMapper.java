package com.teahouse.teahouse_academy.mapper;

import com.teahouse.teahouse_academy.model.dto.meeting.ResourceResponseDto;
import com.teahouse.teahouse_academy.model.entity.MeetingResourceEntity;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring",
        unmappedTargetPolicy = ReportingPolicy.ERROR)
public interface ResourceMapper {

    ResourceResponseDto toResourceResponse(MeetingResourceEntity meetingResourceEntity);
}
