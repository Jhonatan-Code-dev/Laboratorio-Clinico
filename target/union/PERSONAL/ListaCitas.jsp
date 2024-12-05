<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Citas Pendientes</title>
    <style>
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #0044cc;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        button {
            padding: 8px 12px;
            margin: 2px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button.aprobar {
            background-color: #0044cc;
            color: white;
        }
        button.no-aprobar {
            background-color: #dc3545;
            color: white;
        }
        button:hover {
            opacity: 0.8;
        }
        .message {
            text-align: center;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid transparent;
            border-radius: 4px;
            display: none;
        }
        .success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .error {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
    </style>
</head>
<body>
<div id="message" class="message"></div>
<table id="citas-table">
    <thead>
    <tr>
        <th>DNI</th>
        <th>Nombre Completo</th>
        <th>ID Cita</th>
        <th>Fecha y Hora</th>
        <th>Estado de la Cita</th>
        <th>Acciones</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="cita" items="${citasPendientes}">
        <tr>
            <td>${cita.dni}</td>
            <td>${cita.nombreCompleto}</td>
            <td>${cita.idCita}</td>
            <td>${cita.fecHora}</td>
            <td>${cita.estadoCita}</td>
            <td>
                <button class="estado-btn aprobar" data-id="${cita.idCita}" data-aprobar="true">Aprobar</button>
                <button class="estado-btn no-aprobar" data-id="${cita.idCita}" data-aprobar="false">No Aprobar</button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<script>
    document.querySelectorAll('.estado-btn').forEach(button => {
        button.addEventListener('click', async function () {
            const idCita = this.getAttribute('data-id');
            const aprobar = this.getAttribute('data-aprobar');
            const params = new URLSearchParams({
                idCita: idCita,
                aprobar: aprobar
            }).toString();
            try {
                const response = await fetch('actualizarEstadoCita?' + params, {
                    method: 'GET'
                });
                const result = await response.json();
                const messageDiv = document.getElementById('message');
                if (result.status === 'success') {
                    messageDiv.textContent = 'Estado de la cita actualizado correctamente.';
                    messageDiv.className = 'message success';
                } else {
                    messageDiv.textContent = 'Error: ' + result.message;
                    messageDiv.className = 'message error';
                }
                messageDiv.style.display = 'block';
                setTimeout(() => {
                    messageDiv.style.display = 'none';
                }, 3000);
            } catch (error) {
                console.error('Error al actualizar el estado de la cita:', error);
                const messageDiv = document.getElementById('message');
                messageDiv.textContent = 'Error al actualizar el estado de la cita.';
                messageDiv.className = 'message error';
                messageDiv.style.display = 'block';
                setTimeout(() => {
                    messageDiv.style.display = 'none';
                }, 3000);
            }
        });
    });
</script>
</body>
</html>