package com.teahouse.teahouse_academy.model.dto.submission;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LinkDto {
    private String url;
    private String title;
    private String type;
}
