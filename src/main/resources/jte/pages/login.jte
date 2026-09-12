@param String errorMessage
@param String successMessage

<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Вхід - Teahouse Academy</title>
    <link href="/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/assets/css/teahouse-core.css" rel="stylesheet">
</head>
<body class="login-body">

<div class="login-card">
    <div class="logo-icon">🍵</div>
    <h3 class="fw-bold text-center mb-1 text-brand">Teahouse Academy</h3>
    <p class="text-center text-muted mb-4 small">Навчальна платформа для команди</p>

    @if(errorMessage != null)
        <div class="alert alert-danger rounded-4 small fw-bold text-center border-0 alert-error-custom">
            ⚠️ ${errorMessage}
        </div>
    @endif

    @if(successMessage != null)
        <div class="alert alert-success rounded-4 small fw-bold text-center border-0 alert-success-custom">
            ✅ ${successMessage}
        </div>
    @endif

    <form action="/login" method="POST">
        <div class="mb-3">
            <label class="form-label small fw-bold text-muted text-uppercase mb-1 form-label-custom">Електронна пошта</label>
            <input type="email" name="username" class="form-control" placeholder="your@email.com" required autofocus>
        </div>

        <div class="mb-4">
            <label class="form-label small fw-bold text-muted text-uppercase mb-1 form-label-custom">Пароль</label>
            <input type="password" name="password" class="form-control" placeholder="••••••••" required>
        </div>

        <button type="submit" class="btn-login">Увійти в систему</button>
    </form>
</div>

</body>
</html>