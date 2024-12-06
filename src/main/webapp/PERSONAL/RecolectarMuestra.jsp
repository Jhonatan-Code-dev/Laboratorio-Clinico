<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>Citas Aprobadas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .align-center {
            text-align: center;
            vertical-align: middle;
        }
        .custom-collapse {
            border-top: 2px solid #dee2e6;
            margin-top: 10px;
            padding-top: 10px;
        }
        .list-group-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .list-group-item span.badge {
            margin-left: auto;
        }
        .collapse-content {
            text-align: left;
        }

        table.table-bordered {
            border: 2px solid #dee2e6;
            border-radius: 10px;
            overflow: hidden;
        }

        table.table-bordered th,
        table.table-bordered td {
            border: 1px solid #dee2e6;
            padding: 12px;
        }
        table.table-bordered thead {
            background-color: #343a40;
            color: #ffffff;
        }
        table.table-bordered tbody tr:hover {
            background-color: #f8f9fa;
        }

        .mensaje-exito {
            display: none;
            padding: 10px;
            margin-top: 20px;
            font-weight: bold;
            text-align: center;
        }
        .mensaje-exito.pendiente {
            background-color: yellow;
        }
        .mensaje-exito.aprobado {
            background-color: green;
            color: white;
        }
        .mensaje-exito.cancelado {
            background-color: red;
            color: white;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4 text-center">Muestras Recolectadas</h1>
    <div id="mensajeExito" class="mensaje-exito"></div>
    <table class="table table-bordered table-striped text-center">
        <thead class="table-dark">
        <tr>
            <th>ID Cliente</th>
            <th>DNI</th>
            <th>Nombre Completo</th>
            <th>ID Cita</th>
            <th>Fecha y Hora</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="cita" items="${citasAprobadas}">
            <tr>
                <td class="align-center">${cita.idCliente}</td>
                <td class="align-center">${cita.dni}</td>
                <td class="align-center">${cita.nombreCompleto}</td>
                <td class="align-center">${cita.idCita}</td>
                <td class="align-center">${cita.fechaHora}</td>
                <td class="align-center">
                    <button class="btn btn-primary btn-sm" type="button" data-bs-toggle="collapse"
                            data-bs-target="#detalle-${cita.idCita}" aria-expanded="false"
                            aria-controls="detalle-${cita.idCita}">
                        Ver Detalles
                    </button>
                </td>
            </tr>
            <tr class="collapse" id="detalle-${cita.idCita}">
                <td colspan="6" class="p-4">
                    <ul class="list-group">
                        <c:forEach var="analisis" items="${fn:split(cita.analisisConId, ',')}" varStatus="status">
                            <li class="list-group-item">
                                <span>${analisis}</span>
                                <span class="badge bg-info text-dark">
                                        ${fn:split(cita.estadosAnalisis, ',')[status.index]}
                                </span>
                                <div class="ms-3">
                                    <button class="btn btn-success btn-sm" type="button"
                                            onclick="cambiarEstadoAnalisis('${cita.idCita}',
                                                    '${fn:split(analisis, ':')[0].trim()}', 'Aprobado')">
                                        Aprobado
                                    </button>

                                    <button class="btn btn-danger btn-sm" type="button"
                                            onclick="cambiarEstadoAnalisis('${cita.idCita}',
                                                    '${fn:split(analisis, ':')[0].trim()}', 'Cancelado')">
                                        Cancelado
                                    </button>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    async function cambiarEstadoAnalisis(idCita, idAnalisis, estado) {
        try {
            const response = await fetch('cambiarEstadoAnalisis', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({
                    'idCita': idCita,
                    'idAnalisis': idAnalisis,
                    'estado': estado
                })
            });
            const result = await response.text();
            const mensajeExito = document.getElementById('mensajeExito');
            mensajeExito.textContent = 'Actualización realizada correctamente.';
            if (estado === 'Pendiente') {
                mensajeExito.className = 'mensaje-exito pendiente';
            } else if (estado === 'Aprobado') {
                mensajeExito.className = 'mensaje-exito aprobado';
            } else if (estado === 'Cancelado') {
                mensajeExito.className = 'mensaje-exito cancelado';
            }
            mensajeExito.style.display = 'block';
        } catch (error) {
            console.error('Error al cambiar el estado:', error);
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>