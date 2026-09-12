@import com.teahouse.teahouse_academy.model.dto.academy.AdminMeetingDto

@param java.util.List<AdminMeetingDto> activeMeetings
@param java.util.List<AdminMeetingDto> archiveMeetings
@param long pendingCount

@param String successMessage = null
@param String errorMessage = null

@template.layout.main(
successMessage = successMessage,
errorMessage = errorMessage,
content = @`
    <link href="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.snow.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.js"></script>

    <link href="/assets/css/admin.css" rel="stylesheet"/>

    <div class="container my-5">
        @template.pages.admin.components.admin-tabs(activeTab = "academy", pendingCount = pendingCount)

        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 p-3 bg-white shadow-sm rounded-4">
            <h5 class="fw-bold text-dark mb-3 mb-md-0 px-2">Список зібрань Академії</h5>
            <button type="button" class="btn-tea fw-bold shadow-sm" style="border-radius: 10px;" data-bs-toggle="modal"
                    data-bs-target="#createMeetingModal">
                + Створити збори
            </button>
        </div>

        <ul class="nav nav-pills gap-2 mb-4" id="meetingTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="active-tab" data-bs-toggle="tab" data-bs-target="#active-meetings"
                        type="button" role="tab" aria-selected="true">
                    Активні
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="archive-tab" data-bs-toggle="tab" data-bs-target="#archive-meetings"
                        type="button" role="tab" aria-selected="false">
                    Архів
                </button>
            </li>
        </ul>

        <div class="tab-content w-100 mb-5" id="meetingTabsContent">

            <div class="tab-pane fade show active" id="active-meetings" role="tabpanel" aria-labelledby="active-tab">
                <div class="card border-0 shadow-sm" style="border-radius: 16px; overflow: hidden;">
                    <div class="card-body p-0 table-responsive">
                        <table class="table table-hover align-middle mb-0" style="min-width: 800px;">
                            <thead class="bg-light">
                            <tr>
                                <th class="py-3 px-4 text-muted small text-uppercase">Назва зібрання</th>
                                <th class="py-3 text-muted small text-uppercase">Дата</th>
                                <th class="py-3 text-muted small text-uppercase">Формат</th>
                                <th class="py-3 text-center text-muted small text-uppercase">Команди</th>
                                <th class="py-3 text-center text-muted small text-uppercase">Матеріали</th>
                                <th class="py-3 text-end px-4">Дії</th>
                            </tr>
                            </thead>
                            <tbody>
                            @if(activeMeetings.isEmpty())
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-muted">Немає жодного активного
                                        зібрання.
                                    </td>
                                </tr>
                            @else
                                @for(var meeting : activeMeetings)
                                    <tr>
                                        <td class="px-4 fw-bold">
                                            <span style="color: #1e293b;">${meeting.getName()}</span>
                                        </td>
                                        <td class="text-muted">${meeting.getDate()}</td>
                                        <td>
                                            <span class="badge ${meeting.getFormat().equals("Онлайн") ? "badge-online" : "badge-offline"}">${meeting.getFormat()}</span>
                                        </td>
                                        <td class="text-center fw-bold"
                                            style="color: #064e3b;">${meeting.getTeamsCount()}</td>
                                        <td class="text-center text-muted">${meeting.getResourcesCount()}</td>
                                        <td class="text-end px-4">
                                            <div class="d-flex gap-2 justify-content-end">
                                                <button class="btn-tea-outline btn-sm" data-bs-toggle="modal"
                                                        data-bs-target="#manualTeamModal-${meeting.getId()}">Команди
                                                </button>
                                                <button class="btn-gold-outline btn-sm" data-bs-toggle="modal"
                                                        data-bs-target="#materialsModal-${meeting.getId()}">Матеріали
                                                </button>
                                                <div class="dropdown">
                                                    <button class="btn btn-outline-secondary btn-sm dropdown-toggle"
                                                            data-bs-toggle="dropdown">⋮
                                                    </button>
                                                    <ul class="dropdown-menu shadow border-0">
                                                        <li>
                                                            <button class="dropdown-item" data-bs-toggle="modal"
                                                                    data-bs-target="#editMeetingModal-${meeting.getId()}">
                                                                Редагувати
                                                            </button>
                                                        </li>
                                                        <li>
                                                            <hr class="dropdown-divider">
                                                        </li>
                                                        <li>
                                                            <button class="dropdown-item text-danger fw-bold"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#deleteMeetingModal-${meeting.getId()}">
                                                                Видалити
                                                            </button>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                @endfor
                            @endif
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade" id="archive-meetings" role="tabpanel" aria-labelledby="archive-tab">
                <div class="card border-0 shadow-sm" style="border-radius: 16px; overflow: hidden;">
                    <div class="card-body p-0 table-responsive">
                        <table class="table table-hover align-middle mb-0" style="min-width: 800px;">
                            <thead class="bg-light">
                            <tr>
                                <th class="py-3 px-4 text-muted small text-uppercase">Назва зібрання</th>
                                <th class="py-3 text-muted small text-uppercase">Дата</th>
                                <th class="py-3 text-muted small text-uppercase">Формат</th>
                                <th class="py-3 text-center text-muted small text-uppercase">Команди</th>
                                <th class="py-3 text-center text-muted small text-uppercase">Матеріали</th>
                                <th class="py-3 text-end px-4">Статус</th>
                            </tr>
                            </thead>
                            <tbody>
                            @if(archiveMeetings.isEmpty())
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-muted">Архів порожній.</td>
                                </tr>
                            @else
                                @for(var meeting : archiveMeetings)
                                    <tr>
                                        <td class="px-4 fw-bold">
                                            <span style="color: #1e293b;">${meeting.getName()}</span>
                                        </td>
                                        <td class="text-muted">${meeting.getDate()}</td>
                                        <td>
                                            <span class="badge ${meeting.getFormat().equals("Онлайн") ? "badge-online" : "badge-offline"}">${meeting.getFormat()}</span>
                                        </td>
                                        <td class="text-center fw-bold"
                                            style="color: #064e3b;">${meeting.getTeamsCount()}</td>
                                        <td class="text-center text-muted">${meeting.getResourcesCount()}</td>
                                        <td class="text-end px-4">
                                            <div class="d-flex gap-2 justify-content-end align-items-center">
                                                <span class="badge badge-completed">Завершено</span>
                                                <button class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal"
                                                        data-bs-target="#materialsModal-archive-${meeting.getId()}"
                                                        title="Переглянути деталі">Переглянути
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                @endfor
                            @endif
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>

        @for(var meeting : activeMeetings)

            <div class="modal fade" id="manualTeamModal-${meeting.getId()}" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
                        <div class="modal-header bg-light border-0">
                            <h5 class="modal-title fw-bold">Управління командами: ${meeting.getName()}</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body p-4 p-md-5">
                            <div class="d-flex gap-3 mb-4 p-3 bg-light rounded-3" style="align-items: stretch;">

                                <form action="/admin/academy/generate-teams/${meeting.getId()}" method="POST"
                                      class="needs-confirmation m-0"
                                      data-confirm-message="Автоматично розподілити всіх вільних учасників по командах відповідно до їх магазинів?"
                                      style="flex: 2;">
                                    <button type="submit"
                                            class="btn btn-success w-100 h-100 d-flex align-items-center justify-content-center gap-2 fw-bold">
                                        Автогенерація по магазинам
                                    </button>
                                </form>

                                <form action="/admin/academy/generate-single-team/${meeting.getId()}" method="POST"
                                      class="needs-confirmation m-0"
                                      data-confirm-message="Об'єднати всіх вільних учасників в одну велику команду?"
                                      style="flex: 1;">
                                    <button type="submit"
                                            class="btn btn-outline-success w-100 h-100 d-flex align-items-center justify-content-center gap-2 fw-bold"
                                            style="border-width: 2px;">
                                        Об'єднати всіх
                                    </button>
                                </form>

                                <button type="button"
                                        class="btn btn-outline-secondary fw-bold d-flex align-items-center justify-content-center gap-2"
                                        style="flex: 1; border-width: 2px;"
                                        data-bs-toggle="collapse"
                                        data-bs-target="#collapseManualForm-${meeting.getId()}">
                                    Створити вручну
                                </button>

                            </div>

                            <div class="collapse mb-5" id="collapseManualForm-${meeting.getId()}">
                                <div class="card card-body border-0 shadow-sm"
                                     style="background: #ffffff; border: 2px solid #bbf7d0 !important;">
                                    <form action="/admin/academy/manual-team/${meeting.getId()}" method="POST">
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <label class="form-label fw-bold small text-muted">Назва команди</label>
                                                <input type="text" class="form-control" name="name" required
                                                       style="border-radius: 10px;">
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label fw-bold small text-muted">Підтема</label>
                                                <input type="text" class="form-control" name="topic"
                                                       style="border-radius: 10px;">
                                            </div>
                                        </div>
                                        <div class="user-select-list mb-3" style="max-height: 200px; overflow-y: auto;">
                                            @if(meeting.getAvailableUsers() != null)
                                                @for(var user : meeting.getAvailableUsers())
                                                    <label class="d-block w-100">
                                                        <input type="checkbox" name="userIds" value="${user.getId()}"
                                                               class="d-none user-checkbox">
                                                        <div class="user-select-card shadow-sm py-2 px-3 mb-2 border rounded d-flex align-items-center justify-content-between"
                                                             style="cursor: pointer;">
                                                            <div class="fw-bold text-dark small">${user.getFullName()}</div>
                                                            <span class="text-muted extra-small">${user.getShopName()}</span>
                                                        </div>
                                                    </label>
                                                @endfor
                                            @endif
                                        </div>
                                        <div class="text-end border-top pt-3">
                                            <button type="submit" class="btn btn-success fw-bold px-4"
                                                    style="border-radius: 10px;">Зберегти команду
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between align-items-end mb-3 border-bottom pb-2">
                                <h6 class="fw-bold mb-0">Список команд (${meeting.getTeamsCount()})</h6>
                                <span class="badge ${meeting.getAvailableUsers() != null && !meeting.getAvailableUsers().isEmpty() ? "bg-warning text-dark" : "bg-success"} shadow-sm">
                                    ${meeting.getAvailableUsers() != null && !meeting.getAvailableUsers().isEmpty() ? "Вільних: " + meeting.getAvailableUsers().size() : "Всі розподілені"}
                                </span>
                            </div>

                            @if(meeting.getTeams() != null)
                                <div class="d-flex flex-column gap-3">
                                    @for(var team : meeting.getTeams())
                                        <div class="card border-0 shadow-sm"
                                             style="border: 1px solid #e2e8f0 !important;">
                                            <div class="card-body p-3 d-flex justify-content-between align-items-start">
                                                <div class="flex-grow-1">
                                                    <h6 class="fw-bold mb-1 text-dark">${team.getName()}</h6>
                                                    @if(team.getTopic() != null && !team.getTopic().isBlank())
                                                        <div class="text-muted small">${team.getTopic()}</div>
                                                    @endif
                                                    <div class="mt-2">
                                                        <button class="btn btn-sm btn-link text-decoration-none p-0 fw-bold"
                                                                style="color: #059669;" type="button"
                                                                data-bs-toggle="collapse"
                                                                data-bs-target="#members-${team.getId()}">
                                                            Учасників: ${team.getTeamMembers().size()} <span
                                                                    class="text-muted ms-1 fw-normal">(показати)</span>
                                                        </button>
                                                        <div class="collapse mt-2" id="members-${team.getId()}">
                                                            <div class="d-flex flex-wrap gap-2">
                                                                @for(var member : team.getTeamMembers())
                                                                    <div class="d-flex align-items-center gap-2 bg-light border rounded-pill px-3 py-1">
                                                                        <span class="text-dark fw-medium small">${member.getFullName()}</span>
                                                                    </div>
                                                                @endfor
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-column gap-2" style="min-width: 140px;">
                                                    <button type="button" class="btn-sage-outline w-100 text-nowrap"
                                                            data-bs-dismiss="modal" data-bs-toggle="modal"
                                                            data-bs-target="#editTeamModal-${team.getId()}">Редагувати
                                                    </button>
                                                    <form action="/admin/academy/delete-team/${team.getId()}"
                                                          method="POST" class="m-0 needs-confirmation"
                                                          data-confirm-message="Видалити команду ${team.getName()}?"
                                                          data-action-type="delete">
                                                        <input type="hidden" name="meetingId"
                                                               value="${meeting.getId()}">
                                                        <button type="submit"
                                                                class="btn-danger-outline w-100 text-nowrap">Видалити
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    @endfor
                                </div>
                            @endif
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="materialsModal-${meeting.getId()}" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
                        <div class="modal-header bg-light border-0">
                            <h5 class="modal-title fw-bold">Матеріали: ${meeting.getName()}</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body p-4 p-md-5">
                            <h6 class="fw-bold mb-3">Прикріплені матеріали (${meeting.getResourcesCount()})</h6>
                            @if(meeting.getResources() == null || meeting.getResources().isEmpty())
                                <div class="alert alert-light border text-center text-muted small py-3 rounded-4">
                                    Ще немає матеріалів.
                                </div>
                            @else
                                <ul class="list-group mb-4 shadow-sm" style="border-radius: 12px; overflow: hidden;">
                                    @for(var resource : meeting.getResources())
                                        <li class="list-group-item d-flex justify-content-between align-items-center bg-light border-0 border-bottom">
                                            <div class="text-truncate">
                                                <span class="badge bg-white text-muted border me-2 shadow-sm">${resource.getType().name()}</span>
                                                <a href="${resource.getUrl()}" target="_blank"
                                                   class="text-dark fw-bold text-decoration-none">${resource.getTitle()}</a>
                                            </div>
                                            <form action="/admin/academy/materials/delete/${resource.getId()}"
                                                  method="POST" class="m-0 needs-confirmation"
                                                  data-confirm-message="Видалити цей матеріал?"
                                                  data-action-type="delete">
                                                <input type="hidden" name="meetingId" value="${meeting.getId()}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger border-0 d-flex align-items-center justify-content-center" title="Видалити" style="width: 32px; height: 32px; border-radius: 8px;">
                                                    <span class="d-flex">@template.layout.icon(name = "trash", size = "16")</span>
                                                </button>
                                            </form>
                                        </li>
                                    @endfor
                                </ul>
                            @endif

                            <hr class="my-4">
                            <h6 class="fw-bold mb-3 text-success">Додати нові матеріали</h6>

                            <form action="/admin/academy/materials/add/${meeting.getId()}" method="POST"
                                  enctype="multipart/form-data" class="admin-material-form">

                                <div class="mb-4 p-3 bg-white border rounded-4 shadow-sm">
                                    <label class="form-label fw-bold small text-muted mb-3">Зовнішні посилання</label>

                                    <div class="links-container" id="linksContainer-${meeting.getId()}">
                                        <div class="link-item p-3 border rounded-3 mb-3 bg-light" style="position: relative;">
                                            <div class="mb-3 d-flex flex-wrap gap-2 chip-group">
                                                <div class="tea-chip active d-inline-flex align-items-center gap-2" data-val="VIDEO" style="cursor: pointer;">
                                                    <span class="d-flex">@template.layout.icon(name = "video", size = "18")</span> Відео
                                                </div>
                                                <div class="tea-chip d-inline-flex align-items-center gap-2" data-val="ARTICLE" style="cursor: pointer;">
                                                    <span class="d-flex">@template.layout.icon(name = "document", size = "18")</span> Стаття
                                                </div>
                                                <div class="tea-chip d-inline-flex align-items-center gap-2" data-val="LINK" style="cursor: pointer;">
                                                    <span class="d-flex">@template.layout.icon(name = "link", size = "18")</span> Посилання
                                                </div>
                                                <input type="hidden" name="links[0].type" class="type-input" value="VIDEO">
                                            </div>
                                            <input type="text" class="form-control form-control-sm mb-2" name="links[0].title" placeholder="Назва">
                                            <input type="url" class="form-control form-control-sm" name="links[0].url" placeholder="Посилання">
                                        </div>
                                    </div>

                                    <button type="button" class="btn btn-sm btn-outline-secondary w-100 fw-bold btn-add-link" data-meeting-id="${meeting.getId()}" style="border-style: dashed;">
                                        Додати ще посилання
                                    </button>
                                </div>

                                <div class="mb-4">
                                    <div class="p-4 text-center tea-dropzone rounded-4"
                                         onclick="this.querySelector('.file-input').click()"
                                         style="cursor: pointer; border: 2px dashed #cbd5e1; background-color: #f8fafc; transition: background-color 0.2s;">
                                        <div class="d-flex justify-content-center text-muted" style="margin-bottom: 10px;">
                                            @template.layout.icon(name = "cloude", size = "48")
                                        </div>
                                        <h6 class="fw-bold text-dark mb-1">Завантажити файли з комп'ютера</h6>
                                        <p class="small text-muted mb-0">Натисніть або перетягніть файли сюди</p>
                                        <input type="file" name="files" class="file-input" multiple
                                               style="display: none;" onchange="updateFileList(this)">
                                    </div>

                                    <div class="selected-files-list mt-3 d-none">
                                        <ul class="list-group list-group-sm file-ul shadow-sm" style="border-radius: 12px; overflow: hidden;"></ul>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-tea w-100 py-3 fw-bold admin-submit-btn shadow-sm" style="border-radius: 12px;">
                                    Зберегти всі матеріали
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="editMeetingModal-${meeting.getId()}" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
                        <div class="modal-header bg-light border-0">
                            <h5 class="modal-title fw-bold">Редагувати зібрання</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="/admin/academy/edit/${meeting.getId()}" method="POST">
                            <div class="modal-body p-4">
                                <div class="mb-3">
                                    <label class="form-label fw-bold text-muted small">Назва зібрання</label>
                                    <input type="text" class="form-control" name="name" value="${meeting.getName()}"
                                           required style="border-radius: 10px;">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold text-muted small">Опис та завдання</label>
                                    <input type="hidden" name="description" id="description-input-${meeting.getId()}">
                                    <div id="editor-${meeting.getId()}"
                                         style="height: 300px;">$unsafe{meeting.getDescription()}</div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label fw-bold text-muted small">Дата</label>
                                        <input type="date" class="form-control" name="date" value="${meeting.getDate()}"
                                               required style="border-radius: 10px;">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label fw-bold d-block text-muted small">Формат</label>
                                        <div class="btn-group w-100 format-toggle" role="group">
                                            <input type="radio" class="btn-check" name="isOnline" value="false"
                                                   id="create-offline" checked>
                                            <label class="btn btn-outline-secondary d-inline-flex align-items-center justify-content-center gap-2" for="create-offline">
                                                <span class="d-flex">@template.layout.icon(name = "shop", size = "18")</span> Офлайн
                                            </label>

                                            <input type="radio" class="btn-check" name="isOnline" value="true"
                                                   id="create-online">
                                            <label class="btn btn-outline-secondary d-inline-flex align-items-center justify-content-center gap-2" for="create-online">
                                                <span class="d-flex">@template.layout.icon(name = "online", size = "18")</span> Онлайн
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer bg-light border-0">
                                <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">
                                    Скасувати
                                </button>
                                <button type="submit" class="btn-tea px-4">Зберегти зміни</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="deleteMeetingModal-${meeting.getId()}" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
                        <div class="modal-header bg-danger text-white border-0">
                            <h5 class="modal-title fw-bold">Підтвердження видалення</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body text-center py-5">
                            <h4 class="fw-bold mb-3">Ви впевнені?</h4>
                            <p class="text-muted">Ви видаляєте зібрання <br><strong>"${meeting.getName()}"</strong></p>
                            <div class="p-3 bg-light rounded-3 text-danger fw-bold small mt-3">Цю дію неможливо
                                скасувати!
                            </div>
                        </div>
                        <div class="modal-footer border-0 p-4 pt-0 d-flex gap-2">
                            <button type="button" class="btn btn-outline-secondary flex-grow-1 fw-bold py-2"
                                    data-bs-dismiss="modal" style="border-radius: 12px;">Скасувати
                            </button>
                            <form action="/admin/academy/delete/${meeting.getId()}" method="POST"
                                  class="flex-grow-1 m-0">
                                <button type="submit" class="btn btn-danger w-100 fw-bold py-2"
                                        style="border-radius: 12px;">Так, видалити
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            @if(meeting.getTeams() != null)
                @for(var team : meeting.getTeams())
                    <div class="modal fade" id="editTeamModal-${team.getId()}" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-md">
                            <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
                                <div class="modal-header bg-light border-0">
                                    <h5 class="modal-title fw-bold">Редагувати команду: ${team.getName()}</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <form action="/admin/academy/edit-team/${team.getId()}" method="POST">
                                    <input type="hidden" name="meetingId" value="${meeting.getId()}">
                                    <div class="modal-body p-4">
                                        <div class="mb-3">
                                            <label class="form-label fw-bold small text-muted">Назва команди</label>
                                            <input type="text" class="form-control" name="name"
                                                   value="${team.getName()}" required style="border-radius: 10px;">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label fw-bold small text-muted">Підтема</label>
                                            <input type="text" class="form-control" name="topic"
                                                   value="${team.getTopic()}" style="border-radius: 10px;">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label fw-bold small text-muted d-block mb-2">Учасники
                                                команди</label>
                                            <div class="user-select-list" style="max-height: 240px; overflow-y: auto;">
                                                @if(team.getTeamMembers() != null)
                                                    @for(var member : team.getTeamMembers())
                                                        <label class="d-block w-100">
                                                            <input type="checkbox" name="userIds"
                                                                   value="${member.getId()}" checked
                                                                   class="d-none user-checkbox">
                                                            <div class="user-select-card shadow-sm py-2 px-3 mb-2 border rounded d-flex align-items-center justify-content-between">
                                                                <div class="fw-bold text-dark small">${member.getFullName()}</div>
                                                            </div>
                                                        </label>
                                                    @endfor
                                                @endif
                                                @if(meeting.getAvailableUsers() != null)
                                                    @for(var user : meeting.getAvailableUsers())
                                                        <label class="d-block w-100">
                                                            <input type="checkbox" name="userIds"
                                                                   value="${user.getId()}" class="d-none user-checkbox">
                                                            <div class="user-select-card shadow-sm py-2 px-3 mb-2 border rounded d-flex align-items-center justify-content-between">
                                                                <div class="fw-bold text-dark small">${user.getFullName()}</div>
                                                            </div>
                                                        </label>
                                                    @endfor
                                                @endif
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer bg-light border-0">
                                        <button type="button" class="btn btn-outline-secondary px-4"
                                                data-bs-dismiss="modal" data-bs-toggle="modal"
                                                data-bs-target="#manualTeamModal-${meeting.getId()}">Скасувати
                                        </button>
                                        <button type="submit" class="btn-tea px-4">Зберегти зміни</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                @endfor
            @endif

        @endfor

        @for(var meeting : archiveMeetings)
            <div class="modal fade" id="materialsModal-archive-${meeting.getId()}" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
                        <div class="modal-header bg-light border-0">
                            <h5 class="modal-title fw-bold d-flex align-items-center gap-2">
                                <span class="d-flex text-tea">@template.layout.icon(name = "notebook", size = "24")</span>
                                Матеріали: ${meeting.getName()}
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body p-4 p-md-5">
                            <h6 class="fw-bold mb-3">Прикріплені матеріали</h6>
                            @if(meeting.getResources() == null || meeting.getResources().isEmpty())
                                <div class="alert alert-light border text-center text-muted small py-3">Ще немає
                                    матеріалів.
                                </div>
                            @else
                                <ul class="list-group mb-4 shadow-sm">
                                    @for(var resource : meeting.getResources())
                                        <li class="list-group-item d-flex justify-content-between align-items-center bg-light">
                                            <div class="text-truncate">
                                                <span class="badge bg-white text-muted border me-2">${resource.getType().name()}</span>
                                                <a href="${resource.getUrl()}" target="_blank"
                                                   class="text-dark fw-bold text-decoration-none">${resource.getTitle()}</a>
                                            </div>
                                        </li>
                                    @endfor
                                </ul>
                            @endif
                        </div>
                    </div>
                </div>
            </div>
        @endfor

        <div class="modal fade" id="createMeetingModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
                    <div class="modal-header bg-light border-0">
                        <h5 class="modal-title fw-bold">Створення нового зібрання</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="/admin/academy/create" method="POST">
                        <div class="modal-body p-4">
                            <div class="mb-3">
                                <label class="form-label fw-bold text-muted small">Тема зібрання</label>
                                <input type="text" class="form-control" name="name" placeholder="Напр: Чайні традиції"
                                       required style="border-radius: 10px;">
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold text-muted small">Опис</label>
                                <input type="hidden" name="description" id="create-description-input">
                                <div id="create-editor" style="height: 300px;"></div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold text-muted small">Дата</label>
                                    <input type="date" class="form-control" name="date"
                                           min="${java.time.LocalDate.now().toString()}" required
                                           style="border-radius: 10px;">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold d-block text-muted small">Формат</label>
                                    <div class="btn-group w-100 format-toggle" role="group">
                                        <input type="radio" class="btn-check" name="isOnline" value="false"
                                               id="create-offline" checked>
                                        <label class="btn btn-outline-secondary d-inline-flex align-items-center justify-content-center gap-2" for="create-offline">
                                            <span class="d-flex">@template.layout.icon(name = "shop", size = "18")</span> Офлайн
                                        </label>

                                        <input type="radio" class="btn-check" name="isOnline" value="true"
                                               id="create-online">
                                        <label class="btn btn-outline-secondary d-inline-flex align-items-center justify-content-center gap-2" for="create-online">
                                            <span class="d-flex">@template.layout.icon(name = "online", size = "18")</span> Онлайн
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer bg-light border-0">
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Скасувати
                            </button>
                            <button type="submit" class="btn-tea px-4">Створити</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="customConfirmModal" tabindex="-1" aria-hidden="true" style="z-index: 1070;">
            <div class="modal-dialog modal-dialog-centered modal-sm">
                <div class="modal-content border-0 shadow-lg" style="border-radius: 16px;">
                    <div class="modal-body text-center p-4">
                        <div id="customConfirmIcon" class="d-flex justify-content-center text-warning"
                             style="margin-bottom: 1rem;">
                            @template.layout.icon(name = "warning", size = "48")
                        </div>
                        <h6 class="fw-bold mb-4" id="customConfirmMessage">Ви впевнені?</h6>
                        <div class="d-flex gap-2">
                            <button type="button" class="btn btn-outline-secondary flex-grow-1" data-bs-dismiss="modal">
                                Ні
                            </button>
                            <button type="button" class="btn flex-grow-1 fw-bold" id="customConfirmBtn">Так</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function updateFileList(input) {
                const listContainer = input.closest('.mb-4').querySelector('.selected-files-list');
                const ul = listContainer.querySelector('.file-ul');
                ul.innerHTML = '';
                if (input.files.length > 0) {
                    listContainer.classList.remove('d-none');
                    Array.from(input.files).forEach(file => {
                        const sizeMB = (file.size / (1024 * 1024)).toFixed(2);
                        ul.innerHTML += '<li class="list-group-item d-flex justify-content-between align-items-center bg-light small py-2">' +
                            '<span>📎 ' + file.name + '</span>' +
                            '<span class="badge bg-white text-muted border">' + sizeMB + ' MB</span></li>';
                    });
                } else {
                    listContainer.classList.add('d-none');
                }
            }

            document.addEventListener("DOMContentLoaded", function () {
                const urlParams = new URLSearchParams(window.location.search);

                if (urlParams.get('error') === 'pending_reviews') {
                    alert('Неможливо завершити зібрання!\n\nУ вас залишились команди зі статусом "На перевірці". Будь ласка, перевірте їх роботи перед закриттям.');
                    window.history.replaceState(null, '', window.location.pathname);
                }

                document.addEventListener('click', function (e) {
                    if (e.target.classList.contains('tea-chip')) {
                        const group = e.target.closest('.chip-group');
                        const inputHidden = group.querySelector('input[type="hidden"]');
                        const urlInput = group.closest('.link-item').querySelector('input[name="urls"]');

                        group.querySelectorAll('.tea-chip').forEach(c => c.classList.remove('active'));
                        e.target.classList.add('active');

                        const val = e.target.getAttribute('data-val');
                        inputHidden.value = val;

                        if (val === 'VIDEO') urlInput.placeholder = 'https://youtube.com/...';
                        else if (val === 'ARTICLE') urlInput.placeholder = 'https://telegra.ph/...';
                        else urlInput.placeholder = 'https://...';
                    }
                });

                document.querySelectorAll('.btn-add-link').forEach(btn => {
                    btn.addEventListener('click', function () {
                        const container = this.previousElementSibling;
                        const firstItem = container.querySelector('.link-item');
                        const clone = firstItem.cloneNode(true);
                        clone.querySelectorAll('input[type="text"], input[type="url"]').forEach(i => i.value = '');

                        const delBtn = document.createElement('button');
                        delBtn.className = 'btn btn-sm text-danger position-absolute top-0 end-0 m-1';
                        delBtn.innerHTML = '✕';
                        delBtn.onclick = function () {
                            clone.remove();
                        };
                        clone.appendChild(delBtn);

                        container.appendChild(clone);
                    });
                });

                function setupQuill(modalSelector, editorSelector, inputSelector) {
                    const modal = document.querySelector(modalSelector);
                    if (!modal) return;
                    modal.addEventListener('shown.bs.modal', function () {
                        if (this.dataset.quillInitialized) return;
                        const editorEl = document.querySelector(editorSelector);
                        const existingHtml = editorEl ? editorEl.innerHTML.trim() : '';
                        const quill = new Quill(editorSelector, {
                            theme: 'snow',
                            modules: {
                                toolbar: [
                                    [{'header': [2, 3, false]}],
                                    ['bold', 'italic', 'underline'],
                                    [{'list': 'ordered'}, {'list': 'bullet'}],
                                    ['blockquote', 'link'],
                                    ['clean']
                                ]
                            }
                        });
                        if (existingHtml) quill.root.innerHTML = existingHtml;
                        const form = modal.querySelector('form');
                        form.addEventListener('submit', () => {
                            const html = quill.root.innerHTML;
                            document.querySelector(inputSelector).value = (html === '<p><br></p>') ? '' : html;
                        });
                        this.dataset.quillInitialized = 'true';
                    });
                }

                document.querySelectorAll('[id^="editMeetingModal-"]').forEach(m => {
                    const id = m.id.replace('editMeetingModal-', '');
                    setupQuill('#' + m.id, '#editor-' + id, '#description-input-' + id);
                });
                setupQuill('#createMeetingModal', '#create-editor', '#create-description-input');

                let formToSubmit = null;
                const confirmModalEl = document.getElementById('customConfirmModal');
                if (confirmModalEl) {
                    const confirmModal = new bootstrap.Modal(confirmModalEl);
                    const confirmBtn = document.getElementById('customConfirmBtn');

                    document.addEventListener('submit', function (e) {
                        if (e.target.classList.contains('needs-confirmation')) {
                            e.preventDefault();
                            formToSubmit = e.target;
                            confirmModal.show();
                        }
                    });

                    confirmBtn.addEventListener('click', function () {
                        if (formToSubmit) formToSubmit.submit();
                    });
                }

                ['openModal', 'editMeeting', 'openMaterialsModal'].forEach(param => {
                    const id = urlParams.get(param);
                    if (id) {
                        let target = param === 'openMaterialsModal' ? '#materialsModal-' + id : (param === 'editMeeting' ? '#editMeetingModal-' + id : '#manualTeamModal-' + id);
                        const el = document.querySelector(target);
                        if (el) new bootstrap.Modal(el).show();
                    }
                });
            });
        </script>
    </div>
`)