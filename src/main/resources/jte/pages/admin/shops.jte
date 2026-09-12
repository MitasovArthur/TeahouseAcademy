@import com.teahouse.teahouse_academy.model.dto.shop.ShopDto
@import com.teahouse.teahouse_academy.model.dto.city.CityShortDto

@param java.util.List<ShopDto> shops
@param java.util.List<CityShortDto> cities

@template.layout.main(content = @`
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/choices.js/public/assets/styles/choices.min.css" />
    <link href="/assets/css/admin.css" rel="stylesheet"/>

    <div class="container my-5">
        @template.pages.admin.components.admin-tabs(activeTab = "locations")

        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 p-3 bg-white shadow-sm rounded-4 gap-3">
            <h5 class="fw-bold text-dark mb-0 px-2">Керування локаціями</h5>
            <div class="d-flex gap-2">
                <button class="btn btn-outline-secondary fw-bold shadow-sm d-inline-flex align-items-center" style="border-radius: 10px;" data-bs-toggle="modal" data-bs-target="#createCityModal">
                    <span class="me-2 d-flex">@template.layout.icon(name = "city")</span> Додати місто
                </button>
                <button class="btn btn-tea fw-bold shadow-sm d-inline-flex align-items-center" style="border-radius: 10px;" data-bs-toggle="modal" data-bs-target="#createShopModal">
                    <span class="me-2 d-flex">@template.layout.icon(name = "shop")</span> Додати магазин
                </button>
            </div>
        </div>

        <div class="row row-cols-1 row-cols-md-2 row-cols-xl-3 g-4">
            @if(shops == null || shops.isEmpty())
                <div class="col-12 text-center py-5 bg-white rounded-4 shadow-sm">
                    <div style="color: #cbd5e1; margin-bottom: 1rem;">
                        @template.layout.icon(name = "shop", size = "48")
                    </div>
                    <h5 class="text-muted">Магазинів поки немає.</h5>
                </div>
            @else
                @for(var shop : shops)
                    <div class="col">
                        <div class="card h-100 shadow-sm shop-card bg-white">
                            <div class="card-body p-4">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="shop-icon-circle me-3">
                                        @template.layout.icon(name = "shop")
                                    </div>

                                    <div class="text-truncate">
                                        <h5 class="fw-bold mb-0 text-dark text-truncate">${shop.getName()}</h5>
                                        <div class="text-muted small d-flex align-items-center">
                                            <span class="text-danger me-1 d-flex">@template.layout.icon(name = "mapPin")</span>
                                            ${shop.getCityName()}
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="text-muted small fw-bold text-uppercase d-block mb-1" style="font-size: 0.65rem;">Адреса</label>
                                    <p class="mb-0 text-dark fw-medium small">${shop.getAddress()}</p>
                                </div>

                                <div class="mt-4 pt-3 border-top d-flex justify-content-between align-items-center">
                                    <div class="text-muted small fw-bold text-uppercase" style="font-size: 0.65rem;">Співробітники</div>

                                    @if(shop.getEmployeeCount() > 0)
                                        <button type="button" class="btn btn-sm btn-link text-decoration-none text-dark p-0 fw-bold hover-accent d-inline-flex align-items-center"
                                                data-bs-toggle="modal" data-bs-target="#workerListModal-${shop.getId()}" title="Показати список">
                                            <span class="text-success me-1 d-flex">@template.layout.icon(name = "personIcon")</span>
                                            ${shop.getEmployeeCount()} чол.
                                        </button>
                                    @else
                                        <span class="text-muted small d-inline-flex align-items-center">
                                            <span class="me-1 d-flex">@template.layout.icon(name = "personIcon")</span>0 чол.
                                        </span>
                                    @endif
                                </div>
                            </div>
                            <div class="card-footer bg-transparent border-top p-3">
                                <button class="btn btn-outline-secondary fw-bold w-100" style="border-radius: 10px;" data-bs-toggle="modal" data-bs-target="#editShopModal-${shop.getId()}">
                                    <span class="me-2">@template.layout.icon(name = "setting")</span>Редагувати
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="workerListModal-${shop.getId()}" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-sm">
                            <div class="modal-content border-0 shadow-lg" style="border-radius: 16px;">
                                <div class="modal-header border-0 pb-0">
                                    <h6 class="modal-title fw-bold text-muted text-uppercase" style="font-size: 0.75rem; letter-spacing: 0.05rem;">
                                        Команда: ${shop.getName()}
                                    </h6>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body p-4 pt-3">
                                    @if(shop.getName() != null && !shop.getWorkerNames().isEmpty())
                                        <div class="d-flex flex-column gap-3">
                                            @for(String workerName : shop.getWorkerNames())
                                                <div class="d-flex align-items-center gap-3">
                                                    <div class="worker-avatar shadow-sm">
                                                        ${workerName.substring(0, 1).toUpperCase()}
                                                    </div>
                                                    <div class="fw-medium text-dark">${workerName}</div>
                                                </div>
                                            @endfor
                                        </div>
                                    @else
                                        <div class="text-center text-muted py-3">Немає призначених працівників</div>
                                    @endif
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="editShopModal-${shop.getId()}" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content border-0 shadow-lg" style="border-radius: 16px;">
                                <div class="modal-header bg-light border-0 py-3">
                                    <h5 class="modal-title fw-bold"><i class="bi bi-gear text-muted me-2"></i>Налаштування: ${shop.getName()}</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <form action="/admin/academy/shops/edit/${shop.getId()}" method="POST">
                                    <div class="modal-body p-4">
                                        <div class="mb-3">
                                            <label class="form-label fw-bold text-muted small text-uppercase">Назва магазину</label>
                                            <input type="text" class="form-control" name="name" value="${shop.getName()}" required style="border-radius: 10px;">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label fw-bold text-muted small text-uppercase">Повна адреса</label>
                                            <input type="text" class="form-control" name="address" value="${shop.getAddress()}" required style="border-radius: 10px;">
                                        </div>
                                        <div class="mb-3 position-relative">
                                            <label class="form-label fw-bold text-muted small text-uppercase">Місто</label>
                                            <select class="form-select city-select" name="cityId" required>
                                                @for(var city : cities)
                                                    <option value="${city.getId()}" selected="${city.getId().equals(shop.getCityId())}">
                                                        ${city.getName()}
                                                    </option>
                                                @endfor
                                            </select>
                                        </div>

                                        <div class="w-100 p-3 mt-4" style="background-color: #fff5f5; border: 1px dashed #feb2b2; border-radius: 12px;">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <div class="fw-bold text-danger small text-uppercase" style="font-size: 0.7rem; letter-spacing: 0.05rem;">Зона небезпеки</div>
                                                    <div class="text-muted" style="font-size: 0.75rem;">Видалення локації неможливо скасувати.</div>
                                                </div>
                                                <button type="button" class="btn btn-sm btn-outline-danger fw-bold px-3"
                                                        style="border-radius: 8px;"
                                                        data-bs-toggle="modal" data-bs-target="#confirmDeleteModal-${shop.getId()}">
                                                    Видалити
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer border-0 p-4 pt-0">
                                        <button type="submit" class="btn-tea w-100 fw-bold py-2" style="border-radius: 10px;">Зберегти зміни</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="confirmDeleteModal-${shop.getId()}" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
                                <div class="modal-header bg-danger text-white border-0" style="border-top-left-radius: 20px; border-top-right-radius: 20px; padding: 1.2rem 1.5rem;">
                                    <h5 class="modal-title fw-bold d-flex align-items-center">
                                        <i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>Підтвердження видалення
                                    </h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body p-5 text-center">
                                    <h4 class="fw-bold mb-3" style="color: #2d3748;">Ви впевнені?</h4>
                                    <p class="text-muted mb-4">
                                        Ви збираєтесь видалити локацію <span class="fw-bold text-dark">"${shop.getName()}"</span>.<br>
                                        Усі дані, пов'язані з цим магазином, будуть втрачені.
                                    </p>
                                    <div class="p-3 mb-0 rounded-3" style="background-color: #fff5f5;">
                                        <p class="text-danger fw-bold mb-0" style="font-size: 0.9rem;">Цю дію неможливо скасувати!</p>
                                    </div>
                                </div>
                                <div class="modal-footer border-0 p-4 pt-0 d-flex gap-2">
                                    <button type="button" class="btn btn-outline-secondary flex-grow-1 fw-bold py-2"
                                            data-bs-dismiss="modal" style="border-radius: 12px;">
                                        Скасувати
                                    </button>
                                    <form action="/admin/academy/shops/delete/${shop.getId()}" method="POST" class="flex-grow-1 m-0">
                                        <button type="submit" class="btn btn-danger w-100 fw-bold py-2"
                                                style="border-radius: 12px; background-color: #e53e3e;">
                                            Так, видалити
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                @endfor
            @endif
        </div>

        <div class="modal fade" id="createCityModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg" style="border-radius: 16px;">
                    <div class="modal-header bg-light border-0 py-3">
                        <h5 class="modal-title fw-bold d-flex align-items-center">
                            <span class="text-tea me-2 d-flex">@template.layout.icon(name = "city")</span>Додати нове місто
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="/admin/academy/cities/create" method="POST">
                        <div class="modal-body p-4">
                            <div class="mb-3">
                                <label class="form-label fw-bold text-muted small text-uppercase">Назва міста</label>
                                <input type="text" class="form-control" name="name" required style="border-radius: 10px;" placeholder="Наприклад: Київ">
                            </div>
                        </div>
                        <div class="modal-footer border-0 p-4 pt-0 d-flex gap-2">
                            <button type="button" class="btn btn-outline-secondary flex-grow-1 fw-bold py-2" data-bs-dismiss="modal" style="border-radius: 10px;">Скасувати</button>
                            <button type="submit" class="btn btn-success flex-grow-1 fw-bold py-2" style="border-radius: 10px;">Додати</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="createShopModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg" style="border-radius: 16px;">
                    <div class="modal-header bg-light border-0 py-3">
                        <h5 class="modal-title fw-bold d-flex align-items-center">
                            <span class="text-tea me-2 d-flex">@template.layout.icon(name = "shop")</span>Додати новий магазин
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="/admin/academy/shops/create" method="POST">
                        <div class="modal-body p-4">
                            <div class="mb-3">
                                <label class="form-label fw-bold text-muted small text-uppercase">Назва магазину</label>
                                <input type="text" class="form-control" name="name" required style="border-radius: 10px;" placeholder="Напр: ЦУМ">
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold text-muted small text-uppercase">Повна адреса</label>
                                <input type="text" class="form-control" name="address" required style="border-radius: 10px;" placeholder="Вул. Хрещатик, 38">
                            </div>
                            <div class="mb-3 position-relative">
                                <label class="form-label fw-bold text-muted small text-uppercase">Місто</label>
                                <select class="form-select city-select" name="cityId" required>
                                    <option value="" disabled selected>Оберіть місто для пошуку...</option>
                                    @for(var city : cities)
                                        <option value="${city.getId()}">${city.getName()}</option>
                                    @endfor
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer border-0 p-4 pt-0 d-flex gap-2">
                            <button type="button" class="btn btn-outline-secondary flex-grow-1 fw-bold py-2" data-bs-dismiss="modal" style="border-radius: 10px;">Скасувати</button>
                            <button type="submit" class="btn-tea flex-grow-1 fw-bold py-2" style="border-radius: 10px;">Створити</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/choices.js/public/assets/scripts/choices.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const selects = document.querySelectorAll('.city-select');

            selects.forEach(function(select) {
                new Choices(select, {
                    searchEnabled: true,
                    itemSelectText: '',
                    noResultsText: 'Місто не знайдено',
                    noChoicesText: 'Немає варіантів для вибору',
                    placeholder: true,
                    placeholderValue: 'Почніть вводити назву...',
                    searchPlaceholderValue: 'Пошук міста...'
                });
            });
        });
    </script>
`)