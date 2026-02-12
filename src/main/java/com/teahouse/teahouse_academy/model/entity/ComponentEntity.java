package com.teahouse.teahouse_academy.model.entity;

import jakarta.persistence.*;
import lombok.*;
import jakarta.persistence.Id;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Table(name = "components")
public class ComponentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "components_id")
    private Long id;

    @Column(name = "name")
    private String name;

    @ManyToMany(mappedBy = "components")
    private List<TeaEntity> teas = new ArrayList<>();
}
