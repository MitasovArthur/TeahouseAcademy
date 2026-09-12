@import com.teahouse.teahouse_academy.model.dto.knowledge.KnowledgeBaseMeetingDto
@import com.teahouse.teahouse_academy.model.entity.TagEntity
@import java.util.List

@param List<KnowledgeBaseMeetingDto> meetings
@param List<TagEntity> popularTags
@param String currentQuery
@param java.util.List<String> currentTags
@param Boolean isAdmin = false

@template.layout.main(isAdmin = isAdmin, content = @`
    <link href="/assets/css/knowledge-base.css" rel="stylesheet"/>

    <div class="container my-5" style="max-width: 1000px;">

        <div class="mb-4">
            <a href="/academy" class="text-muted text-decoration-none fw-bold" style="font-size: 0.95rem;">← Повернутися до поточних завдань</a>
        </div>

        <div class="kb-header">
            <h2 class="fw-bold mb-2 text-dark">База знань Teahouse</h2>
            <p class="text-muted mb-4" style="font-size: 1.05rem;">Шукайте матеріали за назвою або комбінуйте теги.</p>

            <form action="/academy/knowledge-base" method="GET" id="searchForm">
                <div class="search-wrapper">
                    <span class="ms-3 d-none d-md-flex align-items-center text-muted" style="opacity: 0.5;">
                        @template.layout.icon(name = "search", size = "20")
                    </span>

                    <div id="hidden-tags-container">
                        @if(currentTags != null)
                            @for(String t : currentTags)
                                <input type="hidden" name="tags" value="${t}" class="selected-tag-input">
                            @endfor
                        @endif
                    </div>

                    @if(currentTags != null && !currentTags.isEmpty())
                        <div class="tags-scroll ms-md-2" id="visual-tags">
                            @for(String t : currentTags)
                                <span class="tag-badge">
                                    #${t} <span class="tag-remove" onclick="removeTag(this, '${t}')">✕</span>
                                </span>
                            @endfor
                        </div>
                    @endif

                    <input type="text" class="search-input" name="q" id="searchInput" value="${currentQuery != null ? currentQuery : ""}" placeholder="Назва зібрання або новий тег..." autocomplete="off">

                    <div class="search-actions">
                        @if((currentQuery != null && !currentQuery.isBlank()) || (currentTags != null && !currentTags.isEmpty()))
                            <a href="/academy/knowledge-base" class="btn-clear text-nowrap">Очистити</a>
                        @endif
                        <button type="submit" class="btn-search">Шукати</button>
                    </div>

                    <div class="suggestions-box" id="suggestionsBox">
                        @if(popularTags != null)
                            @for(var tag : popularTags)
                                <div class="suggestion-item d-flex align-items-center gap-2" data-tag="${tag.getName()}" onclick="addTagFromSuggestion('${tag.getName()}')">
                                    <span class="d-flex text-muted">@template.layout.icon(name = "search", size = "16")</span>
                                    <span class="fw-bold">#${tag.getName()}</span>
                                </div>
                            @endfor
                        @endif
                    </div>
                </div>
            </form>
        </div>

        <div class="mb-4">
            <h6 class="fw-bold text-muted text-uppercase mb-3" style="font-size: 0.75rem; letter-spacing: 1px;">Популярні напрямки:</h6>
            <div class="directions-scroll">
                <a href="/academy/knowledge-base" class="dir-tag ${currentTags == null || currentTags.isEmpty() ? "active" : ""}">Всі матеріали</a>

                @if(popularTags != null)
                    @for(var tag : popularTags)
                        <button type="button" class="dir-tag ${currentTags != null && currentTags.contains(tag.getName()) ? "active" : ""}" onclick="toggleCloudTag('${tag.getName()}')">
                            #${tag.getName()}
                        </button>
                    @endfor
                @endif
            </div>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-3 mt-5">
            <h5 class="fw-bold text-dark m-0">Знайдені навчальні модулі</h5>
        </div>

        <div class="row g-4">
            @if(meetings == null || meetings.isEmpty())
                <div class="col-12 text-center py-5">
                    <div class="d-flex justify-content-center mb-3 text-success" style="opacity: 0.7;">
                        @template.layout.icon(name = "tea", size = "64")
                    </div>
                    <h5 class="fw-bold text-dark">Нічого не знайдено</h5>
                    <p class="text-muted">Спробуйте змінити пошуковий запит або обрати інші теги.</p>
                </div>
            @else
                @for(var meeting : meetings)
                    <div class="col-md-6">
                        <div class="module-card p-4">
                            <div class="d-flex justify-content-between align-items-start">
                                <div class="module-icon">
                                    @template.layout.icon(name = "tea", size = "24")
                                </div>
                                <span class="badge bg-light text-muted border">${meeting.getDateMonthYear()}</span>
                            </div>

                            <h5 class="fw-bold text-dark mb-2">${meeting.getName()}</h5>

                            <div class="d-flex gap-3 text-muted small mb-4">
                                <span class="d-inline-flex align-items-center gap-1">
                                    @if(meeting.getFormat().equals("Онлайн"))
                                        <span class="d-flex text-success">@template.layout.icon(name = "online", size = "16")</span>
                                    @else
                                        <span class="d-flex text-secondary">@template.layout.icon(name = "shop", size = "16")</span>
                                    @endif
                                    ${meeting.getFormat()}
                                </span>
                                <span class="d-inline-flex align-items-center gap-1">
                                    <span class="d-flex text-muted">@template.layout.icon(name = "personIcon", size = "16")</span>
                                    Команд: ${meeting.getTeamCount()}
                                </span>
                            </div>

                            <div class="mt-auto pt-3 border-top d-flex justify-content-between align-items-center">
                                <div class="d-flex flex-wrap gap-1" style="max-width: 65%;">
                                    @if(meeting.getTags() != null)
                                        @for(var tag : meeting.getTags())
                                            <span class="text-muted fw-bold" style="font-size: 0.75rem;">#${tag}</span>
                                        @endfor
                                    @endif
                                </div>
                                <a href="/academy/knowledge-base/${meeting.getId()}" class="btn btn-sm btn-outline-success fw-bold text-nowrap" style="border-radius: 10px;">
                                    Відкрити →
                                </a>
                            </div>
                        </div>
                    </div>
                @endfor
            @endif
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const savedScroll = sessionStorage.getItem("kb_scroll");
            if (savedScroll) {
                window.scrollTo(0, parseInt(savedScroll));
                sessionStorage.removeItem("kb_scroll");
            }

            const searchInput = document.getElementById('searchInput');
            const suggestionsBox = document.getElementById('suggestionsBox');
            const form = document.getElementById('searchForm');

            form.addEventListener('submit', function() {
                sessionStorage.setItem("kb_scroll", window.scrollY);
            });

            searchInput.addEventListener('input', function() {
                const val = this.value.toLowerCase().trim();
                let hasVisible = false;

                document.querySelectorAll('.suggestion-item').forEach(item => {
                    const tag = item.getAttribute('data-tag').toLowerCase();
                    if (val.length > 0 && tag.includes(val)) {
                        item.style.display = 'block';
                        hasVisible = true;
                    } else {
                        item.style.display = 'none';
                    }
                });

                suggestionsBox.style.display = hasVisible ? 'block' : 'none';
            });

            document.addEventListener('click', function(e) {
                if (!searchInput.contains(e.target) && !suggestionsBox.contains(e.target)) {
                    suggestionsBox.style.display = 'none';
                }
            });
        });

        function submitWithScroll() {
            sessionStorage.setItem("kb_scroll", window.scrollY);
            document.getElementById('searchForm').submit();
        }

        function addTagFromSuggestion(tagName) {
            const existing = document.querySelector('.selected-tag-input[value="' + tagName + '"]');
            if (!existing) {
                document.getElementById('hidden-tags-container').insertAdjacentHTML('beforeend', '<input type="hidden" name="tags" value="' + tagName + '" class="selected-tag-input">');
            }
            document.getElementById('searchInput').value = '';
            submitWithScroll();
        }

        function removeTag(element, tagName) {
            const input = document.querySelector('.selected-tag-input[value="' + tagName + '"]');
            if (input) input.remove();
            submitWithScroll();
        }

        function toggleCloudTag(tagName) {
            const existing = document.querySelector('.selected-tag-input[value="' + tagName + '"]');
            if (existing) {
                existing.remove();
            } else {
                document.getElementById('hidden-tags-container').insertAdjacentHTML('beforeend', '<input type="hidden" name="tags" value="' + tagName + '" class="selected-tag-input">');
            }
            submitWithScroll();
        }
    </script>
`)