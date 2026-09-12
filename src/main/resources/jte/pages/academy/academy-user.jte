@import com.teahouse.teahouse_academy.model.dto.academy.AcademyDashboardResponseDto

@param java.util.List<AcademyDashboardResponseDto> dashboards

@template.layout.main(isAdmin = false, content = @`

    <link href="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.snow.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.js"></script>
    <link href="/assets/css/academy.css" rel="stylesheet"/>

    <div class="ac-page-bg">
        <div class="ac-page">

            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-5 pb-4 border-bottom">
                <div>
                    <h2 class="ac-page-title">Академія Teahouse</h2>
                    <p class="ac-page-sub">Навчання, розвиток, тестування команди</p>
                </div>
                <div class="mt-3 mt-md-0">
                    <a href="/academy/knowledge-base"
                       class="ac-kb-link d-inline-flex align-items-center gap-2 text-decoration-none">
                        <span class="d-flex text-tea">@template.layout.icon(name = "books", size = "22")</span>
                        <span>Архів та База знань</span>
                    </a>
                </div>
            </div>

            @if(dashboards == null || dashboards.isEmpty())
                <div class="ac-empty">
                    <div class="ac-empty-icon d-flex justify-content-center text-tea" style="margin-bottom: 1rem;">
                        @template.layout.icon(name = "tea", size = "80")
                    </div>
                    <h4>Поки що немає активних зібрань</h4>
                    <p class="text-muted">Ваша команда ще не отримала нових завдань.</p>
                </div>

            @else
                @for(var dashboard : dashboards)

                    <div class="ac-meeting">
                        <div class="ac-meeting-accent">
                            <div class="ac-meeting-body">

                                <div class="ac-meeting-head">
                                    <div class="ac-badge">Поточні збори</div>
                                    <h3 class="ac-title d-flex align-items-center gap-2">
                                        ${dashboard.getMeetingName()}
                                        <span class="text-tea d-flex">@template.layout.icon(name = "tea", size = "28")</span>
                                    </h3>
                                    <div class="ac-meta d-flex align-items-center gap-3">
                                        <span class="d-inline-flex align-items-center gap-1">
                                            <span class="d-flex text-muted">@template.layout.icon(name = "calendar", size = "18")</span>
                                            ${dashboard.getDate()}
                                        </span>
                                        @if(dashboard.isOnline())
                                            <span class="d-inline-flex align-items-center gap-1">
                                                <span class="d-flex text-success">@template.layout.icon(name = "online", size = "18")</span>
                                                Онлайн
                                            </span>
                                        @else
                                            <span class="d-inline-flex align-items-center gap-1">
                                                <span class="d-flex text-secondary">@template.layout.icon(name = "shop", size = "18")</span>
                                                Офлайн
                                            </span>
                                        @endif
                                    </div>
                                    @if(dashboard.getDescription() != null && !dashboard.getDescription().isEmpty())
                                        <div class="ac-desc ql-editor">$unsafe{dashboard.getDescription()}</div>
                                    @endif
                                </div>

                                @if(dashboard.getResources() != null && !dashboard.getResources().isEmpty())
                                    <div class="ac-resources">
                                        <div class="ac-section-label d-flex align-items-center gap-2">
                                            <span class="d-flex text-muted">@template.layout.icon(name = "notebook", size = "18")</span>
                                            Додаткові матеріали
                                        </div>
                                        <div style="display:flex; flex-wrap:wrap; gap:10px;">
                                            @for(var resource : dashboard.getResources())
                                                <a href="${resource.getUrl()}" target="_blank" class="ac-chip">
                                                    <span style="font-size: 1.1rem; display: flex;">
                                                        @if(resource.getType().name().equals("VIDEO"))
                                                            <span style="color: #ef4444; display: flex;">@template.layout.icon(name = "video", size = "18")</span>
                                                        @elseif(resource.getType().name().equals("DOCUMENT"))
                                                            <span style="color: #3b82f6; display: flex;">@template.layout.icon(name = "document", size = "18")</span>
                                                        @elseif(resource.getType().name().equals("PRESENTATION"))
                                                            <span style="color: #f59e0b; display: flex;">@template.layout.icon(name = "presentation", size = "18")</span>
                                                        @elseif(resource.getType().name().equals("IMAGE"))
                                                            <span style="color: #10b981; display: flex;">@template.layout.icon(name = "image", size = "18")</span>
                                                        @elseif(resource.getType().name().equals("ARCHIVE"))
                                                            <span style="color: #64748b; display: flex;">@template.layout.icon(name = "archive", size = "18")</span>
                                                        @elseif(resource.getType().name().equals("BOOK"))
                                                            <span style="color: #8b5cf6; display: flex;">@template.layout.icon(name = "books", size = "18")</span>
                                                        @else
                                                            <span style="color: #64748b; display: flex;">@template.layout.icon(name = "link", size = "18")</span>
                                                        @endif
                                                    </span>
                                                    ${resource.getTitle()}
                                                </a>
                                            @endfor
                                        </div>
                                    </div>
                                @endif

                                <div class="ac-teams">

                                    @for(var team : dashboard.getTeams())
                                        @if(team.isMyTeam())
                                            <div class="ac-my-team">
                                                <div class="ac-my-team-tag d-inline-flex align-items-center gap-1">
                                                    <span class="d-flex">@template.layout.icon(name = "tag", size = "14")</span>
                                                    Ваша команда
                                                </div>
                                                <div class="ac-my-team-name">${team.getName()}</div>
                                                @if(team.getSubtopic() != null && !team.getSubtopic().isEmpty())
                                                    <div class="ac-my-team-topic d-inline-flex align-items-center gap-2">
                                                        <span class="d-flex text-muted">@template.layout.icon(name = "notebook", size = "18")</span>
                                                        ${team.getSubtopic()}
                                                    </div>
                                                @endif

                                                <div class="ac-my-team-row">
                                                    <div style="display:flex; align-items:center; gap:12px; flex-wrap:wrap;">
                                                        @if(team.getStatus().name().equals("SUBMITTED"))
                                                            <span class="ac-status ac-status-pending d-inline-flex align-items-center gap-2">
                                                                <span class="d-flex">@template.layout.icon(name = "inProgress", size = "18")</span> На перевірці
                                                            </span>
                                                        @elseif(team.getStatus().name().equals("DONE"))
                                                            <span class="ac-status ac-status-done d-inline-flex align-items-center gap-2">
                                                                <span class="d-flex">@template.layout.icon(name = "confirm", size = "18")</span> Зараховано
                                                            </span>
                                                        @else
                                                            <span class="ac-status ac-status-working d-inline-flex align-items-center gap-2">
                                                                <span class="d-flex">@template.layout.icon(name = "inWork", size = "18")</span> В роботі
                                                            </span>
                                                        @endif

                                                        <button class="ac-btn ac-btn-ghost d-inline-flex align-items-center gap-2"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#teamModal-${dashboard.getMeetingId()}-${team.getId()}">
                                                            <span class="d-flex text-muted">@template.layout.icon(name = "personIcon", size = "18")</span>
                                                            ${team.getUserFullNames() != null ? team.getUserFullNames().size() : 0}
                                                            учасників
                                                        </button>
                                                    </div>

                                                    @if(team.getStatus().name().equals("DONE"))
                                                        <span class="ac-btn ac-btn-ghost d-inline-flex align-items-center gap-2"
                                                              style="cursor:default;">
                                                            <span class="d-flex text-muted">@template.layout.icon(name = "lock", size = "18")</span>
                                                            Завдання закрите
                                                        </span>
                                                    @else
                                                        <a href="/academy/submit/${dashboard.getMeetingId()}"
                                                           class="ac-btn ac-btn-primary">
                                                            ${team.getStatus().name().equals("IN_PROGRESS") ? "Перейти до завдання" : "Редагувати матеріали"}
                                                        </a>
                                                    @endif
                                                </div>

                                                @if(team.getComments() != null && !team.getComments().isEmpty())
                                                    <div class="mt-4 pt-3 border-top">
                                                        <div class="ac-section-label d-flex align-items-center gap-2">
                                                            <span class="d-flex text-muted">@template.layout.icon(name = "comment", size = "18")</span>
                                                            Історія перевірки керівником
                                                        </div>
                                                        @for(var comment : team.getComments())
                                                            <div class="ac-comment ${comment.getActionType().equals("APPROVE") ? "ac-comment-approve" : "ac-comment-action"}">
                                                                <div class="ac-comment-meta d-flex align-items-center gap-2">
                                                                    @if(comment.getActionType().equals("APPROVE"))
                                                                        <span class="d-inline-flex align-items-center gap-2">
                                                                            <span class="d-flex text-success">@template.layout.icon(name = "confirm", size = "18")</span> Зараховано
                                                                        </span>
                                                                    @else
                                                                        <span class="d-inline-flex align-items-center gap-2">
                                                                            <span class="d-flex text-warning">@template.layout.icon(name = "warning", size = "18")</span> Зауваження
                                                                        </span>
                                                                    @endif
                                                                    <span class="text-muted ms-2">${comment.getCreatedAt()}</span>
                                                                </div>
                                                                <div class="mt-1">${comment.getText()}</div>
                                                            </div>
                                                        @endfor
                                                    </div>
                                                @endif
                                            </div>
                                        @endif
                                    @endfor

                                    @if(dashboard.getTeams().size() > 1)
                                        <div class="ac-other-label">Інші команди</div>
                                        <div class="ac-other-grid">
                                            @for(var team : dashboard.getTeams())
                                                @if(!team.isMyTeam())
                                                    <div class="ac-other-card ${team.getStatus().name().equals("DONE") ? "accent-done" : "accent-working"}">
                                                        <div class="ac-other-name">${team.getName()}</div>
                                                        @if(team.getSubtopic() != null && !team.getSubtopic().isEmpty())
                                                            <div class="ac-other-topic d-inline-flex align-items-center gap-2">
                                                                <span class="d-flex text-muted">@template.layout.icon(name = "notebook", size = "18")</span>
                                                                ${team.getSubtopic()}
                                                            </div>
                                                        @endif
                                                        <div style="display:flex; align-items:center; justify-content:space-between; margin-top:auto; padding-top:12px; border-top:1px solid var(--border);">
                                                            @if(team.getStatus().name().equals("SUBMITTED"))
                                                                <span class="ac-status ac-status-pending d-inline-flex align-items-center gap-2">
                                                                    <span class="d-flex">@template.layout.icon(name = "inProgress", size = "18")</span> На перевірці
                                                                </span>
                                                            @elseif(team.getStatus().name().equals("DONE"))
                                                                <span class="ac-status ac-status-done d-inline-flex align-items-center gap-2">
                                                                    <span class="d-flex">@template.layout.icon(name = "confirm", size = "18")</span> Зараховано
                                                                </span>
                                                            @else
                                                                <span class="ac-status ac-status-working d-inline-flex align-items-center gap-2">
                                                                    <span class="d-flex">@template.layout.icon(name = "inWork", size = "18")</span> В роботі
                                                                </span>
                                                            @endif
                                                            <button class="ac-btn ac-btn-ghost d-inline-flex align-items-center gap-2"
                                                                    style="padding:4px 10px; font-size:.78rem;"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#teamModal-${dashboard.getMeetingId()}-${team.getId()}">
                                                                <span class="d-flex text-muted">@template.layout.icon(name = "personIcon", size = "18")</span>
                                                                ${team.getUserFullNames() != null ? team.getUserFullNames().size() : 0}
                                                            </button>
                                                        </div>
                                                    </div>
                                                @endif
                                            @endfor
                                        </div>
                                    @endif

                                </div>
                            </div>
                        </div>
                    </div>

                    @for(var team : dashboard.getTeams())
                        <div class="modal fade" id="teamModal-${dashboard.getMeetingId()}-${team.getId()}" tabindex="-1"
                             aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-sm">
                                <div class="modal-content">
                                    <div class="modal-header"
                                         style="background:var(--tea-light); border-bottom:1px solid #bbf7d0;">
                                        <h5 class="modal-title fw-bold"
                                            style="color:var(--tea-dark);">${team.getName()}</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body" style="padding:8px 20px 16px;">
                                        @if(team.getUserFullNames() != null && !team.getUserFullNames().isEmpty())
                                            @for(String uname : team.getUserFullNames())
                                                <div class="ac-member">
                                                    <div class="ac-avatar">${uname != null && !uname.trim().isEmpty() ? uname.trim().substring(0,1).toUpperCase() : "👤"}</div>
                                                    ${uname}
                                                </div>
                                            @endfor
                                        @else
                                            <p style="color:var(--text-muted); text-align:center; padding:20px 0; margin:0;">
                                                Немає учасників</p>
                                        @endif
                                    </div>
                                </div>
                            </div>
                        </div>
                    @endfor

                @endfor
            @endif

        </div>
    </div>
`)
