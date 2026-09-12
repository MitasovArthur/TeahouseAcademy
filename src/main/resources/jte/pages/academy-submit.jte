@import com.teahouse.teahouse_academy.model.entity.MeetingEntity
@import com.teahouse.teahouse_academy.model.entity.TeamEntity

@param MeetingEntity meeting
@param TeamEntity team
@param Boolean isAdmin

@template.layout.main(isAdmin = isAdmin, content = @`
    <link href="/assets/css/admin.css" rel="stylesheet"/>

    <div class="container my-5">
        <div class="mb-4">
            <a href="/academy" class="text-decoration-none text-muted mb-2 d-inline-block">← Повернутися до Академії</a>
            <h3 class="fw-bold mb-1">Здача завдання: ${meeting.getName()}</h3>
            <p class="text-muted">Команда: <span class="fw-bold" style="color: #064e3b;">${team.getName()}</span></p>
        </div>

        <div class="card border-0 shadow-sm rounded-4 p-4 mb-4" style="max-width: 800px;">

            @if(team.getSubmissions() != null && !team.getSubmissions().isEmpty())
                <div class="mb-4 p-4 rounded-4" style="background-color: #f8fafc; border: 1px solid #e2e8f0;">
                    <h6 class="fw-bold text-uppercase d-flex align-items-center gap-2 mb-3" style="font-size: 0.8rem; color: #64748b; letter-spacing: 1px;">
                        <span class="d-flex">@template.layout.icon(name = "archive", size = "16")</span>
                        Вже завантажені матеріали:
                    </h6>
                    <div class="d-flex flex-column gap-2">
                        @for(var sub : team.getSubmissions())
                            <div class="d-flex align-items-center justify-content-between p-3 bg-white rounded-3 border shadow-sm">

                                <a href="${sub.getFileLink()}" target="_blank" class="d-flex align-items-center gap-3 text-decoration-none fw-bold text-truncate me-3" style="color: #0f5132; font-size: 0.95rem; max-width: 75%;">
                                    <span style="font-size: 1.2rem; flex-shrink: 0;" class="d-flex align-items-center">
                                        @if(sub.getType().name().equals("VIDEO"))
                                            <span class="d-flex text-danger">@template.layout.icon(name = "video", size = "20")</span>
                                        @elseif(sub.getType().name().equals("DOCUMENT") || sub.getType().name().equals("BOOK"))
                                            <span class="d-flex text-primary">@template.layout.icon(name = "document", size = "20")</span>
                                        @elseif(sub.getType().name().equals("PRESENTATION"))
                                            <span class="d-flex text-warning">@template.layout.icon(name = "presentation", size = "20")</span>
                                        @elseif(sub.getType().name().equals("IMAGE"))
                                            <span class="d-flex text-success">@template.layout.icon(name = "image", size = "20")</span>
                                        @elseif(sub.getType().name().equals("ARCHIVE"))
                                            <span class="d-flex text-secondary">@template.layout.icon(name = "archive", size = "20")</span>
                                        @else
                                            <span class="d-flex text-secondary">@template.layout.icon(name = "link", size = "20")</span>
                                        @endif
                                    </span>
                                    <span class="text-truncate">
                                        ${sub.getFileName() != null && !sub.getFileName().isBlank() ? sub.getFileName() : "Зовнішнє посилання"}
                                    </span>
                                </a>

                                <form action="/academy/submit/delete/${sub.getId()}" method="POST" class="m-0">
                                    <input type="hidden" name="meetingId" value="${meeting.getId()}">
                                    <button type="submit" class="btn btn-sm btn-light text-danger fw-bold border-0 px-3"
                                            onclick="return confirm('Ви впевнені, що хочете видалити цей матеріал?');"
                                            style="border-radius: 8px;">
                                        Видалити
                                    </button>
                                </form>
                            </div>
                        @endfor
                    </div>
                </div>
            @endif

            <form action="/academy/submit/${meeting.getId()}" method="POST" enctype="multipart/form-data" id="submitForm">
                <input type="hidden" name="teamId" value="${team.getId()}">

                <div class="form-check form-switch mb-4 p-3 rounded-3" style="background-color: #f8fafc; border: 1px solid #cbd5e1;">
                    <input class="form-check-input ms-0 me-3" type="checkbox" id="noFilesToggle" style="width: 2.5em; height: 1.25em; cursor: pointer;">
                    <label class="form-check-label fw-bold text-dark mt-1" for="noFilesToggle" style="cursor: pointer; font-size: 1.05rem;">
                        <span class="d-inline-flex align-items-center gap-2">
                            <span class="d-flex text-success">@template.layout.icon(name = "confirm", size = "18")</span>
                            Це завдання не потребує файлів (готові до усного обговорення)
                        </span>
                    </label>
                </div>

                <div id="uploadSection" style="transition: all 0.3s ease;">
                    <div class="mb-4">
                        <label class="fw-bold small text-muted mb-2">Додати посилання</label>
                        <div id="urlContainer">
                            <div class="link-item p-3 border rounded-3 mb-3 bg-light" style="position: relative;">
                                <div class="mb-3 d-flex flex-wrap gap-2 chip-group">
                                    <div class="tea-chip active d-inline-flex align-items-center gap-2" data-val="VIDEO">
                                        <span class="d-flex">@template.layout.icon(name = "video", size = "16")</span> Відео
                                    </div>
                                    <div class="tea-chip d-inline-flex align-items-center gap-2" data-val="DOCUMENT">
                                        <span class="d-flex">@template.layout.icon(name = "document", size = "16")</span> Документ
                                    </div>
                                    <div class="tea-chip d-inline-flex align-items-center gap-2" data-val="LINK">
                                        <span class="d-flex">@template.layout.icon(name = "link", size = "16")</span> Інше посилання
                                    </div>
                                    <input type="hidden" name="links[0].type" value="VIDEO">
                                </div>
                                <input type="text" class="form-control form-control-sm mb-2" name="links[0].title" placeholder="Назва">
                                <input type="url" class="form-control form-control-sm" name="links[0].url" placeholder="Посилання">
                            </div>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-secondary w-100 fw-bold" id="addUrlBtn" style="border-style: dashed;">
                            + Додати ще посилання
                        </button>
                    </div>

                    <div class="mb-4">
                        <label class="fw-bold small text-muted mb-2">Завантажити файли</label>
                        <div class="p-4 text-center tea-dropzone" onclick="this.querySelector('.file-input').click()">
                            <div class="d-flex justify-content-center text-muted" style="margin-bottom: 10px;">
                                @template.layout.icon(name = "cloude", size = "48")
                            </div>
                            <h6 class="fw-bold text-dark mb-1">Завантажити файли з комп'ютера</h6>
                            <p class="small text-muted mb-0">Натисніть або перетягніть файли сюди</p>
                            <input type="file" name="files" class="file-input" multiple style="display: none;" onchange="updateFileList(this)">
                        </div>
                        <div class="selected-files-list mt-3 d-none">
                            <ul class="list-group list-group-sm file-ul"></ul>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-2 mt-4 pt-4 border-top">
                    <a href="/academy" class="btn btn-light border fw-bold px-4 py-2" style="border-radius: 12px;">Скасувати</a>
                    <button type="submit" class="btn btn-success fw-bold px-4 py-2 d-inline-flex align-items-center gap-2" id="submitBtn"
                            style="border-radius: 12px; background-color: #064e3b; border-color: #064e3b;">
                        <span class="d-flex">@template.layout.icon(name = "cloude", size = "18")</span>
                        Відправити матеріали
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div id="btn-confirm-template" class="d-none">
        <span class="d-inline-flex align-items-center justify-content-center gap-2">
            <span class="d-flex">@template.layout.icon(name = "confirm", size = "18")</span>
            Підтвердити готовність
        </span>
    </div>

    <div id="btn-upload-template" class="d-none">
        <span class="d-inline-flex align-items-center justify-content-center gap-2">
            <span class="d-flex">@template.layout.icon(name = "cloude", size = "18")</span>
            Відправити матеріали
        </span>
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
                        '<span> ' + file.name + '</span>' +
                        '<span class="badge bg-white text-muted border">' + sizeMB + ' MB</span></li>';
                });
            } else {
                listContainer.classList.add('d-none');
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            const toggle = document.getElementById("noFilesToggle");
            const uploadSection = document.getElementById("uploadSection");
            const submitBtn = document.getElementById("submitBtn");

            toggle.addEventListener("change", function () {
                if (this.checked) {
                    uploadSection.style.display = "none";
                    submitBtn.innerHTML = document.getElementById("btn-confirm-template").innerHTML;
                } else {
                    uploadSection.style.display = "block";
                    submitBtn.innerHTML = document.getElementById("btn-upload-template").innerHTML;
                }
            });

            let linkIndex = 1;
            document.getElementById("addUrlBtn").addEventListener("click", function () {
                const container = document.getElementById("urlContainer");
                const firstItem = container.querySelector('.link-item');
                const clone = firstItem.cloneNode(true);

                clone.querySelector('input[type="hidden"]').name = 'links[' + linkIndex + '].type';

                const textInput = clone.querySelector('input[type="text"]');
                textInput.name = 'links[' + linkIndex + '].title';
                textInput.value = '';

                const urlInput = clone.querySelector('input[type="url"]');
                urlInput.name = 'links[' + linkIndex + '].url';
                urlInput.value = '';

                const delBtn = document.createElement('button');
                delBtn.className = 'btn btn-sm text-danger position-absolute top-0 end-0 m-1 border-0';
                delBtn.innerHTML = '✕';
                delBtn.onclick = function (e) {
                    e.preventDefault();
                    clone.remove();
                };
                clone.appendChild(delBtn);

                container.appendChild(clone);
                linkIndex++;
            });

            document.addEventListener('click', function (e) {
                if (e.target.classList.contains('tea-chip')) {
                    const group = e.target.closest('.chip-group');
                    const inputHidden = group.querySelector('input[type="hidden"]');
                    const urlInput = group.closest('.link-item').querySelector('input[type="url"]');

                    group.querySelectorAll('.tea-chip').forEach(c => c.classList.remove('active'));
                    e.target.classList.add('active');

                    const val = e.target.getAttribute('data-val');
                    inputHidden.value = val;

                    if (val === 'VIDEO') urlInput.placeholder = 'https://youtube.com/...';
                    else if (val === 'DOCUMENT') urlInput.placeholder = 'https://docs.google.com/...';
                    else urlInput.placeholder = 'https://...';
                }
            });
        });
    </script>
`)