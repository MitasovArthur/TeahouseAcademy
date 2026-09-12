package com.teahouse.teahouse_academy.model.enumProject;

import lombok.Getter;

@Getter
public enum ResourceType {
    VIDEO("Відео"),
    ARTICLE("Стаття"),
    LINK("Посилання"),
    BOOK("Книги"),
    DOCUMENT("Документи"),
    PRESENTATION("Презентації"),
    IMAGE("Картинки"),
    ARCHIVE("Архіви"),
    OTHER("інше");

    private final String displayName;

    ResourceType(String displayName) {
        this.displayName = displayName;
    }

    public static ResourceType fromFileName(String fileName) {
        if (fileName == null || !fileName.contains(".")) {
            return OTHER;
        }

        String ext = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

        return switch (ext) {
            case "mp4", "mov", "avi", "mkv", "webm" -> VIDEO;
            case "pdf", "doc", "docx", "txt", "rtf" -> DOCUMENT;
            case "ppt", "pptx", "key" -> PRESENTATION;
            case "jpg", "jpeg", "png", "gif", "svg", "webp" -> IMAGE;
            case "zip", "rar", "7z", "tar" -> ARCHIVE;
            case "epub", "mobi", "fb2" -> BOOK;
            default -> OTHER;
        };
    }
}