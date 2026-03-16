package com.teahouse.teahouse_academy.model.dto.tea;

import com.teahouse.teahouse_academy.model.dto.attribute.AttributeShortDto;
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

    private List<AttributeShortDto> componentsShort;
    private List<AttributeShortDto> countriesShort;

    private List<ReviewShortDto> reviewShort;
}