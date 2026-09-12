@import com.teahouse.teahouse_academy.model.dto.knowledge.KnowledgeBaseDetailDto

@param KnowledgeBaseDetailDto meeting
@param Boolean isAdmin = false

@template.layout.main(isAdmin = isAdmin, content = @`
    <link href="/assets/css/knowledge-base.css" rel="stylesheet"/>

    <div class="container my-5" style="max-width: 850px;">

        <div class="mb-4">
            <a href="/academy/knowledge-base" class="text-success text-decoration-none fw-bold d-inline-flex align-items-center gap-1"
               style="font-size: 0.95rem;">
                ← Повернутися до Бази знань
            </a>
        </div>

        <div class="kb-detail-hero" style="position: relative; overflow: hidden;">
            <div style="position: absolute; right: -20px; bottom: -30px; opacity: 0.1; transform: rotate(-10deg); color: #166534;">
                @template.layout.icon(name = "tea", size = "180")
            </div>

            <div class="d-flex align-items-center gap-3 mb-3 relative" style="z-index: 2;">
                <span class="badge bg-success bg-opacity-25 text-success border border-success px-3 py-2 rounded-pill fw-bold d-inline-flex align-items-center gap-1"
                      style="font-size: 0.8rem;">
                    @if(meeting.getFormat().equals("Онлайн"))
                        <span class="d-flex">@template.layout.icon(name = "online", size = "14")</span>
                    @else
                        <span class="d-flex">@template.layout.icon(name = "shop", size = "14")</span>
                    @endif
                    ${meeting.getFormat()}
                </span>
                <span class="text-muted fw-bold small d-inline-flex align-items-center gap-1">
                    <span class="d-flex">@template.layout.icon(name = "calendar", size = "14")</span>
                    ${meeting.getFullDate()}
                </span>
            </div>
            <h1 class="fw-bold mb-0 position-relative" style="color: #064e3b; z-index: 2; font-size: 2.2rem;">
                ${meeting.getName()}
            </h1>
        </div>

        <div class="mb-5">
            <div class="section-title d-inline-flex align-items-center gap-2">
                <span class="d-flex text-muted">@template.layout.icon(name = "archive", size = "16")</span> Офіційні матеріали
            </div>

            <div class="d-flex flex-wrap gap-3">
                @if(meeting.getAdminResources() == null || meeting.getAdminResources().isEmpty())
                    <div class="w-100 p-4 text-center bg-light rounded-4 border text-muted small fw-medium">
                        До цього модуля не додано офіційних методичок.
                    </div>
                @else
                    @for(var resource : meeting.getAdminResources())
                        <a href="${resource.getUrl()}" target="_blank" class="file-pill">
                            <span class="file-pill-icon">
                                @if(resource.getType().name().equals("VIDEO"))
                                    <span class="d-flex text-danger">@template.layout.icon(name = "video", size = "18")</span>
                                @elseif(resource.getUrl().contains(".pdf"))
                                    <span class="d-flex text-primary">@template.layout.icon(name = "books", size = "18")</span>
                                @else
                                    <span class="d-flex text-primary">@template.layout.icon(name = "document", size = "18")</span>
                                @endif
                            </span>
                            <span class="file-pill-text">${resource.getTitle()}</span>
                        </a>
                    @endfor
                @endif
            </div>
        </div>

        <div>
            <div class="section-title d-inline-flex align-items-center gap-2">
                <span class="d-flex text-muted">@template.layout.icon(name = "personIcon", size = "16")</span> Практичні роботи команд
            </div>

            @if(meeting.getTeams() == null || meeting.getTeams().isEmpty())
                <div class="w-100 p-4 text-center bg-light rounded-4 border text-muted small fw-medium">
                    У цьому модулі немає збережених робіт від команд.
                </div>
            @else
                <div class="d-flex flex-column">
                    @for(var team : meeting.getTeams())
                        <div class="team-card">
                            <div class="mb-4">
                                <h3 class="team-topic">
                                    @if(team.getTopic() != null && !team.getTopic().equals("Загальна тема"))
                                        ${team.getTopic()}
                                    @else
                                        Матеріали команди
                                    @endif
                                </h3>

                                <div class="team-author d-inline-flex align-items-center gap-1">
                                    <span class="d-flex text-muted">@template.layout.icon(name = "personIcon", size = "16")</span> Автор:
                                    <strong>${team.getName()}</strong>
                                </div>
                            </div>

                            <div class="d-flex flex-wrap gap-2">
                                @if(team.getSubmissions() == null || team.getSubmissions().isEmpty())
                                    <span class="text-muted small bg-light px-3 py-2 rounded-3 border">Немає прикріплених файлів.</span>
                                @else
                                    @for(var sub : team.getSubmissions())
                                        <a href="${sub.getUrl()}" target="_blank" class="file-pill"
                                           style="font-size: 0.85rem; padding: 8px 14px;">
                                            <span class="file-pill-icon">
                                                @if(sub.getType().name().equals("LINK"))
                                                    <span class="d-flex text-secondary">@template.layout.icon(name = "link", size = "16")</span>
                                                @else
                                                    <span class="d-flex text-primary">@template.layout.icon(name = "document", size = "16")</span>
                                                @endif
                                            </span>
                                            <span class="file-pill-text">${sub.getFileName()}</span>
                                        </a>
                                    @endfor
                                @endif
                            </div>
                        </div>
                    @endfor
                </div>
            @endif
        </div>
    </div>
`)