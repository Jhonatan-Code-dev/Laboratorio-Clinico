<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Información del Usuario</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f4f6f9;
    }
    .card-custom {
      border-radius: 12px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      border: none;
    }
    .card-header {
      background-color: #007bff;
      color: white;
      border-top-left-radius: 12px;
      border-top-right-radius: 12px;
    }
    .card-body {
      border-radius: 12px;
      background-color: #ffffff;
      padding: 2rem;
    }
    .table-responsive {
      border-radius: 12px;
      overflow: hidden;
    }
    table {
      border-radius: 12px;
      width: 100%;
    }
    th {
      background-color: #f0f0f0;
      color: #333333;
      font-weight: bold;
    }
    td {
      background-color: #ffffff;
      color: #333333;
    }
    .alert {
      background-color: #f8d7da;
      color: #721c24;
      border-radius: 8px;
      padding: 1rem;
    }
  </style>
</head>
<body>
<div class="container py-5">
  <div class="row justify-content-center">
    <div class="col-md-8 col-lg-6">
      <div class="card card-custom mb-4">
        <div class="card-header text-center" style="background-color: #013c80;">
          <h2 class="mb-0">Información</h2>
        </div>

        <div class="card-body">
          <% String error = (String) request.getAttribute("error"); %>
          <% if (error != null) { %>
          <div class="alert alert-danger" role="alert">
            <%= error %>
          </div>
          <% } %>

          <%
            String dni = (String) request.getAttribute("dni");
            String nombre = (String) request.getAttribute("nombre");
            String apellido = (String) request.getAttribute("apellido");
            String fec_nac = (String) request.getAttribute("fec_nac");
            String sexo = (String) request.getAttribute("sexo");
            String telefono = (String) request.getAttribute("telefono");
            String direccion = (String) request.getAttribute("direccion");
          %>
          <div class="table-responsive">
            <table class="table table-striped table-bordered">
              <tbody>
              <tr>
                <th class="col-4">DNI</th>
                <td><%= dni != null ? dni : "No disponible" %></td>
              </tr>
              <tr>
                <th>Nombre</th>
                <td><%= nombre != null ? nombre : "No disponible" %></td>
              </tr>
              <tr>
                <th>Apellido</th>
                <td><%= apellido != null ? apellido : "No disponible" %></td>
              </tr>
              <tr>
                <th>Fecha de Nacimiento</th>
                <td><%= fec_nac != null ? fec_nac : "No disponible" %></td>
              </tr>
              <tr>
                <th>Sexo</th>
                <td><%= sexo != null ? sexo : "No disponible" %></td>
              </tr>
              <tr>
                <th>Teléfono</th>
                <td id="telefonoData"><%= telefono != null ? telefono : "No disponible" %></td>
              </tr>
              <tr>
                <th>Dirección</th>
                <td id="direccionData"><%= direccion != null ? direccion : "No disponible" %></td>
              </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>