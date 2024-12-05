<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Historial de Análisis</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-color: #0a2647;
      --secondary-color: #144272;
      --accent-color: #205295;
      --light-accent: #2C74B3;
      --text-light: #ffffff;
    }

    .container {
      margin-top: 40px;
      padding-bottom: 40px;
    }

    .card {
      background: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(10px);
      border: none;
      border-radius: 15px;
      padding: 25px;
      margin-bottom: 30px;
      box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
    }

    h1 {
      margin: 0;
      font-weight: 700;
      color: var(--text-light);
      text-transform: uppercase;
      letter-spacing: 2px;
    }

    .form-control:focus {
      background-color: #ffffff;
      box-shadow: none;
    }

    .btn-primary {
      background-color: var(--light-accent);
      border: none;
      padding: 12px 25px;
      border-radius: 8px;
      font-weight: 600;
      transition: all 0.3s ease;
    }

    .btn-primary:hover {
      background-color: var(--accent-color);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    }

    .table-container {
      background: rgba(255, 255, 255, 0.1);
      border-radius: 15px;
      padding: 20px;
      backdrop-filter: blur(10px);
    }

    .table thead th {
      background-color: var(--accent-color);
      color: var(--text-light);
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 1px;
      border: none;
    }

    .table td, .table th {
      border-color: rgba(255, 255, 255, 0.1);
      vertical-align: middle;
    }

    .btn-action {
      margin: 0 5px;
      padding: 8px 15px;
      border-radius: 6px;
      transition: all 0.3s ease;
    }

    .btn-ver {
      background-color: var(--light-accent);
      color: white;
      border: none;
    }

    .btn-descargar {
      background-color: var(--accent-color);
      color: white;
      border: none;
    }

    .btn-ver:hover, .btn-descargar:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .card {
      animation: fadeIn 0.8s ease-out;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="card">
    <div class="title-container text-center">
      <h1>Historial</h1>
    </div>
    <form id="dniForm" class="mb-4">
      <div class="row justify-content-center">
        <div class="col-md-6">
          <div class="mb-3">
            <div class="input-group">
              <span class="input-group-text"><i class="fas fa-id-card"></i></span>
              <input type="text" class="form-control" id="dni" placeholder="Ingrese DNI" required>
            </div>
          </div>
          <button type="submit" class="btn btn-primary w-100">
            Buscar
          </button>
        </div>
      </div>
    </form>
    <div class="table-container">
      <div class="table-responsive">
        <table class="table">
          <thead>
          <tr>
            <th>Nombre Completo</th>
            <th>Fecha</th>
            <th>Análisis</th>
            <th>Acciones</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>Juan Alberto Pérez Rodríguez</td>
            <td>2024-01-15</td>
            <td>Análisis de Sangre</td>
            <td>
              <button class="btn btn-ver btn-action">
                <i class="fas fa-eye me-1"></i> Ver
              </button>
              <button class="btn btn-descargar btn-action">
                <i class="fas fa-download me-1"></i> Descargar
              </button>
            </td>
          </tr>
          <tr>
            <td>Juan Alberto Pérez Rodríguez</td>
            <td>2024-02-20</td>
            <td>Examen de Orina</td>
            <td>
              <button class="btn btn-ver btn-action">
                <i class="fas fa-eye me-1"></i> Ver
              </button>
              <button class="btn btn-descargar btn-action">
                <i class="fas fa-download me-1"></i> Descargar
              </button>
            </td>
          </tr>
          <tr>
            <td>Juan Alberto Pérez Rodríguez</td>
            <td>2024-03-10</td>
            <td>Radiografía</td>
            <td>
              <button class="btn btn-ver btn-action">
                <i class="fas fa-eye me-1"></i> Ver
              </button>
              <button class="btn btn-descargar btn-action">
                <i class="fas fa-download me-1"></i> Descargar
              </button>
            </td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
<script>
  document.getElementById('dniForm').addEventListener('submit', function(event) {
    event.preventDefault();
    const dni = document.getElementById('dni').value;
    this.reset();
  });
</script>
</body>
</html>
