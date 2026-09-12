package com.teahouse.teahouse_academy.model.enumProject;

import lombok.Getter;

@Getter
public enum TeamStatus {
    IN_PROGRESS("У процесі"),
    SUBMITTED("На перевірці"),
    DONE("Здано");

    private final String displayName;

    TeamStatus(String displayName) {
        this.displayName = displayName;
    }
}