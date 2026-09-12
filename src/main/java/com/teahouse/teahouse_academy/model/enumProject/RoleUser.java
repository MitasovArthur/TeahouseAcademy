package com.teahouse.teahouse_academy.model.enumProject;

import lombok.Getter;

@Getter
public enum RoleUser {
    GUEST("Стажер"),
    ADMIN("Адмін"),
    LEVEL_ONE("Перший рівень"),
    LEVEL_TWO("Другий рівень"),
    LEVEL_THREE("Третій рівень");

    private final String displayRole;

    RoleUser(String displayName) {
        this.displayRole = displayName;
    }
}
