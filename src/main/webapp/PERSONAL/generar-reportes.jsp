<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reporte de Citas Aprobadas</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1cmkaF8CAmTkWlMRN9AKA9y5AL2NuaDlh1BrP/A5M5b5FilB0c6pRBTxas5H5eA4F5haJ/OxB5S2t9975nlPJX4aXPX4xeQ5X5F5j5Q81BrP/Akd6eKjtAK5X5b9Y5F1C" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <h1 class="mt-4 mb-4 text-center">Reporte de Citas Aprobadas</h1>
    <div class="mb-4 d-flex justify-content-end">
        <form method="post" action="GenerarReporte">
            <button class="btn btn-success me-2" name="action" value="export_excel">Exportar a Excel</button>
            <button class="btn btn-danger" name="action" value="export_pdf">Exportar a PDF</button>
        </form>
    </div>
    <table class="table table-hover table-bordered table-sm">
        <thead class="table-dark">
        <tr>
            <th scope="col">DNI</th>
            <th scope="col">Nombre Completo</th>
            <th scope="col">Fecha Cita</th>
            <th scope="col">Estado</th>
            <th scope="col">Mes/Año</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="reporte" items="${reportes}">
            <tr>
                <td>${reporte.dni}</td>
                <td>${reporte.nombreCompleto}</td>
                <td>${reporte.fechaCita}</td>
                <td>${reporte.estado}</td>
                <td>${reporte.mesAnio}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha384-KyZXEAg3QhqLMpG8r+e5Knujsl5t5hb7O5L8tSe/MH4N5yj3kb5x5x6x5eRcTr6x4T6zsu7M5P8tM5B5A+8Hw6l6T+z9Q5A4i+xzt5yTtI+Xt6Y5x4b6x6w5E5A+9O6F5oh6J56J5ot9t5e5oj6B4I5p5ye5X5y4w6i2z5w7xxt9F5N5a6N"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js" integrity="sha384-o5A+ni6x5tXyI5b9x4b5XQ5sj5N+fWq9t6T7rTgL+Xx4t5k5z9x5tTt5WPl5vS5kY5lb5Tb5y2rXVo9X2l5x5E5K5I5M5q5Jm5Z5vb5o5T5Q6cBD5Xrw5J5y6B57TL5vR5lZ5xb5g5E5j6c5p5Q9t5n5x5z"></script>
</body>
</html>