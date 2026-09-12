package com.teahouse.teahouse_academy.model.enumProject;

import lombok.Getter;

@Getter
public enum TypeTea {
    WHITE("Білий"),
    YELLOW("Жовтий"),
    GREEN("Зелений"),
    OOLONG("Улун"),
    RED("Червоний"),
    BLACK("Чорний"),
    HIBISCUS("Каркаде"),
    HERBAL("Трав'яний"),
    PU_ERH("Пуер");

    private final String displayName;

    TypeTea(String displayName) {
        this.displayName = displayName;
    }
}
