package com.teahouse.teahouse_academy.model.dto.tea;

import com.teahouse.teahouse_academy.model.enumProject.TypeTea;
import lombok.Data;

@Data
public class TeaFilterRequest {
    private String keyword;
    private TypeTea type;
}
