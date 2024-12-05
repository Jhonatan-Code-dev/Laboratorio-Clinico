<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${pageContext.request.contextPath}/img/Green Brown Minimalist Shield Hand Logo.png" type="image/png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }
        .main-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: #fff;
            border-bottom: 2px solid #bbbbbb;
        }

        .main-nav__logo-title {
            display: flex;
            align-items: center;
        }

        .main-nav__logo {
            width: 40px;
            height: auto;
            margin-right: 10px;
        }

        .main-nav__title {
            margin: 0;
            font-size: 24px;
            color: #0066cc;
        }

        .main-nav__buttons {
            display: flex;
        }

        .main-nav__button {
            padding: 10px 20px;
            margin-left: 10px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            border: none;
            text-decoration: none;
        }

        .main-nav__button--login {
            background-color: #0096ad;
            color: white;
        }

        .main-nav__button--login:hover {
            background-color: #007777;
        }

        .main-nav__button--register {
            background-color: white;
            color: #009999;
            border: 2px solid #0096ad;
        }

        .main-nav__button--register:hover {
            background-color: #f0f0f0;
        }

        .main-section {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: white;
            padding: 20px;
            border-bottom: 2px solid #bbbbbb;
        }

        .main-section__text {
            max-width: 60%;
        }

        .main-section__title {
            color: black;
            font-size: 50px;
            margin-bottom: 10px;
        }

        .main-section__subtitle {
            color: #0096ad;
            font-size: 30px;
        }

        .main-section__image {
            max-width: 500px;
            height: auto;
            border-radius: 20px;
            mix-blend-mode: multiply;
        }

        .info-section {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 20px;
            background-color: white;
        }

        .info-section__text {
            max-width: 60%;
            margin-right: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .info-section__title {
            font-size: 2em;
            text-align: center;
            width: 100%;
            margin-bottom: 10px;
        }

        .info-section__highlight {
            color: #0096ad;
        }

        .info-section__subtitle {
            color: black;
            font-size: 1.5em;
            margin-bottom: 20px;
        }

        .info-section__list {
            list-style-type: disc;
            margin-left: 20px;
        }

        .info-section__list-item {
            margin: 10px 0;
        }

        .info-section__list-item::marker {
            color: #0096ad;
        }

        .info-section__image {
            max-width: 400px;
            height: auto;
        }

        .services-section {
            background-color: #0096ad;
            color: white;
            padding: 20px;
            margin: 0;
            position: relative;
            left: 0;
            right: 0;
        }

        .services-section__title {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: white;
            text-align: center;
        }

        .services-section__description {
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .services-cards {
            display: flex;
            justify-content: center;
            gap: 3rem;
        }

        .service-card {
            background-color: white;
            color: #000;
            padding: 1.5rem;
            border-radius: 10px;
            width: 300px;
            height: 200px;
            text-align: center;
        }

        .service-card__icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #0096ad;
        }

        .service-card__title {
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .service-card__description {
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .service-card__link {
            color: #0066cc;
            text-decoration: none;
        }

        .service-card__link:hover {
            text-decoration: underline;
        }

        .sedes {
            background-color: #fff;
            color: #0096ad;
            padding: 20px;
            margin: 0;
            position: relative;
            left: 0;
            right: 0;
            display: flex;
            align-items: flex-start;
        }

        .sedes__image-container {
            width: 30%;
            margin: 15px;
            margin-left: 10%;
        }

        .sedes__image {
            width: 100%;
            border-radius: 50%;
            border: 3px solid #0096ad;
        }

        .sedes__content {
            width: 60%;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            margin-left: 10%;
            text-align: center;
        }

        .sedes__title {
            color: #0096ad;
            font-size: 28px;
            margin-bottom: 20px;

        }

        .sedes__locations {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-bottom: 20px;
        }

        .sedes__location {
            padding: 15px;
        }

        .sedes__address {
            font-weight: bold;
            color: #000;
            margin-bottom: 5px;
        }

        .sedes__detail {
            font-size: 14px;
            color: #666;
        }

        .sedes__hours-title {
            font-weight: bold;
            color: #0096ad;
            margin-bottom: 5px;
        }

        .sedes__hours-detail {
            color: #000;
        }


        @media (max-width: 1200px) and (min-width: 768px) {
            .main-section {
                flex-direction: column;
                align-items: center;
            }

            .main-section__title {
                font-size: 36px;
                text-align: center;
            }

            .main-section__subtitle {
                font-size: 24px;
                text-align: center;
            }

            .sedes {
                flex-direction: column;
                align-items: center;
            }

            .sedes__image-container {
                width: 50%;
                margin-left: 0;
            }

            .sedes__content {
                width: 80%;
                margin-left: 0;
                text-align: center;
            }

            .sedes__title {
                font-size: 24px;
            }

            .sedes__locations {
                gap: 15px;
            }

            .sedes__location {
                padding: 10px;
            }
        }

        @media (max-width: 768px) {
            .main-nav {
                flex-direction: column;
                align-items: flex-start;
            }

            .main-nav__buttons {
                flex-direction: column;
                align-items: flex-start;
                margin-top: 10px;
            }

            .main-section {
                flex-direction: column;
                align-items: center;
            }

            .main-section__text {
                max-width: 90%;
                text-align: center;
            }

            .main-section__title {
                font-size: 28px;
            }

            .main-section__subtitle {
                font-size: 18px;
            }


            .sedes__image-container {
                display: none;
            }

            .sedes__content {
                width: 90%;
                margin: 0 auto;
                text-align: center;
            }

            .sedes__title {
                font-size: 22px;
            }

            .sedes__locations {
                gap: 10px;
            }

            .sedes__location {
                padding: 10px;
                font-size: 14px;
            }
        }


        @media (max-width: 480px) {
            .main-nav__title {
                font-size: 18px;
            }

            .main-section__title {
                font-size: 22px;
                text-align: center;
            }

            .main-section__subtitle {
                font-size: 16px;
                text-align: center;
            }

            .service-card{
                height: 250px;
                width: 200px;
            }
            .sedes__image-container {
                display: none;
            }

            .info-section__image{
                display: none;
            }
            .main-section__image{
                display: none;
            }
            .sedes__content {
                width: 100%;
                padding: 10px;
            }

            .sedes__title {
                font-size: 18px;
            }

            .sedes__location {
                padding: 10px;
                font-size: 14px;
            }
        }
    </style>
    <title>UnionLab</title>
</head>
<body>
<nav class="main-nav">
    <div class="main-nav__logo-title">
        <img class="main-nav__logo" src="${pageContext.request.contextPath}/img/Green Brown Minimalist Shield Hand Logo.png" alt="Logo UnionLab">
        <h1 class="main-nav__title">UnionLab</h1>
    </div>
    <div class="main-nav__buttons">
        <a href="login" class="main-nav__button main-nav__button--login">Iniciar sesión</a>
        <a href="registro" class="main-nav__button main-nav__button--register">Registrate</a>
    </div>
</nav>
<section class="main-section">
    <div class="main-section__text">
        <h2 class="main-section__title">La exactitud en cada prueba</h2>
        <h3 class="main-section__subtitle">¡La mejor ayuda a tu diagnóstico!</h3>
    </div>
    <div class="main-section__image-container">
        <img class="main-section__image" src="${pageContext.request.contextPath}/img/laboratorista.png" alt="Imagen relacionada">
    </div>
</section>

<section class="info-section">
    <div class="info-section__text">
        <h2 class="info-section__title">¿Qué deseas <span class="info-section__highlight">realizar hoy</span>?</h2>
        <h3 class="info-section__subtitle">En UnionLab cuidamos tu salud y tu tiempo</h3>
        <ul class="info-section__list">
            <li class="info-section__list-item">Agenda tus análisis en cualquier momento</li>
            <li class="info-section__list-item">Accede al historial de tus análisis</li>
            <li class="info-section__list-item">Visualiza tus resultados de laboratorio</li>
        </ul>
    </div>
    <div class="info-section__image-container">
        <img class="info-section__image" src="${pageContext.request.contextPath}/img/image.png" alt="Imagen informativa">
    </div>
</section>

<section class="services-section">
    <h2 class="services-section__title">Conoce nuestros servicios digitales</h2>
    <p class="services-section__description">Atención más rápida y a tu alcance, siempre con UnionLab</p>

    <div class="services-cards">
        <div class="service-card">
            <div class="service-card__icon">
                <i class="fas fa-calendar-alt"></i>
            </div>
            <div class="service-card__title">Agendar análisis médico</div>
            <div class="service-card__description">Agenda tus exámenes de forma rápida y segura.</div>
            <a href="#" class="service-card__link">Agenda tu examen</a>
        </div>

        <div class="service-card">
            <div class="service-card__icon">
                <i class="fas fa-flask"></i>
            </div>
            <div class="service-card__title">Visualizar resultados</div>
            <div class="service-card__description">Recibe los resultados de manera más fácil y rápida.</div>
            <a href="#" class="service-card__link">Ve tus resultados</a>
        </div>
    </div>
</section>

<section class="sedes">
    <div class="sedes__image-container">
        <img src="${pageContext.request.contextPath}/img/enfermera.png" alt="Healthcare professional" class="sedes__image">
    </div>

    <div class="sedes__content">
        <h2 class="sedes__title">Conoce nuestras sedes en:</h2>

        <div class="sedes__locations">
            <div class="sedes__location">
                <p class="sedes__address">AV. Unión 1692 - 2do. PISO</p>
                <p class="sedes__detail">(Al costado de la Municipalidad)</p>
            </div>

            <div class="sedes__location">
                <p class="sedes__address">AV. Grau 1440 - 2do. PISO</p>
                <p class="sedes__detail">(Frente al Hospital Juan Pablo II)</p>
            </div>
        </div>

        <div class="sedes__location">
            <p class="sedes__hours-title">Horarios de Atención:</p>
            <p class="sedes__hours-detail">LUNES A SÁBADOS DE: 7:00am a 6:00pm</p>
        </div>
    </div>
</section>
</body>
</html>