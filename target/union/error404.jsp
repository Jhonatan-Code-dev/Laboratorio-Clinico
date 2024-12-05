<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Error 404 | UNIONLAB Clinica</title>
  <link rel="icon" href="${pageContext.request.contextPath}/img/Green Brown Minimalist Shield Hand Logo.png" type="image/png">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css">
  <style>
    body {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      background-color: #f5f5f5;
    }
    .error-container {
      text-align: center;
      max-width: 600px;
      padding: 3rem;
      background-color: #fff;
      border-radius: 20px;
      box-shadow: 0 0 40px rgba(0, 0, 0, 0.1);
    }
    .error-code {
      font-size: 8rem;
      font-weight: bold;
      color: #0044cc;
      margin-bottom: 1rem;
    }
    .error-message {
      font-size: 2rem;
      color: #555;
      margin-bottom: 2rem;
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
    .logo {
      max-width: 150px;
      margin-bottom: 2rem;
    }
    .error-illustration {
      max-width: 300px;
      margin-bottom: 2rem;
    }
  </style>
</head>
<body>
<div class="error-container">
  <img src="${pageContext.request.contextPath}/img/Green Brown Minimalist Shield Hand Logo.png" alt="UNIONLAB Clinica" class="logo">
  <div class="error-code">404</div>
  <div class="error-message">Lo sentimos, la página que buscas no se encuentra.</div>
</div>
</body>
</html>