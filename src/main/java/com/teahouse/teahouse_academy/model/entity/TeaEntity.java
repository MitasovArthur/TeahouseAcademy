package com.teahouse.teahouse_academy.model.entity;

import com.teahouse.teahouse_academy.model.enumProject.TypeTea;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Table;
import lombok.*;
import org.springframework.data.annotation.Id;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Table(name="tea")
public class TeaEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    Long codeTea;
    TypeTea type;
    String name;
    String description;

}
