package com.teahouse.teahouse_academy.model.entity;

import com.teahouse.teahouse_academy.model.enumProject.TypeTea;
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
@Table(name = "teas")
public class TeaEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tea_id")
    private Long id;

    @Column(name = "code", nullable = false, unique = true)
    private Integer codeTea;

    @Enumerated(EnumType.STRING)
    @Column(name = "type", nullable = false, length = 50)
    private TypeTea type;

    @Column(name = "name", nullable = false, length = 100)
    private String name;

    @Column(name = "description", nullable = false, columnDefinition = "TEXT")
    private String description;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "tea_attributes",
            joinColumns = @JoinColumn(name = "tea_id"),
            inverseJoinColumns = @JoinColumn(name = "attribute_id")
    )
    @ToString.Exclude
    @Builder.Default
    private List<AttributeEntity> attributes = new ArrayList<>();

    @OneToMany(mappedBy = "tea", cascade = CascadeType.ALL, orphanRemoval = true)
    @ToString.Exclude
    @Builder.Default
    private List<ReviewEntity> reviews = new ArrayList<>();
}
