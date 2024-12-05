<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="${pageContext.request.contextPath}/img/Green Brown Minimalist Shield Hand Logo.png" type="image/png">
  <title>Inicio sesión UnionLab</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #fff;
    }
    .container {
      display: flex;
      height: 100vh;
      flex-direction: row;
    }
    .left-panel {
      flex: 1;
      background-color: #0096ad;
      color: white;
      padding: 2rem;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }
    .left-panel h1 {
      font-size: 24px;
      display: flex;
      align-items: center;
    }

    .left-panel h1 .logo {
      width: 40px;
      height: auto;
    }
    .left-panel img {
      align-self: center;
      margin: 10px;
      padding: 15px;
      width: 450px;
      height: 600px;
    }
    .left-panel p {
      text-align: center;
      font-size: 1.2rem;
      margin-bottom: 2rem;
    }
    .right-panel {
      flex: 1;
      background-color: white;
      padding: 2rem;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    }
    .right-panel h2 {
      text-align: center;
    }
    .right-panel img {
      width: 100%;
      max-width: 400px;
      height: auto;
      align-self: center;
    }
    .regresar {
      position: absolute;
      top: 20px;
      right: 20px;
      color: #0096ad;
      font-size: 1rem;
      text-decoration: none;
      padding: 10px 15px;
      border-radius: 5px;
    }
    .login-form {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      max-width: 300px;
      margin: auto;
    }
    label {
      color: #c5c4c4;
      margin-bottom: 0.5rem;
      margin-top: 0.5rem;
    }
    input {
      width: 100%;
      padding: 0.5rem;
      margin-top: 0.5rem;
      margin-bottom: 1rem;
      border: 1px solid #c5c4c4;
      border-radius: 4px;
      box-sizing: border-box;
    }
    button {
      padding: 0.5rem 1rem;
      background-color: #0096ad;
      color: white;
      border: none;
      border-radius: 20px;
      cursor: pointer;
      transition: background-color 0.3s;
      font-size: 1rem;
      margin: 1rem auto;
      display: block;
    }

    button:hover {
      background-color: #007f7f;
    }

    .register-link {
      margin-top: 1rem;
      text-align: center;
    }

    .register-link a {
      color: #0096ad;
      text-decoration: none;
    }

    @media (max-width: 1024px) {
      .container {
        flex-direction: column;
        height: auto;
      }

      .left-panel {
        padding: 1rem;
      }

      .right-panel {
        padding: 1rem;
      }

      .left-panel img {
        width: 100%;
        height: auto;
      }
    }

    @media (max-width: 768px) {
      .container {
        flex-direction: column;
        height: auto;
      }

      .left-panel {
        display: none;
      }

      .right-panel {
        padding: 1rem;
      }

      .left-panel img,
      .right-panel img {
        display: none;
      }

      .left-panel h1 {
        font-size: 18px;
        text-align: center;
      }

      .right-panel h2 {
        font-size: 20px;
      }
    }

    @media (max-width: 468px) {
      .left-panel, .right-panel {
        padding: 0.5rem;
      }

      .left-panel h1 {
        font-size: 16px;
      }

      .right-panel h2 {
        font-size: 18px;
      }

      .login-form {
        max-width: 100%;
        padding: 0.5rem;
      }

      input, button {
        width: 100%;
      }

      label {
        font-size: 0.9rem;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="left-panel">
    <h1> <img class="logo" src="${pageContext.request.contextPath}/img/Green Brown Minimalist Shield Hand Logo.png" alt="">UnionLab</h1>
    <img src="${pageContext.request.contextPath}/img/imageiniciosesion.png" alt="">
    <p>Gestiona tu salud en un solo lugar <br> Gestiona  tus citas y conoce tus resultados</p>
  </div>
  <div class="right-panel">
    <div class="login-form">
      <a class="regresar" href="${pageContext.request.contextPath}/inicio.jsp">Regresar</a>
      <h2>Inicia sesión</h2>
      <form action="${pageContext.request.contextPath}/login" method="post">
        <input type="hidden" name="csrfToken" value="${csrfToken}" />

        <label for="correo">Correo electrónico</label>
        <input type="email" id="correo" name="correo" placeholder="Ingresa tu correo electrónico" required>

        <label for="contrasena">Contraseña</label>
        <input type="password" id="contrasena" name="contrasena" placeholder="Ingresa tu contraseña" required>

        <button type="submit">Ingresar</button>
      </form>

      <div class="register-link">
        <p>¿No tienes cuenta? <a href="${pageContext.request.contextPath}/registro">Regístrate</a></p>
      </div>
      <c:if test="${not empty loginError}">
        <div style="color: red; text-align: center;">
            ${loginError}
        </div>
      </c:if>
    </div>
  </div>
</div>
</body>
</html>