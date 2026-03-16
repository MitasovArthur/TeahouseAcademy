@import java.util.List
@import java.util.Map
@import com.teahouse.teahouse_academy.model.dto.tea.TeaDto
@import com.teahouse.teahouse_academy.model.enumProject.TypeTea

@param List<TypeTea> teaTypes
@param List<TeaDto> teas
@param String searchQuery = ""
@param Map<String, List<String>> groupedComponents
@param Map<String, List<String>> groupedCountries
@param String selectedType = ""
@param boolean isAdmin = false

@template.layout.main(content = @`
    <div class="container my-5">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="tea-green mb-0">Чайний Навігатор</h2>
            @if(isAdmin)
                <a href="/teas/new" class="btn btn-success">
                    + Додати чай
                </a>
            @endif
        </div>

        <form action="/teas" method="get" class="mb-5" id="searchForm">
            <div class="row g-2">
                <div class="col-md-7">
                    <div class="input-group input-group-lg">
                        <input type="text" name="search" id="searchInput"
                               class="form-control border-success"
                               placeholder="Введіть інгредієнт, регіон..."
                               value="${searchQuery}" autocomplete="off">
                        <button class="btn btn-outline-success" type="button"
                                data-bs-toggle="modal" data-bs-target="#ingredientsModal">
                            🌿 Склад
                        </button>
                        <button class="btn btn-outline-success" type="button"
                                data-bs-toggle="modal" data-bs-target="#countriesModal">
                            🗺️ Регіони
                        </button>
                    </div>
                </div>

                <div class="col-md-3">
                    <input type="hidden" name="type" id="hiddenTypeInput" value="${selectedType}">
                    <button type="button"
                            class="btn btn-outline-success btn-lg w-100 text-start d-flex justify-content-between align-items-center"
                            data-bs-toggle="modal" data-bs-target="#teaTypesModal">
                        <span id="typeBtnLabel">
                            ${selectedType.isEmpty() ? "Всі види чаю" : selectedType}
                        </span>
                        <span>▼</span>
                    </button>
                </div>

                <div class="col-md-2">
                    <button class="btn btn-success btn-lg w-100" type="submit">Знайти</button>
                </div>
            </div>
        </form>

        <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
            @if(teas.isEmpty())
                <div class="col-12 text-center text-muted mt-5">
                    <h4 class="fw-bold">За вашим запитом нічого не знайдено 😔</h4>
                    <p>Спробуйте змінити критерії пошуку.</p>
                </div>
            @else
                @for(TeaDto tea : teas)
                    <div class="col">
                        <div class="card h-100 shadow-sm border-0">
                            <div class="card-body">
                                <h5 class="card-title fw-bold">${tea.getName()}</h5>
                                <h6 class="card-subtitle mb-3 text-muted">Номер: ${tea.getCodeTea()}</h6>
                                <p class="card-text" style="color:#4a4a4a; line-height:1.5;">
                                    ${tea.getDescription()}
                                </p>
                            </div>
                            <div class="card-footer bg-white border-0 pt-0 d-flex justify-content-between align-items-center gap-2">
                                <button class="btn btn-sm text-white tea-bg details-btn"
                                        data-tea-name="${tea.getName()}"
                                        data-tea-components='${tea.getComponentsShort() != null ? tea.getComponentsShort().stream().map(c -> c.getName()).toList().toString() : "[]"}'>
                                    Детальніше
                                </button>

                                @if(isAdmin)
                                    <div class="d-flex gap-1 ms-auto">
                                        <a href="/teas/${tea.getId()}/edit"
                                           class="btn btn-sm btn-outline-secondary"
                                           title="Редагувати">
                                            ✏️
                                        </a>
                                        <button type="button"
                                                class="btn btn-sm btn-outline-danger delete-btn"
                                                data-tea-id="${tea.getId()}"
                                                data-tea-name="${tea.getName()}"
                                                title="Видалити">
                                            🗑️
                                        </button>
                                    </div>
                                @endif
                            </div>
                        </div>
                    </div>
                @endfor
            @endif
        </div>
    </div>

    <div class="modal fade" id="teaDetailsModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-bold tea-green" id="teaDetailsTitle">Склад</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <ul class="list-group list-group-flush" id="teaComponentsList"></ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрити</button>
                </div>
            </div>
        </div>
    </div>

    @if(isAdmin)
        <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-sm">
                <div class="modal-content">
                    <div class="modal-header bg-light">
                        <h5 class="modal-title fw-bold text-danger">Видалити чай?</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p class="mb-0">Ви впевнені що хочете видалити <strong id="deleteTeaName"></strong>?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Скасувати</button>
                        <form id="deleteForm" method="post">
                            <button type="submit" class="btn btn-danger">Видалити</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    @endif

    <div class="modal fade" id="ingredientsModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-bold tea-green">Довідник інгредієнтів</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    @for(var entry : groupedComponents.entrySet())
                        <div class="mb-4">
                            <h5 class="fw-bold border-bottom pb-2 mb-3 tea-green">${entry.getKey()}</h5>
                            <div class="d-flex flex-wrap gap-2">
                                @for(String comp : entry.getValue())
                                    <button type="button"
                                            class="btn btn-sm btn-outline-success picker-btn"
                                            data-value="${comp}">
                                        ${comp}
                                    </button>
                                @endfor
                            </div>
                        </div>
                    @endfor
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-danger me-auto clear-btn">
                        Очистити рядок пошуку
                    </button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрити</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="countriesModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-bold tea-green">Довідник регіонів та країн</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    @if(groupedCountries != null && !groupedCountries.isEmpty())
                        @for(var entry : groupedCountries.entrySet())
                            <div class="mb-4">
                                <h5 class="fw-bold border-bottom pb-2 mb-3 tea-green">${entry.getKey()}</h5>
                                <div class="d-flex flex-wrap gap-2">
                                    @for(String item : entry.getValue())
                                        <button type="button"
                                                class="btn btn-sm btn-outline-success picker-btn"
                                                data-value="${item}">
                                            ${item}
                                        </button>
                                    @endfor
                                </div>
                            </div>
                        @endfor
                    @else
                        <p class="text-muted text-center mt-3">Довідник регіонів наразі порожній.</p>
                    @endif
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-danger me-auto clear-btn">
                        Очистити рядок пошуку
                    </button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрити</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="teaTypesModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-bold tea-green">Оберіть вид чаю</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body d-flex flex-column gap-2">
                    @for(TypeTea t : teaTypes)
                        <button type="button"
                                class="btn type-btn ${t.name().equals(selectedType) ? "btn-success" : "btn-outline-success"}"
                                data-value="${t.name()}"
                                data-label="${t.getDisplayName()}">
                            ${t.getDisplayName()}
                        </button>
                    @endfor
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-danger w-100" id="clearTypeBtn">
                        Скинути вибір
                    </button>
                </div>
            </div>
        </div>
    </div>

    <style>
        .tea-green { color: rgb(14, 87, 39); }
        .tea-bg    { background-color: rgb(14, 87, 39); }
    </style>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const searchInput     = document.getElementById("searchInput");
            const hiddenTypeInput = document.getElementById("hiddenTypeInput");
            const typeBtnLabel    = document.getElementById("typeBtnLabel");

            document.querySelectorAll(".picker-btn").forEach(btn => {
                btn.addEventListener("click", function () {
                    searchInput.value = this.dataset.value;
                    bootstrap.Modal.getOrCreateInstance(this.closest(".modal")).hide();
                });
            });

            document.querySelectorAll(".clear-btn").forEach(btn => {
                btn.addEventListener("click", function () {
                    searchInput.value = "";
                    bootstrap.Modal.getOrCreateInstance(this.closest(".modal")).hide();
                });
            });

            const typeModal = bootstrap.Modal.getOrCreateInstance(document.getElementById("teaTypesModal"));

            document.querySelectorAll(".type-btn").forEach(btn => {
                btn.addEventListener("click", function () {
                    hiddenTypeInput.value    = this.dataset.value;
                    typeBtnLabel.textContent = this.dataset.label;
                    document.querySelectorAll(".type-btn").forEach(b => b.classList.replace("btn-success", "btn-outline-success"));
                    this.classList.replace("btn-outline-success", "btn-success");
                    typeModal.hide();
                });
            });

            document.getElementById("clearTypeBtn").addEventListener("click", function () {
                hiddenTypeInput.value    = "";
                typeBtnLabel.textContent = "Всі види чаю";
                document.querySelectorAll(".type-btn").forEach(b => b.classList.replace("btn-success", "btn-outline-success"));
                typeModal.hide();
            });

            const detailsModal = bootstrap.Modal.getOrCreateInstance(document.getElementById("teaDetailsModal"));
            const detailsTitle = document.getElementById("teaDetailsTitle");
            const detailsList  = document.getElementById("teaComponentsList");

            document.querySelectorAll(".details-btn").forEach(btn => {
                btn.addEventListener("click", function () {
                    detailsTitle.textContent = "Склад: " + this.dataset.teaName;
                    detailsList.innerHTML = "";
                    const raw = this.dataset.teaComponents
                        .replace(/^\[|\]$/g, "").split(",")
                        .map(s => s.trim()).filter(Boolean);

                    if (raw.length === 0 || (raw.length === 1 && raw[0] === "")) {
                        detailsList.innerHTML = "<li class=\"list-group-item text-muted fst-italic\">Склад не вказано</li>";
                    } else {
                        raw.forEach(function(comp) {
                            detailsList.innerHTML +=
                                "<li class=\"list-group-item\"><span class=\"me-2 text-success\">\u2705</span>" + comp + "</li>";
                        });
                    }
                    detailsModal.show();
                });
            });

            const deleteModalEl = document.getElementById("deleteConfirmModal");
            if (deleteModalEl) {
                const deleteModal = bootstrap.Modal.getOrCreateInstance(deleteModalEl);

                document.querySelectorAll(".delete-btn").forEach(btn => {
                    btn.addEventListener("click", function () {
                        document.getElementById("deleteTeaName").textContent = this.dataset.teaName;
                        document.getElementById("deleteForm").action = "/teas/" + this.dataset.teaId + "/delete";
                        deleteModal.show();
                    });
                });
            }
        });
    </script>
`)