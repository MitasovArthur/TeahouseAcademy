@import com.teahouse.teahouse_academy.model.entity.TeamEntity
@import java.time.format.DateTimeFormatter
@import java.util.List

@param List<TeamEntity> pendingTeams
@param java.lang.Long pendingCount = 0L

@template.layout.main(content = @`
    <div class="container my-5">
        @template.pages.admin.components.admin-tabs(activeTab = "verification", pendingCount = pendingCount)

        <div class="mb-4 px-2">
            <h5 class="fw-bold text-dark">Контроль завдань</h5>
            <p class="text-muted small">Перевірка завантажених файлів та посилань від команд</p>
        </div>

        <div class="row g-4">
            @if(pendingTeams.isEmpty())
                <div class="col-12 text-center py-5 bg-white rounded-4 shadow-sm" style="border-radius: 20px;">
                    <h5 class="text-muted">Наразі немає нових робіт для перевірки.</h5>
                </div>
            @else
                @for(var team : pendingTeams)
                    <div class="col-12">
                        <div class="card border-0 shadow-sm" style="border-radius: 20px; overflow: hidden;">
                            <div class="card-body p-4">
                                <div class="row align-items-center">
                                    <div class="col-md-4 mb-3 mb-md-0">
                                        <div class="text-muted small fw-bold text-uppercase mb-1"
                                             style="font-size: 0.7rem;">Зібрання / Тема
                                        </div>
                                        <h6 class="fw-bold text-dark mb-0">${team.getMeeting().getName()}</h6>
                                        <div class="small"
                                             style="color: var(--tea-mid);">${team.getTopic() != null ? team.getTopic() : "Загальна тема"}</div>
                                    </div>

                                    <div class="col-md-3 mb-3 mb-md-0">
                                        <div class="text-muted small fw-bold text-uppercase mb-1"
                                             style="font-size: 0.7rem;">Команда
                                        </div>
                                        <div class="fw-bold text-dark">${team.getName()}</div>
                                    </div>

                                    <div class="col-md-5 text-md-end mt-2 mt-md-0">
                                        <div class="d-flex gap-2 justify-content-md-end">
                                            <button type="button"
                                                    class="btn btn-outline-secondary fw-bold w-100 w-md-auto"
                                                    style="border-radius: 12px;"
                                                    data-bs-toggle="collapse"
                                                    data-bs-target="#review-${team.getId()}">
                                                Перевірити роботу
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="collapse mt-4 pt-4 border-top" id="review-${team.getId()}">
                                    <div class="row">
                                        <div class="col-lg-6 mb-4 mb-lg-0">
                                            <h6 class="fw-bold mb-3">Надані матеріали:</h6>
                                            @if(team.getSubmissions() != null)
                                                @for(var sub : team.getSubmissions())
                                                    <div class="p-3 bg-light rounded-3 mb-2 d-flex justify-content-between align-items-center flex-wrap gap-2">
                                                        <a href="${sub.getFileLink()}" target="_blank"
                                                           class="d-flex align-items-center gap-2 text-decoration-none fw-bold text-tea text-truncate"
                                                           style="max-width: 100%;">
                                                            <span style="font-size: 1.1rem; flex-shrink: 0;">
                                                                @if(sub.getType().name().equals("VIDEO"))
                                                                    <i class="bi bi-play-circle-fill"
                                                                       style="color: #ef4444;"></i>
                                                                @elseif(sub.getType().name().equals("DOCUMENT") || sub.getType().name().equals("BOOK"))
                                                                    <i class="bi bi-file-earmark-text-fill"
                                                                       style="color: #3b82f6;"></i>
                                                                @elseif(sub.getType().name().equals("PRESENTATION"))
                                                                    <i class="bi bi-file-earmark-slides-fill"
                                                                       style="color: #f59e0b;"></i>
                                                                @elseif(sub.getType().name().equals("IMAGE"))
                                                                    <i class="bi bi-image-fill"
                                                                       style="color: #10b981;"></i>
                                                                @elseif(sub.getType().name().equals("ARCHIVE"))
                                                                    <i class="bi bi-file-earmark-zip-fill"
                                                                       style="color: #64748b;"></i>
                                                                @else
                                                                    <i class="bi bi-link-45deg"
                                                                       style="color: #64748b;"></i>
                                                                @endif
                                                            </span>
                                                            <span class="text-truncate">
                                                                ${sub.getFileName() != null && !sub.getFileName().isBlank() ? sub.getFileName() : "Зовнішнє посилання"}
                                                            </span>
                                                        </a>
                                                        <span class="text-muted small text-nowrap"
                                                              style="font-size: 0.7rem;">
                                                            ${sub.getCreatedAt().toLocalDate().toString()}
                                                        </span>
                                                    </div>
                                                @endfor
                                            @endif
                                        </div>

                                        <div class="col-lg-6">
                                            @if(team.getComments() != null && !team.getComments().isEmpty())
                                                <div class="mb-3">
                                                    <div class="text-muted small fw-bold text-uppercase mb-2"
                                                         style="font-size: 0.75rem;">Історія перевірки:
                                                    </div>
                                                    <div class="d-flex flex-column gap-2 border p-3 rounded-4 bg-light"
                                                         style="max-height: 200px; overflow-y: auto;">
                                                        @for(var comment : team.getComments())
                                                            <div class="p-2 border-bottom last-border-0"
                                                                 style="font-size: 0.9rem;">
                                                                <div class="d-flex justify-content-between text-muted extra-small fw-bold mb-1">
                                                                    <span>${comment.getActionType().equals("APPROVE") ? "🟢 ЗАРАХОВАНО" : "🔵 ЗАУВАЖЕННЯ"}</span>
                                                                    <span>${comment.getCreatedAt().format(DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm"))}</span>
                                                                </div>
                                                                <div class="text-dark">${comment.getText()}</div>
                                                            </div>
                                                        @endfor
                                                    </div>
                                                </div>
                                            @endif

                                            <form action="/admin/academy/teams/approve/${team.getId()}" method="POST"
                                                  class="review-feedback-form">
                                                <h6 class="fw-bold mb-2 mt-3">Ваш відгук (команді):</h6>
                                                <textarea name="feedback" class="form-control mb-3" rows="3"
                                                          placeholder="Напишіть зауваження або фінальний залік..."
                                                          style="border-radius: 12px;"></textarea>

                                                <div class="d-flex gap-3 flex-column flex-sm-row">
                                                    <button type="submit" name="action" value="comment"
                                                            class="btn btn-outline-secondary flex-grow-1 fw-bold py-2"
                                                            style="border-radius: 12px;">
                                                        Зауваження
                                                    </button>
                                                    <button type="submit" name="action" value="approve"
                                                            class="btn btn-success flex-grow-1 fw-bold py-2"
                                                            style="border-radius: 12px;">
                                                        Зарахувати
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
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
                    const clickedButton = document.activeElement;
                    if (clickedButton && clickedButton.value === "approve") {
                        const confirmed = confirm("⚠️ Ви впевнені, що хочете ЗАРАХУВАТИ роботу цієї команди?\nПісля цього завдання закриється, і бариста більше НЕ зможуть вносити зміни чи додавати файли.");
                        if (!confirmed) {
                            e.preventDefault();
                        }
                    }
                });
            });
        });
    </script>
`)