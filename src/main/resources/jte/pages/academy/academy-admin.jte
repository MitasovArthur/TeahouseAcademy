@import com.teahouse.teahouse_academy.model.dto.academy.AcademyDashboardResponseDto
@import com.teahouse.teahouse_academy.model.entity.TagEntity

@param java.util.List<AcademyDashboardResponseDto> dashboards
@param java.util.List<TagEntity> allTags

@template.layout.main(isAdmin = true, content = @`

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
                    <p class="text-muted">Немає активних зібрань для моніторингу.</p>
                </div>

            @else
                @for(var dashboard : dashboards)

                    <div class="ac-meeting">
                        <div class="ac-meeting-accent">
                            <div class="ac-meeting-body">

                                <div class="ac-stats-bar">
                                    <div class="ac-stats-left">
                                        <i class="bi bi-bar-chart-fill"></i>
                                        Здано:
                                        <span class="ac-stats-pill">${dashboard.getSubmittedTeamsCount()} / ${dashboard.getTotalTeamsCount()}</span>
                                        команд
                                        @if(dashboard.getSubmittedTeamsCount() == dashboard.getTotalTeamsCount() && dashboard.getTotalTeamsCount() > 0)
                                            <span class="ac-stats-all">Всі здали!</span>
                                        @endif
                                    </div>
                                    <button type="button" class="ac-finish-btn" data-bs-toggle="modal"
                                            data-bs-target="#completeMeetingModal-${dashboard.getMeetingId()}">
                                        Завершити зібрання
                                    </button>
                                </div>

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
                                    <div class="ac-other-label">Моніторинг команд</div>
                                    @for(var team : dashboard.getTeams())
                                        <div class="ac-admin-row
                                            @if(team.getStatus().name().equals("DONE"))border-done
                                            @elseif(team.getStatus().name().equals("SUBMITTED"))border-pending
                                            @else border-working
                                            @endif">

                                            <div class="ac-admin-info">
                                                <div class="ac-row-name">${team.getName()}</div>
                                                @if(team.getSubtopic() != null && !team.getSubtopic().isEmpty())
                                                    <div class="ac-row-topic d-inline-flex align-items-center gap-1">
                                                        <span class="d-flex text-muted">@template.layout.icon(name = "notebook", size = "16")</span>
                                                        ${team.getSubtopic()}
                                                    </div>
                                                @endif
                                            </div>

                                            <div class="ac-admin-actions">
                                                @if(team.getStatus().name().equals("SUBMITTED"))
                                                    <span class="ac-status ac-status-pending d-inline-flex align-items-center gap-1">
                                                        <span class="d-flex">@template.layout.icon(name = "inProgress", size = "16")</span> На перевірці
                                                    </span>
                                                @elseif(team.getStatus().name().equals("DONE"))
                                                    <span class="ac-status ac-status-done d-inline-flex align-items-center gap-1">
                                                        <span class="d-flex">@template.layout.icon(name = "confirm", size = "16")</span> Зараховано
                                                    </span>
                                                @else
                                                    <span class="ac-status ac-status-working d-inline-flex align-items-center gap-1">
                                                        <span class="d-flex">@template.layout.icon(name = "inWork", size = "16")</span> В роботі
                                                    </span>
                                                @endif

                                                <button class="ac-btn ac-btn-ghost d-inline-flex align-items-center gap-1"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#teamModal-${dashboard.getMeetingId()}-${team.getId()}">
                                                    <span class="d-flex text-muted">@template.layout.icon(name = "personIcon", size = "18")</span>
                                                    ${team.getUserFullNames() != null ? team.getUserFullNames().size() : 0}
                                                </button>

                                                @if(team.getStatus().name().equals("SUBMITTED"))
                                                    <button type="button"
                                                            class="ac-btn ac-btn-outline d-inline-flex align-items-center gap-2"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#reviewModal-${dashboard.getMeetingId()}-${team.getId()}">
                                                        <span class="d-flex text-tea">@template.layout.icon(name = "search", size = "16")</span>
                                                        Перевірити
                                                    </button>
                                                @endif
                                            </div>
                                        </div>
                                    @endfor
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

                    @for(var team : dashboard.getTeams())
                        @if(!team.getStatus().name().equals("DONE"))
                            <div class="modal fade" id="reviewModal-${dashboard.getMeetingId()}-${team.getId()}"
                                 tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered modal-md">
                                    <div class="modal-content">
                                        <div class="modal-header border-0 px-4 pt-4 pb-2">
                                            <div>
                                                <h4 class="modal-title fw-bold mb-1">Перевірка: ${team.getName()}</h4>
                                                @if(team.getSubtopic() != null && !team.getSubtopic().isEmpty())
                                                    <div class="text-muted small d-inline-flex align-items-center gap-1">
                                                        <span class="d-flex">@template.layout.icon(name = "notebook", size = "16")</span>
                                                        ${team.getSubtopic()}
                                                    </div>
                                                @endif
                                            </div>
                                            <button type="button" class="btn-close align-self-start"
                                                    data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body px-4 py-3">

                                            @if(team.getComments() != null && !team.getComments().isEmpty())
                                                <div class="mb-4">
                                                    <div class="ac-section-label">Попередні рішення</div>
                                                    <div style="max-height:180px; overflow-y:auto;">
                                                        @for(var comment : team.getComments())
                                                            <div class="ac-comment ${comment.getActionType().equals("APPROVE") ? "ac-comment-approve" : "ac-comment-action"}">
                                                                <div class="ac-comment-meta d-flex align-items-center gap-2">
                                                                    @if(comment.getActionType().equals("APPROVE"))
                                                                        <span class="d-inline-flex align-items-center gap-1 text-success fw-bold">
                                                                            <span class="d-flex">@template.layout.icon(name = "circle", size = "12")</span> ЗАРАХОВАНО
                                                                        </span>
                                                                    @else
                                                                        <span class="d-inline-flex align-items-center gap-1 text-primary fw-bold">
                                                                            <span class="d-flex">@template.layout.icon(name = "circle", size = "12")</span> ЗАУВАЖЕННЯ
                                                                        </span>
                                                                    @endif
                                                                    <span class="text-muted">${comment.getCreatedAt()}</span>
                                                                </div>
                                                                <div class="mt-1">${comment.getText()}</div>
                                                            </div>
                                                        @endfor
                                                    </div>
                                                </div>
                                            @endif


                                            <div class="mb-4">
                                                <div class="ac-section-label d-flex align-items-center gap-2">
                                                    <span class="d-flex text-muted">@template.layout.icon(name = "notebook", size = "18")</span>
                                                    Матеріали команди
                                                    (${team.getSubmissions() != null ? team.getSubmissions().size() : 0}
                                                    )
                                                </div>
                                                @if(team.getSubmissions() != null && !team.getSubmissions().isEmpty())
                                                    <div style="display:flex; flex-direction:column; gap:8px;">
                                                        @for(var sub : team.getSubmissions())
                                                            <div class="ac-sub-item">
                                                                <span class="ac-sub-url d-inline-flex align-items-center gap-2">
                                                                    @if(sub.getType().name().equals("VIDEO"))
                                                                        <span class="d-flex text-danger">@template.layout.icon(name = "video", size = "18")</span>
                                                                    @elseif(sub.getType().name().equals("DOCUMENT") || sub.getType().name().equals("BOOK"))
                                                                        <span class="d-flex text-primary">@template.layout.icon(name = "document", size = "18")</span>
                                                                    @elseif(sub.getType().name().equals("PRESENTATION"))
                                                                        <span class="d-flex text-warning">@template.layout.icon(name = "presentation", size = "18")</span>
                                                                    @elseif(sub.getType().name().equals("IMAGE"))
                                                                        <span class="d-flex text-success">@template.layout.icon(name = "image", size = "18")</span>
                                                                    @elseif(sub.getType().name().equals("ARCHIVE"))
                                                                        <span class="d-flex text-secondary">@template.layout.icon(name = "archive", size = "18")</span>
                                                                    @else
                                                                        <span class="d-flex text-secondary">@template.layout.icon(name = "link", size = "18")</span>
                                                                    @endif
                                                                    ${sub.getFileName() != null ? sub.getFileName() : "Посилання"}
                                                                </span>
                                                                <a href="${sub.getFileLink()}" target="_blank"
                                                                   class="ac-btn ac-btn-outline"
                                                                   style="padding:5px 14px; font-size:.82rem;">Відкрити</a>
                                                            </div>
                                                        @endfor
                                                    </div>
                                                @else
                                                    <div class="text-muted small p-3 rounded-3"
                                                         style="background:var(--section-bg);">
                                                        Команда ще не завантажила матеріалів.
                                                    </div>
                                                @endif
                                            </div>

                                            <form action="/academy/admin/feedback" method="POST"
                                                  class="review-feedback-form">
                                                <input type="hidden" name="teamId" value="${team.getId()}">
                                                <div class="mb-3">
                                                    <div class="ac-section-label d-flex align-items-center gap-2">
                                                        <span class="d-flex text-muted">@template.layout.icon(name = "comment", size = "18")</span>
                                                        Новий коментар команді
                                                    </div>
                                                    <textarea name="feedback" class="form-control" rows="3"
                                                              style="border-radius:12px; font-size:.92rem;"
                                                              placeholder="Зауваження або підтвердження..."></textarea>
                                                </div>
                                                <div class="d-flex gap-3">
                                                    <button type="submit" name="action" value="comment"
                                                            class="btn btn-outline-secondary flex-grow-1 fw-bold py-2 d-inline-flex align-items-center justify-content-center gap-2"
                                                            style="border-radius:10px;">
                                                        <span class="d-flex">@template.layout.icon(name = "comment", size = "18")</span>
                                                        Зауваження
                                                    </button>
                                                    <button type="submit" name="action" value="approve"
                                                            class="btn btn-success flex-grow-1 fw-bold py-2 d-inline-flex align-items-center justify-content-center gap-2"
                                                            style="border-radius:10px;">
                                                        <span class="d-flex">@template.layout.icon(name = "confirm", size = "18")</span>
                                                        Зарахувати
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        @endif
                    @endfor

                    <div class="modal fade" id="completeMeetingModal-${dashboard.getMeetingId()}" tabindex="-1"
                         aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-lg">
                            <div class="modal-content">
                                <div class="modal-header border-0 px-4 pt-4 pb-2">
                                    <div>
                                        <h4 class="modal-title fw-bold mb-1">Завершення зібрання</h4>
                                        <div class="text-muted small">Підготуйте матеріали для Бази знань.</div>
                                    </div>
                                    <button type="button" class="btn-close align-self-start"
                                            data-bs-dismiss="modal"></button>
                                </div>
                                <form action="/admin/academy/meetings/complete/${dashboard.getMeetingId()}"
                                      method="POST">
                                    <div class="modal-body px-4 py-3">
                                        <div class="alert alert-success" style="border-radius:12px; font-size:.92rem;">
                                            Після завершення зібрання переміститься в Архів. Команди більше не зможуть
                                            додавати або редагувати файли.
                                        </div>
                                        <div class="mb-3">
                                            <label class="fw-bold mb-2">Теги для пошуку в Базі знань:</label>
                                            <div class="input-group mb-3">
                                                <span class="input-group-text bg-light border-end-0 text-muted d-flex justify-content-center align-items-center">
                                                    @template.layout.icon(name = "search", size = "18")
                                                </span>
                                                <input type="text" class="form-control border-start-0 ac-tag-search"
                                                       data-meeting-id="${dashboard.getMeetingId()}"
                                                       placeholder="Пошук тегу..." style="box-shadow:none;">
                                            </div>
                                            <div class="d-none ac-new-tag-prompt mb-2"
                                                 id="tag-prompt-${dashboard.getMeetingId()}">
                                                <span class="text-muted small me-2">Тег не знайдено.</span>
                                                <button type="button"
                                                        class="btn btn-sm btn-outline-success rounded-pill ac-create-tag-btn"
                                                        data-meeting-id="${dashboard.getMeetingId()}">
                                                    + Створити "<span class="ac-new-tag-name"></span>"
                                                </button>
                                            </div>
                                            <div class="ac-tag-list border rounded-3 p-3"
                                                 id="tag-container-${dashboard.getMeetingId()}">
                                                @if(allTags != null && !allTags.isEmpty())
                                                    @for(var tag : allTags)
                                                        <div class="ac-tag-wrap tag-item"
                                                             data-name="${tag.getName().toLowerCase()}">
                                                            <input type="checkbox" name="tagNames"
                                                                   value="${tag.getName()}"
                                                                   id="tag-${dashboard.getMeetingId()}-${tag.getId()}">
                                                            <label class="ac-tag-label"
                                                                   for="tag-${dashboard.getMeetingId()}-${tag.getId()}">#${tag.getName()}</label>
                                                        </div>
                                                    @endfor
                                                @endif
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer border-0 px-4 py-3"
                                         style="background:var(--section-bg); border-radius:0 0 16px 16px;">
                                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                            Скасувати
                                        </button>
                                        <button type="submit" class="btn btn-success fw-bold px-4">Відправити в Архів
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                @endfor
            @endif

        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {

            document.querySelectorAll(".review-feedback-form").forEach(form => {
                form.addEventListener("submit", function (e) {
                    const btn = document.activeElement;
                    if (btn && btn.value === "approve") {
                        const ok = confirm("Зарахувати роботу команди?\nПісля цього бариста більше НЕ зможуть вносити зміни.");
                        if (!ok) e.preventDefault();
                    }
                });
            });

            document.querySelectorAll(".ac-tag-search").forEach(input => {
                input.addEventListener("input", function () {
                    const mid = this.dataset.meetingId;
                    const q = this.value.toLowerCase().trim();
                    const cont = document.getElementById("tag-container-" + mid);
                    const prompt = document.getElementById("tag-prompt-" + mid);
                    let hasExact = false;

                    cont.querySelectorAll(".tag-item").forEach(item => {
                        const n = item.dataset.name;
                        item.style.display = (n.includes(q) || q === "") ? "" : "none";
                        if (n === q) hasExact = true;
                    });

                    if (q && !hasExact) {
                        prompt.querySelector(".ac-new-tag-name").textContent = this.value;
                        prompt.classList.remove("d-none");
                    } else {
                        prompt.classList.add("d-none");
                    }
                });
            });

            document.querySelectorAll(".ac-create-tag-btn").forEach(btn => {
                btn.addEventListener("click", function () {
                    const mid = this.dataset.meetingId;
                    const prompt = document.getElementById("tag-prompt-" + mid);
                    const name = prompt.querySelector(".ac-new-tag-name").textContent.trim();
                    const cont = document.getElementById("tag-container-" + mid);
                    const search = document.querySelector(".ac-tag-search[data-meeting-id='" + mid + "']");
                    const uid = "ntag-" + Date.now();

                    cont.insertAdjacentHTML("afterbegin",
                        '<div class="ac-tag-wrap tag-item" data-name="' + name.toLowerCase() + '">' +
                        '<input type="checkbox" name="tagNames" value="' + name + '" id="' + uid + '" checked>' +
                        '<label class="ac-tag-label" for="' + uid + '">#' + name + '</label>' +
                        '</div>');

                    search.value = "";
                    search.dispatchEvent(new Event("input"));
                });
            });

        });
    </script>
`)
