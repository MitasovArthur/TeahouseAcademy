@param String activeTab
@param long pendingCount = 0
<div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
    <h2 class="fw-bold mb-0 tea-green" style="color: var(--tea-dark);">Панель Адміністратора</h2>
</div>

<ul class="nav nav-tabs border-bottom-0 mb-4" id="adminTabs">
    <li class="nav-item">
        <a class="nav-link fw-bold border-0 ${"academy".equals(activeTab) ? "active shadow-sm bg-white" : "text-muted bg-transparent"}"
           style="${"academy".equals(activeTab) ? "color: var(--tea-dark); border-radius: 12px 12px 0 0;" : ""}"
           href="/admin/academy">Академія</a>
    </li>
    <li class="nav-item">
        <a class="nav-link fw-bold border-0 ${"users".equals(activeTab) ? "active shadow-sm bg-white" : "text-muted bg-transparent"}"
           style="${"users".equals(activeTab) ? "color: var(--tea-dark); border-radius: 12px 12px 0 0;" : ""}"
           href="/admin/academy/users">Персонал</a>
    </li>
    <li class="nav-item">
        <a class="nav-link fw-bold border-0 ${"locations".equals(activeTab) ? "active shadow-sm bg-white" : "text-muted bg-transparent"}"
           style="${"locations".equals(activeTab) ? "color: var(--tea-dark); border-radius: 12px 12px 0 0;" : ""}"
           href="/admin/academy/shops">Магазини</a>
    </li>
    <li class="nav-item">
        <a class="nav-link fw-bold border-0 ${"verification".equals(activeTab) ? "active shadow-sm bg-white" : "text-muted bg-transparent"}"
           style="${"verification".equals(activeTab) ? "color: var(--tea-dark); border-radius: 12px 12px 0 0;" : ""}"
           href="/admin/academy/verification">
            На перевірку
            @if(pendingCount > 0)
                <span class="badge bg-danger ms-1">${pendingCount}</span>
            @endif
        </a>
    </li>
</ul>