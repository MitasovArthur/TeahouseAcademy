package com.teahouse.teahouse_academy.model.dto.tea;

import com.teahouse.teahouse_academy.model.enumProject.TypeTea;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TeaFilterRequest {
    private String keyword;
    private TypeTea type;
}
