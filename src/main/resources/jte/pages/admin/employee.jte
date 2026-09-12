@import com.teahouse.teahouse_academy.model.dto.shop.ShopDto
@import com.teahouse.teahouse_academy.model.dto.user.AdminUserResponse
@import com.teahouse.teahouse_academy.model.enumProject.RoleUser

@param java.util.List<AdminUserResponse> users
@param java.util.List<ShopDto> shops

@template.layout.main(content = @`
    <link href="/assets/css/admin.css" rel="stylesheet"/>

    <div class="container my-5">
        @template.pages.admin.components.admin-tabs(activeTab = "users")

        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 p-3 bg-white shadow-sm rounded-4 gap-3">
            <h5 class="fw-bold text-dark m-0 px-2">Управління співробітниками</h5>

            <div class="search-minimalist d-flex align-items-center" style="width: 100%; max-width: 350px;">
                <span class="text-muted me-2 d-flex">
                    @template.layout.icon(name = "search", size = "18")
                </span>
                <input type="text" id="userSearchInput" placeholder="Ім'я, email, посада..." autocomplete="off"
                       style="border: none; outline: none; width: 100%; background: transparent;">
            </div>
        </div>

        <div class="row row-cols-1 row-cols-md-2 row-cols-xl-3 g-4" id="usersGrid">
            @for(var user : users)
                <div class="col user-col">
                    <div class="card h-100 border-0 shadow-sm user-card bg-white">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-center mb-3">
                                <div class="avatar-circle me-3 shadow-sm"
                                     style="background: ${user.getRole().equals("ADMIN") ? "#1e293b" : "var(--tea-mid)"};">
                                    ${user.getFullName().substring(0, 1).toUpperCase()}
                                </div>
                                <div class="text-truncate">
                                    <h5 class="fw-bold mb-0 text-dark text-truncate">${user.getFullName()}</h5>
                                    <span class="text-muted small text-truncate d-block">${user.getEmail()}</span>
                                </div>
                            </div>

                            <div class="d-flex flex-column gap-2 mt-3">
                                <div class="d-flex align-items-center justify-content-between">
                                    <span class="text-muted small fw-bold">Посада:</span>
                                    <span class="badge rounded-pill px-3 py-2
                                        ${user.getRole().equals("GUEST") ? "role-badge-guest" :
                                          user.getRole().equals("LEVEL_ONE") ? "role-badge-lvl1" :
                                          user.getRole().equals("LEVEL_TWO") ? "role-badge-lvl2" :
                                          user.getRole().equals("LEVEL_THREE") ? "role-badge-lvl3" : "bg-dark"}">
                                        ${RoleUser.valueOf(user.getRole()).getDisplayRole()}
                                    </span>
                                </div>
                                <div class="d-flex align-items-center justify-content-between">
                                    <span class="text-muted small fw-bold">Локація:</span>
                                    <span class="badge bg-light text-dark border px-3 py-2 rounded-pill text-truncate"
                                          style="max-width: 150px;">
                                        ${user.getShopName() != null ? user.getShopName() : "Не призначено"}
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-top p-3">
                            @if(!user.getRole().equals("ADMIN"))
                                <button type="button"
                                        class="btn btn-outline-secondary w-100 fw-bold d-flex justify-content-center align-items-center"
                                        style="border-radius: 10px;"
                                        data-bs-toggle="modal" data-bs-target="#editUserModal-${user.getId()}">
                                    <span class="me-2 d-flex">@template.layout.icon(name = "setting")</span> Управління
                                </button>
                            @else
                                <button class="btn btn-light w-100 fw-bold text-muted" style="border-radius: 10px;"
                                        disabled>Адміністратор
                                </button>
                            @endif
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="editUserModal-${user.getId()}" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
                            <div class="modal-header bg-light border-0 py-3">
                                <h5 class="modal-title fw-bold">Управління: ${user.getFullName()}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <form action="/admin/academy/users/update/${user.getId()}" method="POST">
                                <div class="modal-body p-4">
                                    <div class="mb-4">
                                        <label class="form-label fw-bold text-muted small text-uppercase mb-2 d-flex align-items-center gap-2">
                                            <span class="d-flex">@template.layout.icon(name = "shop", size = "16")</span>
                                            Призначити магазин
                                        </label>
                                        <select class="form-select" name="shopId"
                                                style="border-radius: 12px; padding: 12px;">
                                            <option value="" selected="${user.getShopId() == null}">Не призначено
                                            </option>
                                            @for(var shop : shops)
                                                <option value="${shop.getId()}"
                                                        selected="${shop.getId().equals(user.getShopId())}">
                                                    ${shop.getName()}
                                                </option>
                                            @endfor
                                        </select>
                                    </div>

                                    <div class="mb-2">
                                        <label class="form-label fw-bold text-muted small text-uppercase mb-3 d-flex align-items-center gap-2">
                                            <span class="d-flex">@template.layout.icon(name = "personIcon", size = "16")</span>
                                            Рівень кваліфікації
                                        </label>
                                        <div class="row g-2">
                                            @for(var role : RoleUser.values())
                                                @if(!role.name().equals("ADMIN"))
                                                    <div class="col-6">
                                                        <input type="radio" class="btn-check" name="role"
                                                               id="role-${role.name()}-${user.getId()}"
                                                               value="${role.name()}"
                                                               checked="${user.getRole().equals(role.name())}">
                                                        <label class="btn btn-outline-tea w-100 py-2 fw-bold d-flex justify-content-center align-items-center gap-2"
                                                               for="role-${role.name()}-${user.getId()}"
                                                               style="border-radius: 10px;">
                                                            ${role.getDisplayRole()}
                                                        </label>
                                                    </div>
                                                @endif
                                            @endfor
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer border-0 p-4 pt-0">
                                    <button type="submit" class="btn-tea fw-bold w-100 py-3"
                                            style="border-radius: 12px; font-size: 1.1rem;">
                                        Зберегти зміни
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            @endfor
        </div>

        <div id="noResultsBlock" class="text-center py-5" style="display: none;">
            <div class="d-flex justify-content-center text-muted" style="margin-bottom: 1rem;">
                @template.layout.icon(name = "search", size = "48")
            </div>
            <h5 class="fw-bold text-dark">Співробітників не знайдено</h5>
            <p class="text-muted">За вашим запитом немає жодного збігу.</p>
        </div>

    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const searchInput = document.getElementById("userSearchInput");
            const userCols = document.querySelectorAll(".user-col");
            const noResultsBlock = document.getElementById("noResultsBlock");

            searchInput.addEventListener("input", function () {
                const query = this.value.toLowerCase().trim();
                let hasVisibleCards = false;

                userCols.forEach(function (col) {
                    const cardText = col.innerText.toLowerCase();

                    if (cardText.includes(query)) {
                        col.style.display = "";
                        hasVisibleCards = true;
                    } else {
                        col.style.display = "none";
                    }
                });

                if (hasVisibleCards) {
                    noResultsBlock.style.display = "none";
                } else {
                    noResultsBlock.style.display = "block";
                }
            });
        });
    </script>
`)