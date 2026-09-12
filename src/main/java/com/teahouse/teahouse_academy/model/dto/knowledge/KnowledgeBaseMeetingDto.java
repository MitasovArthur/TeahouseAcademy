package com.teahouse.teahouse_academy.model.dto.knowledge;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class KnowledgeBaseMeetingDto {
    private Long id;
    private String name;
    private String dateMonthYear;
    private String format;
    private int teamCount;
    private List<String> tags;
}