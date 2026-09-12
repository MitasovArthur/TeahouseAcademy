package com.teahouse.teahouse_academy.mapper;

import org.mapstruct.Named;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import static org.apache.commons.lang3.StringUtils.capitalize;

@Component
public class DateMapper {

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd.MM.yyyy");
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm");
    private static final DateTimeFormatter MONTH_YEAR_FORMATTER = DateTimeFormatter.ofPattern("LLLL yyyy", new Locale("uk", "UA"));
    private static final DateTimeFormatter FULL_DATE_FORMATTER = DateTimeFormatter.ofPattern("dd LLLL yyyy", new Locale("uk", "UA"));

    @Named("asString")
    public String asString(LocalDate date) {
        return date != null ? date.format(DATE_FORMATTER) : null;
    }

    @Named("asStringDateTime")
    public String asStringDateTime(LocalDateTime dateTime) {
        return dateTime != null ? dateTime.format(DATE_TIME_FORMATTER) : null;
    }

    @Named("asMonthYear")
    public String asMonthYearString(LocalDate date) {
        if (date == null) return null;
        return capitalize(date.format(MONTH_YEAR_FORMATTER));
    }

    @Named("asFullDate")
    public String asFullDateString(LocalDate date) {
        return date != null ? date.format(FULL_DATE_FORMATTER) : null;
    }
}