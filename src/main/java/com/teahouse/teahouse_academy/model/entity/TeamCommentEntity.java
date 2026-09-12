package com.teahouse.teahouse_academy.model.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Table(name = "team_comments")
public class TeamCommentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "team_id", nullable = false)
    private TeamEntity team;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String text;

    @Column(name = "action_type", nullable = false)
    private String actionType;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;
}
