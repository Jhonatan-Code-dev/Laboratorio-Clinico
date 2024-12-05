<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="icon" href="${pageContext.request.contextPath}/img/Green Brown Minimalist Shield Hand Logo.png" type="image/png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;

        }
        .card {
            width: 450px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            box-shadow: 0 0 80px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .card-header {
            background-color: #0044cc;
            color: #fff;
            padding: 2rem;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            text-align: center;
            margin: 0;
        }
        .card-header h2 {
            text-align: center;
            font-size: 2.5rem;
            margin-top: 1rem;
        }
        .card-header svg {
            width: 80px;
            height: 80px;
        }
        .card-body {
            padding: 2.5rem;
        }
        .form-label {
            font-weight: bold;
            color: #0044cc;
            display: flex;
            align-items: center;
        }
        .form-label svg {
            margin-right: 0.5rem;
            width: 20px;
            height: 20px;
        }
        .form-control {
            border-radius: 10px;
            border-color: #0044cc;
            font-size: 1.1rem;
            padding-left: 2.5rem;
        }
        .btn-primary {
            background-color: #0044cc;
            border-color: #0044cc;
            font-weight: bold;
            text-transform: uppercase;
            padding: 1rem 2rem;
            border-radius: 10px;
            font-size: 1.2rem;
        }
        .btn-primary:hover {
            background-color: #003399;
            border-color: #003399;
        }

    </style>
</head>
<body>
<div class="card">
    <div class="card-header">
        <h2>Personal Autorizado UNIONLAB</h2>
    </div>
    <div class="card-body">
        <% String errorMessage = (String) request.getAttribute("loginError");
            if (errorMessage != null && !errorMessage.isEmpty()) { %>
        <div class="alert alert-danger" role="alert"><%= errorMessage %></div>
        <% } %>
        <form action="loginPersonal" method="POST">
            <input type="hidden" name="csrfToken" value="${csrfToken}" />
            <div class="mb-4">
                <label for="correo" class="form-label">
                    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M20 4H4C2.9 4 2 4.9 2 6V18C2 19.1 2.9 20 4 20H20C21.1 20 22 19.1 22 18V6C22 4.9 21.1 4 20 4ZM20 18H4V8L12 13L20 8V18ZM12 11L4 6H20L12 11Z" fill="#0044cc"/>
                    </svg>
                    Correo Electrónico
                </label>
                <input type="email" class="form-control" id="correo" name="correo" required>
            </div>
            <div class="mb-4">
                <label for="contrasena" class="form-label">
                    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M18 8H17V6C17 3.24 14.76 1 12 1C9.24 1 7 3.24 7 6V8H6C4.9 8 4 8.9 4 10V20C4 21.1 4.9 22 6 22H18C19.1 22 20 21.1 20 20V10C20 8.9 19.1 8 18 8ZM12 17C10.9 17 10 16.1 10 15C10 13.9 10.9 13 12 13C13.1 13 14 13.9 14 15C14 16.1 13.1 17 12 17ZM15 8H9V6C9 4.34 10.34 3 12 3C13.66 3 15 4.34 15 6V8Z" fill="#0044cc"/>
                    </svg>
                    Contraseña
                </label>
                <input type="password" class="form-control" id="contrasena" name="contrasena" required>
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">Iniciar Sesión</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>