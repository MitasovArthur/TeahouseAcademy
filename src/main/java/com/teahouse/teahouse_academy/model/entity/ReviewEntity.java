package com.teahouse.teahouse_academy.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Table(name = "reviews")
public class ReviewEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "review_id")
    private Long id;

    @ManyToOne(targetEntity = UserEntity.class)
    @JoinColumn(name = "user_id")
    @ToString.Exclude
    private UserEntity author;

    @ManyToOne(targetEntity = TeaEntity.class)
    @JoinColumn(name = "tea_id")
    @ToString.Exclude
    private TeaEntity tea;

    @Column(name = "comment", nullable = false, columnDefinition = "TEXT")
    private String comment;

    @Column(name = "taste", nullable = false)
    private Integer taste;

    @Column(name = "aroma", nullable = false)
    private Integer aroma;

    @Column(name = "strength", nullable = false)
    private Integer strength;

    @Column(name = "astringency", nullable = false)
    private Integer astringency;
}
