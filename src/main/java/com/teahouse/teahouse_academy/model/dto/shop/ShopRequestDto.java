package com.teahouse.teahouse_academy.model.dto.shop;

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
public class ShopRequestDto {
    @NotBlank
    private String name;

    @NotBlank
    private String address;

    @NotNull
    private Long cityId;
}
