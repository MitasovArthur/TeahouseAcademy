package com.teahouse.teahouse_academy.model.dto.shop;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShopDto {
    private Long id;
    private String name;
    private String address;
    private String cityName;
    private Long cityId;
    private int employeeCount;
    private List<String> workerNames;
}