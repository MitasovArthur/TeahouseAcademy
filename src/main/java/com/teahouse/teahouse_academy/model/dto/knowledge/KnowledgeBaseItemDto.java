package com.teahouse.teahouse_academy.model.dto.knowledge;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class KnowledgeBaseItemDto {
    private Long id;
    private String monthYear;
    private String title;
    private String teamName;
    private String description;
    private String fileLink;
}