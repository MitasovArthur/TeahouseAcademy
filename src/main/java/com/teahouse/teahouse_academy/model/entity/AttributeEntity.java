package com.teahouse.teahouse_academy.model.entity;

import com.teahouse.teahouse_academy.model.enumProject.CategoryAttribute;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Table(name = "attributes")
public class AttributeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "attribute_id")
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(name = "category", nullable = false)
    private CategoryAttribute category;

    @Column(name = "name", nullable = false)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    @ToString.Exclude
    private AttributeEntity parent;

    @OneToMany(mappedBy = "parent", fetch = FetchType.LAZY)
    @ToString.Exclude
    private List<AttributeEntity> children = new ArrayList<>();

    @ManyToMany(mappedBy = "attributes")
    @ToString.Exclude
    private List<TeaEntity> teas = new ArrayList<>();
}