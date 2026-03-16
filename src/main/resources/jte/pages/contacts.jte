@template.layout.main(content = @`
    <div class="container my-5">

        <div class="d-flex gap-2 mb-5">
            <button type="button" class="btn btn-success px-4" id="btnInternal"
                    onclick="switchTab('internal')">
                Внутрішні контакти
            </button>
            <button type="button" class="btn btn-outline-success px-4" id="btnExternal"
                    onclick="switchTab('external')">
                Зовнішні контакти
            </button>
        </div>

        <div id="tab-internal">

            <h2 class="mb-4 tea-green">Керівник</h2>
            <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Тетяна</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Керівник мережі Teahouse</h6>
                            <p class="card-text text-secondary small">Проблеми з технікою, ТО обладнення,
                                допомога у роботі з клієнтами, графіки магазинів.
                                Організаційні питання, робота магазину, питання заробітної плати,
                                побажання покращення в роботі магазину, ІПП, відпустки,
                                внутрішні питання магазину, ремонти, якість кондитерки,
                                графіки, термінові питання.</p>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0 d-flex justify-content-between align-items-center">
                            <span class="fw-bold tea-green">+380 98 354 16 83</span>
                            <span class="fw-bold tea-green">+380 68 542 07 75</span>
                        </div>
                    </div>
                </div>
            </div>

            <h2 class="mb-4 tea-green">Технічна підтримка</h2>
            <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Артем</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Системний Адміністратор</h6>
                            <p class="card-text text-secondary small">Додати опис</p>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0">
                            <span class="fw-bold tea-green">+380 67 222 42 60</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Пахоленко Ігор</h5>
                            <h6 class="card-subtitle mb-3 text-muted">IT спеціаліст</h6>
                            <p class="card-text text-secondary small">Займатися тех підтримкою людей та обладнання</p>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0">
                            <span class="fw-bold tea-green">+380 68 888 93 72</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Едуард</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Адміністратор РРО</h6>
                            <p class="card-text text-secondary small">Займатися питаннями з платіжною системою РРО</p>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0">
                            <span class="fw-bold tea-green">+380 68 742 68 42</span>
                        </div>
                    </div>
                </div>
            </div>

            <h2 class="mb-4 tea-green">Помічники з навчання та адміністративних питань</h2>
            <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Ксенія</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Помічник адміністратора</h6>
                            <p class="card-text text-secondary small">Допомога в дрібних адміністративних питаннях,
                                ведення зміни та питання чаю</p>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0 d-flex justify-content-between align-items-center">
                            <span class="fw-bold tea-green">Телеграм</span>
                            <a href="https://t.me/k12_ka_12" target="_blank" class="text-success">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                                     class="bi bi-send-fill" viewBox="0 0 16 16">
                                    <path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083l6-15Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z"/>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Артем</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Чайний мейстер</h6>
                            <p class="card-text text-secondary small">Допомога з питаннями про чай, посуд та чайні
                                церемонії</p>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0 d-flex justify-content-between align-items-center">
                            <span class="fw-bold tea-green">Телеграм</span>
                            <a href="https://t.me/Proshaimolodost13" target="_blank" class="text-success">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                                     class="bi bi-send-fill" viewBox="0 0 16 16">
                                    <path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083l6-15Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z"/>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Марія</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Чайний мейстер</h6>
                            <p class="card-text text-secondary small">Допомога з питаннями про чай, посуд та чайні
                                церемонії</p>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0 d-flex justify-content-between align-items-center">
                            <span class="fw-bold tea-green">Телеграм</span>
                            <a href="https://t.me/mazhulikk" target="_blank" class="text-success">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                                     class="bi bi-send-fill" viewBox="0 0 16 16">
                                    <path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083l6-15Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z"/>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <h2 class="mb-4 tea-green">Бухгалтерія та замовлення</h2>
            <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Сюзанна</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Головний бухгалтер</h6>
                            <p class="card-text text-secondary small">Новий товар, ціни, комплектуючі, переоблік,
                                закриття зміни в 1С</p>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0">
                            <span class="fw-bold tea-green">+380 93 713 61 66</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Люба</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Помічник бухгалтера</h6>
                            <p class="card-text text-secondary small">Робота в 1С, переміщення товарів, ціни,
                                комплектуючі, переоблік, закриття зміни в 1С</p>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0">
                            <span class="fw-bold tea-green">+380 50 721 69 75</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Вікторія</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Бухгалтер</h6>
                            <p class="card-text text-secondary small">Бухгалтер по всіх платежах</p>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0">
                            <span class="fw-bold tea-green">+380 96 286 43 98</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Наталія</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Менеджер Teahouse</h6>
                            <p class="card-text text-secondary small">Замовлення на склад, наявність товару на складі,
                                залишки товарів</p>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0">
                            <span class="fw-bold tea-green">+380 67 639 08 03</span>
                        </div>
                    </div>
                </div>
            </div>

            <h2 class="mb-4 tea-green">Кондитерка</h2>
            <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Кондитерська</h5>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0">
                            <span class="fw-bold tea-green">+380 68 827 78 93</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Катерина</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Наш старший кондитер</h6>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0">
                            <span class="fw-bold tea-green">+380 95 137 84 31</span>
                        </div>
                    </div>
                </div>
            </div>

        </div>


        <div id="tab-external" style="display:none;">

            <h2 class="mb-4 tea-green">Замовлення молока</h2>
            <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Постачальник молока</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Додати назву</h6>
                            <p class="card-text text-secondary small">Додати опис</p>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0">
                            <span class="fw-bold tea-green">Додати номер</span>
                        </div>
                    </div>
                </div>
            </div>

            <h2 class="mb-4 tea-green">Інші постачальники</h2>
            <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Постачальник</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Додати назву</h6>
                            <p class="card-text text-secondary small">Додати опис</p>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0">
                            <span class="fw-bold tea-green">Додати номер</span>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>

    <style>
        .tea-green { color: rgb(14, 87, 39); }
    </style>

    <script>
        function switchTab(tab) {
            document.getElementById("tab-internal").style.display  = tab === "internal" ? "" : "none";
            document.getElementById("tab-external").style.display  = tab === "external" ? "" : "none";

            document.getElementById("btnInternal").className = tab === "internal"
                ? "btn btn-success px-4"
                : "btn btn-outline-success px-4";

            document.getElementById("btnExternal").className = tab === "external"
                ? "btn btn-success px-4"
                : "btn btn-outline-success px-4";
        }
    </script>
`)