package com.teahouse.teahouse_academy.model.enumProject;

import lombok.Getter;

@Getter
public enum CategoryAttribute {
    COMPONENT("Компонент"),
    COUNTRY("Країна"),
    REGION("Регіон");

    private final String displayName;

    CategoryAttribute(String displayName) {
        this.displayName = displayName;
    }
}
