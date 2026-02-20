package com.teahouse.teahouse_academy.model.dto.tea;

import com.teahouse.teahouse_academy.model.dto.component.ComponentShortDto;
import com.teahouse.teahouse_academy.model.dto.review.ReviewShortDto;
import com.teahouse.teahouse_academy.model.enumProject.TypeTea;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TeaDto {
    private Long id;
    private Integer codeTea;
    private TypeTea type;
    private String name;
    private String description;
    private List<ComponentShortDto> componentsShort;
    private List<ReviewShortDto> reviewShort;
}
