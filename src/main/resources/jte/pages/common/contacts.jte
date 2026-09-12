@template.layout.main(content = @`
    <style>
        .tea-green {
            color: #064e3b;
            font-weight: 800;
        }

        .contact-card {
            background: #ffffff;
            border: 1px solid #cbd5e1;
            border-left: 6px solid #10b981;
            border-radius: 16px;
            transition: all 0.2s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.04), 0 2px 4px rgba(0, 0, 0, 0.02);
        }

        .contact-card:hover {
            border-color: #94a3b8;
            border-left-color: #059669;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
            transform: translateY(-2px);
        }

        .contact-card .card-footer {
            border-top: 1px solid #f1f5f9 !important;
            padding-top: 12px !important;
            margin-top: auto;
        }

        .tab-btn {
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.2s;
        }
    </style>

    <div class="container my-5" style="max-width: 1000px;">

        <div class="d-flex gap-2 mb-5">
            <button type="button" class="btn btn-success px-4 py-2 tab-btn" id="btnInternal"
                    onclick="switchTab('internal')" style="background-color: #064e3b; border-color: #064e3b;">
                Внутрішні контакти
            </button>
            <button type="button" class="btn btn-outline-success px-4 py-2 tab-btn" id="btnExternal"
                    onclick="switchTab('external')" style="color: #064e3b; border-color: #064e3b;">
                Зовнішні контакти
            </button>
        </div>

        <div id="tab-internal">

            <h3 class="mb-4 tea-green d-flex align-items-center gap-2">
                <span class="d-flex">@template.layout.icon(name = "personIcon", size = "28")</span> Керівник
            </h3>
            <div class="row row-cols-1 row-cols-md-2 g-4 mb-5">
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Тетяна</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Керівник мережі Teahouse</h6>
                            <p class="card-text text-secondary small">
                                Проблеми з технікою, ТО обладнення, допомога у роботі з клієнтами, графіки магазинів.
                                Організаційні питання, робота магазину, питання заробітної плати, побажання покращення в роботі магазину, ІПП, відпустки, внутрішні питання магазину, ремонти, якість кондитерки, графіки, термінові питання.
                            </p>
                        </div>
                        <div class="card-footer bg-white d-flex justify-content-between align-items-center">
                            <span class="fw-bold" style="color: #059669;">+380 98 354 16 83</span>
                            <span class="fw-bold" style="color: #059669;">+380 68 542 07 75</span>
                        </div>
                    </div>
                </div>
            </div>

            <h3 class="mb-4 tea-green d-flex align-items-center gap-2">
                <span class="d-flex">@template.layout.icon(name = "setting", size = "28")</span> Технічна підтримка
            </h3>
            <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Артем</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Системний Адміністратор</h6>
                            <p class="card-text text-secondary small">Додати опис</p>
                        </div>
                        <div class="card-footer bg-white">
                            <span class="fw-bold" style="color: #059669;">+380 67 222 42 60</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Пахоленко Ігор</h5>
                            <h6 class="card-subtitle mb-3 text-muted">IT спеціаліст</h6>
                            <p class="card-text text-secondary small">Займатися тех підтримкою людей та обладнання</p>
                        </div>
                        <div class="card-footer bg-white">
                            <span class="fw-bold" style="color: #059669;">+380 68 888 93 72</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Едуард</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Адміністратор РРО</h6>
                            <p class="card-text text-secondary small">Займатися питаннями з платіжною системою РРО</p>
                        </div>
                        <div class="card-footer bg-white">
                            <span class="fw-bold" style="color: #059669;">+380 68 742 68 42</span>
                        </div>
                    </div>
                </div>
            </div>

            <h3 class="mb-4 tea-green d-flex align-items-center gap-2">
                <span class="d-flex">@template.layout.icon(name = "tea", size = "28")</span> Навчання та адміністративні питання
            </h3>
            <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Ксенія</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Помічник адміністратора</h6>
                            <p class="card-text text-secondary small">Допомога в дрібних адміністративних питаннях, ведення зміни та питання чаю</p>
                        </div>
                        <div class="card-footer bg-white d-flex justify-content-between align-items-center">
                            <span class="fw-bold text-muted">Телеграм</span>
                            <a href="https://t.me/k12_ka_12" target="_blank" class="text-success" style="color: #10b981 !important;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-send-fill" viewBox="0 0 16 16">
                                    <path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083l6-15Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z"/>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Артем</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Чайний мейстер</h6>
                            <p class="card-text text-secondary small">Допомога з питаннями про чай, посуд та чайні церемонії</p>
                        </div>
                        <div class="card-footer bg-white d-flex justify-content-between align-items-center">
                            <span class="fw-bold text-muted">Телеграм</span>
                            <a href="https://t.me/Proshaimolodost13" target="_blank" class="text-success" style="color: #10b981 !important;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-send-fill" viewBox="0 0 16 16">
                                    <path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083l6-15Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z"/>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Марія</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Чайний мейстер</h6>
                            <p class="card-text text-secondary small">Допомога з питаннями про чай, посуд та чайні церемонії</p>
                        </div>
                        <div class="card-footer bg-white d-flex justify-content-between align-items-center">
                            <span class="fw-bold text-muted">Телеграм</span>
                            <a href="https://t.me/mazhulikk" target="_blank" class="text-success" style="color: #10b981 !important;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-send-fill" viewBox="0 0 16 16">
                                    <path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083l6-15Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z"/>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <h3 class="mb-4 tea-green d-flex align-items-center gap-2">
                <span class="d-flex">@template.layout.icon(name = "document", size = "28")</span> Бухгалтерія та замовлення
            </h3>
            <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Сюзанна</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Головний бухгалтер</h6>
                            <p class="card-text text-secondary small">Новий товар, ціни, комплектуючі, переоблік, закриття зміни в 1С</p>
                        </div>
                        <div class="card-footer bg-white">
                            <span class="fw-bold" style="color: #059669;">+380 93 713 61 66</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Люба</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Помічник бухгалтера</h6>
                            <p class="card-text text-secondary small">Робота в 1С, переміщення товарів, ціни, комплектуючі, переоблік, закриття зміни в 1С</p>
                        </div>
                        <div class="card-footer bg-white">
                            <span class="fw-bold" style="color: #059669;">+380 50 721 69 75</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Вікторія</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Бухгалтер</h6>
                            <p class="card-text text-secondary small">Бухгалтер по всіх платежах</p>
                        </div>
                        <div class="card-footer bg-white">
                            <span class="fw-bold" style="color: #059669;">+380 96 286 43 98</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Наталія</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Менеджер Teahouse</h6>
                            <p class="card-text text-secondary small">Замовлення на склад, наявність товару на складі, залишки товарів</p>
                        </div>
                        <div class="card-footer bg-white">
                            <span class="fw-bold" style="color: #059669;">+380 67 639 08 03</span>
                        </div>
                    </div>
                </div>
            </div>

            <h3 class="mb-4 tea-green d-flex align-items-center gap-2">
                <span class="d-flex">@template.layout.icon(name = "shop", size = "28")</span> Кондитерка
            </h3>
            <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Кондитерська</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Загальний номер</h6>
                        </div>
                        <div class="card-footer bg-white">
                            <span class="fw-bold" style="color: #059669;">+380 68 827 78 93</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Катерина</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Старший кондитер</h6>
                        </div>
                        <div class="card-footer bg-white">
                            <span class="fw-bold" style="color: #059669;">+380 95 137 84 31</span>
                        </div>
                    </div>
                </div>
            </div>

        </div>


        <div id="tab-external" style="display:none;">

            <h3 class="mb-4 tea-green d-flex align-items-center gap-2">
                <span class="d-flex">@template.layout.icon(name = "shop", size = "28")</span> Замовлення молока
            </h3>
            <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Постачальник молока</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Додати назву</h6>
                            <p class="card-text text-secondary small">Додати опис</p>
                        </div>
                        <div class="card-footer bg-white">
                            <span class="fw-bold text-muted">Додати номер</span>
                        </div>
                    </div>
                </div>
            </div>

            <h3 class="mb-4 tea-green d-flex align-items-center gap-2">
                <span class="d-flex">@template.layout.icon(name = "archive", size = "28")</span> Інші постачальники
            </h3>
            <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                <div class="col">
                    <div class="card h-100 contact-card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Постачальник</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Додати назву</h6>
                            <p class="card-text text-secondary small">Додати опис</p>
                        </div>
                        <div class="card-footer bg-white">
                            <span class="fw-bold text-muted">Додати номер</span>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>

    <script>
        function switchTab(tab) {
            document.getElementById("tab-internal").style.display = tab === "internal" ? "" : "none";
            document.getElementById("tab-external").style.display = tab === "external" ? "" : "none";

            const btnInternal = document.getElementById("btnInternal");
            const btnExternal = document.getElementById("btnExternal");

            if (tab === "internal") {
                btnInternal.className = "btn btn-success px-4 py-2 tab-btn";
                btnInternal.style.backgroundColor = "#064e3b";
                btnInternal.style.color = "#ffffff";

                btnExternal.className = "btn btn-outline-success px-4 py-2 tab-btn";
                btnExternal.style.backgroundColor = "transparent";
                btnExternal.style.color = "#064e3b";
            } else {
                btnExternal.className = "btn btn-success px-4 py-2 tab-btn";
                btnExternal.style.backgroundColor = "#064e3b";
                btnExternal.style.color = "#ffffff";

                btnInternal.className = "btn btn-outline-success px-4 py-2 tab-btn";
                btnInternal.style.backgroundColor = "transparent";
                btnInternal.style.color = "#064e3b";
            }
        }
    </script>
`)