package com.teahouse.teahouse_academy.model.dto.attribute;

import com.teahouse.teahouse_academy.model.enumProject.CategoryAttribute;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AttributeRequestDto {
    @NotBlank
    private String name;

    @NotNull
    private CategoryAttribute category;

    @NotNull
    private Long parentId;
}
