@import java.util.List
@import java.util.Map
@import com.teahouse.teahouse_academy.model.dto.tea.TeaRequestDto
@import com.teahouse.teahouse_academy.model.dto.attribute.AttributeShortDto
@import com.teahouse.teahouse_academy.model.enumProject.TypeTea

@param TeaRequestDto teaForm
@param List<TypeTea> teaTypes
@param List<AttributeShortDto> components
@param List<AttributeShortDto> countries
@param List<AttributeShortDto> regions
@param Long teaId = null
@param String codeTeaError = ""

@template.layout.main(content = @`
    <div class="container my-5" style="max-width: 720px;">

        <h2 class="tea-green mb-4">
            ${teaId == null ? "Додати чай" : "Редагувати чай"}
        </h2>

        <form method="post"
              action="${teaId == null ? "/teas/new" : "/teas/" + teaId + "/edit"}">

            <div class="mb-3">
                <label class="form-label fw-semibold">Код чаю</label>
                <input type="number" name="codeTea" class="form-control border-success"
                       value="${teaForm.getCodeTea() != null ? String.valueOf(teaForm.getCodeTea()) : ""}"
                       required>
                @if(!codeTeaError.isEmpty())
                    <div class="text-danger small mt-1">${codeTeaError}</div>
                @endif
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Назва</label>
                <input type="text" name="name" class="form-control border-success"
                       value="${teaForm.getName() != null ? teaForm.getName() : ""}"
                       required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Тип чаю</label>
                <select name="type" class="form-select border-success" required>
                    <option value="">— Оберіть тип —</option>
                    @for(TypeTea t : teaTypes)
                        @if(teaForm.getType() != null && teaForm.getType() == t)
                            <option value="${t.name()}" selected>${t.getDisplayName()}</option>
                        @else
                            <option value="${t.name()}">${t.getDisplayName()}</option>
                        @endif
                    @endfor
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Опис</label>
                <textarea name="description" class="form-control border-success"
                          rows="4" required>${teaForm.getDescription() != null ? teaForm.getDescription() : ""}</textarea>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold">Атрибути</label>

                <ul class="nav nav-tabs mb-2" id="attrTabs">
                    <li class="nav-item">
                        <button type="button" class="nav-link active" data-tab="components">🌿 Компоненти</button>
                    </li>
                    <li class="nav-item">
                        <button type="button" class="nav-link" data-tab="countries">🌍 Країни</button>
                    </li>
                    <li class="nav-item">
                        <button type="button" class="nav-link" data-tab="regions">📍 Регіони</button>
                    </li>
                </ul>

                <input type="text" id="attrSearch" class="form-control form-control-sm border-success mb-2"
                       placeholder="Пошук...">

                <div class="border border-success rounded p-3" style="max-height: 280px; overflow-y: auto;">

                    <div id="tab-components">
                        @for(AttributeShortDto attr : components)
                            @if(teaForm.getAttributeIds() != null && teaForm.getAttributeIds().contains(attr.getId()))
                                <div class="form-check attr-item" data-name="${attr.getName().toLowerCase()}">
                                    <input class="form-check-input" type="checkbox"
                                           name="attributeIds" value="${attr.getId()}"
                                           id="attr-${attr.getId()}" checked>
                                    <label class="form-check-label" for="attr-${attr.getId()}">${attr.getName()}</label>
                                </div>
                            @else
                                <div class="form-check attr-item" data-name="${attr.getName().toLowerCase()}">
                                    <input class="form-check-input" type="checkbox"
                                           name="attributeIds" value="${attr.getId()}"
                                           id="attr-${attr.getId()}">
                                    <label class="form-check-label" for="attr-${attr.getId()}">${attr.getName()}</label>
                                </div>
                            @endif
                        @endfor
                    </div>

                    <div id="tab-countries" style="display:none;">
                        @for(AttributeShortDto attr : countries)
                            @if(teaForm.getAttributeIds() != null && teaForm.getAttributeIds().contains(attr.getId()))
                                <div class="form-check attr-item" data-name="${attr.getName().toLowerCase()}">
                                    <input class="form-check-input" type="checkbox"
                                           name="attributeIds" value="${attr.getId()}"
                                           id="attr-${attr.getId()}" checked>
                                    <label class="form-check-label" for="attr-${attr.getId()}">${attr.getName()}</label>
                                </div>
                            @else
                                <div class="form-check attr-item" data-name="${attr.getName().toLowerCase()}">
                                    <input class="form-check-input" type="checkbox"
                                           name="attributeIds" value="${attr.getId()}"
                                           id="attr-${attr.getId()}">
                                    <label class="form-check-label" for="attr-${attr.getId()}">${attr.getName()}</label>
                                </div>
                            @endif
                        @endfor
                    </div>

                    <div id="tab-regions" style="display:none;">
                        @for(AttributeShortDto attr : regions)
                            @if(teaForm.getAttributeIds() != null && teaForm.getAttributeIds().contains(attr.getId()))
                                <div class="form-check attr-item" data-name="${attr.getName().toLowerCase()}">
                                    <input class="form-check-input" type="checkbox"
                                           name="attributeIds" value="${attr.getId()}"
                                           id="attr-${attr.getId()}" checked>
                                    <label class="form-check-label" for="attr-${attr.getId()}">${attr.getName()}</label>
                                </div>
                            @else
                                <div class="form-check attr-item" data-name="${attr.getName().toLowerCase()}">
                                    <input class="form-check-input" type="checkbox"
                                           name="attributeIds" value="${attr.getId()}"
                                           id="attr-${attr.getId()}">
                                    <label class="form-check-label" for="attr-${attr.getId()}">${attr.getName()}</label>
                                </div>
                            @endif
                        @endfor
                    </div>

                </div>
            </div>

            <div class="d-flex gap-2 mt-4">
                <button type="submit" class="btn btn-success px-4">
                    ${teaId == null ? "Створити" : "Зберегти"}
                </button>
                <a href="/teas" class="btn btn-outline-secondary">Скасувати</a>
                @if(teaId != null)
                    <button type="button" class="btn btn-outline-danger ms-auto"
                            data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">
                        🗑️ Видалити
                    </button>
                @endif
            </div>

        </form>
    </div>

    @if(teaId != null)
        <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-sm">
                <div class="modal-content">
                    <div class="modal-header bg-light">
                        <h5 class="modal-title fw-bold text-danger">Видалити чай?</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p class="mb-0">Цю дію неможливо скасувати.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Скасувати</button>
                        <form method="post" action="/teas/${teaId}/delete">
                            <button type="submit" class="btn btn-danger">Видалити</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    @endif

    <style>
        .tea-green { color: rgb(14, 87, 39); }
        .nav-link { color: rgb(14, 87, 39); cursor: pointer; }
        .nav-link.active { color: white; background-color: rgb(14, 87, 39); border-color: rgb(14, 87, 39); }
    </style>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const tabs = ["components", "countries", "regions"];
            let activeTab = "components";

            document.querySelectorAll("#attrTabs .nav-link").forEach(btn => {
                btn.addEventListener("click", function () {
                    activeTab = this.dataset.tab;
                    tabs.forEach(t => {
                        document.getElementById("tab-" + t).style.display = t === activeTab ? "" : "none";
                    });
                    document.querySelectorAll("#attrTabs .nav-link").forEach(b => b.classList.remove("active"));
                    this.classList.add("active");
                    document.getElementById("attrSearch").value = "";
                    document.querySelectorAll(".attr-item").forEach(i => i.style.display = "");
                });
            });

            document.getElementById("attrSearch").addEventListener("input", function () {
                const val = this.value.toLowerCase();
                document.querySelectorAll("#tab-" + activeTab + " .attr-item").forEach(item => {
                    item.style.display = item.dataset.name.includes(val) ? "" : "none";
                });
            });
        });
    </script>
`)