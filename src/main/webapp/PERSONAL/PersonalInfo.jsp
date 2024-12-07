<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Información Personal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .center-container {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f8f9fa; /* Fondo claro para un contraste limpio */
        }
        .card {
            width: 100%;
            max-width: 500px;
            border-radius: 20px;
            border: 3px solid #003BB8;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .card-header {
            background-color: #003BB8;
            color: white;
            text-align: center;
            padding: 15px;
        }
        .table {
            margin-bottom: 0;
        }
        .table th {
            text-align: right;
            width: 40%;
            background-color: #f0f4f8;
        }
        .table td {
            text-align: left;
        }
    </style>
</head>
<body>
<div class="center-container">
    <div class="card">
        <div class="card-header">
            <h2 class="mb-0">Información Personal</h2>
        </div>
        <div class="card-body p-0">
            <table class="table table-bordered mb-0">
                <tbody>
                <tr>
                    <th>ID Personal</th>
                    <td>${idPersonal}</td>
                </tr>
                <tr>
                    <th>DNI</th>
                    <td>${dni}</td>
                </tr>
                <tr>
                    <th>Nombre</th>
                    <td>${nombre}</td>
                </tr>
                <tr>
                    <th>Apellido</th>
                    <td>${apellido}</td>
                </tr>
                <tr>
                    <th>Fecha de Nacimiento</th>
                    <td>${fechaNacimiento}</td>
                </tr>
                <tr>
                    <th>Sexo</th>
                    <td>${sexo}</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
