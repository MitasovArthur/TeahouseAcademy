package com.teahouse.teahouse_academy.model.dto.tea;

import com.teahouse.teahouse_academy.model.enumProject.TypeTea;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TeaCreateDto {
    @NotNull
    @Positive
    private Integer codeTea;

    @NotNull
    private TypeTea type;

    @NotBlank
    @Size(min = 2, max = 100)
    private String name;

    @NotBlank
    private String description;

    @NotEmpty
    private List<Long> componentIds;
}
