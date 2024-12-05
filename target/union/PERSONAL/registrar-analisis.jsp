<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro y Actualización de Análisis</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        h1 {
            text-align: left;
        }
        .error-message {
            color: red;
            font-size: 0.875em;
            margin-top: 0.25em;
        }
        .success-message {
            margin-top: 10px;
            text-align: center;
            color: green;
            display: none;
        }
        .section-container {
            border: 2px solid white;
            border-radius: 20px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
        }
        .table thead {
            background-color: #0d47a1;
        }
        .table thead th {
            color: white;
        }
        .btn-custom {
            background-color: #0d47a1;
            border: none;
            color: white;
        }
        .btn-custom:hover {
            background-color: #1565c0;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="section-container">
        <h1>Registro de Análisis</h1>
        <form id="analysis-form">
            <div class="row mb-3">
                <div class="col-md-6 col-12">
                    <label for="analysis-name" class="form-label">Nombre del Análisis</label>
                    <input type="text" class="form-control" id="analysis-name" required maxlength="30">
                    <div id="nameError" class="error-message"></div>
                </div>
                <div class="col-md-6 col-12">
                    <label for="description" class="form-label">Descripción</label>
                    <input type="text" class="form-control" id="description" required maxlength="100">
                    <div id="descriptionError" class="error-message"></div>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-12">
                    <label for="analysis-duration" class="form-label">Duración (HH:MM)</label>
                    <input type="time" class="form-control" id="analysis-duration" required>
                    <div id="durationError" class="error-message"></div>
                </div>
            </div>
            <div class="text-center mb-3">
                <button type="button" class="btn btn-custom" id="register-btn">Registrar</button>
            </div>
            <div id="success-message-register" class="success-message"></div>
        </form>
    </div>
    <div class="section-container">
        <h1>Actualizar Análisis</h1>
        <div class="row mb-3">
            <div class="col-md-6 col-12">
                <label for="analysis-name-update" class="form-label">Seleccionar Análisis para Actualizar</label>
                <select class="form-select" id="analysis-name-update">
                    <option value="" disabled selected>Seleccione un análisis...</option>
                    <c:forEach var="analisis" items="${listaAnalisis}">
                        <option value="${analisis.id}"
                                data-descripcion="${analisis.descripcion}"
                                data-disponible="${analisis.disponible}"
                                data-duracion="${analisis.duracion}">
                                ${analisis.nombre}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-6 col-12">
                <label for="availability" class="form-label">Disponibilidad</label>
                <select class="form-select" id="availability">
                    <option value="" disabled selected>Seleccione uno...</option>
                    <option value="si">Sí</option>
                    <option value="no">No</option>
                </select>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-12">
                <label for="description-update" class="form-label">Descripción</label>
                <input type="text" class="form-control" id="description-update" required maxlength="100">
                <div id="descriptionErrorUpdate" class="error-message"></div>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-12">
                <label for="analysis-duration" class="form-label">Duración (HH:MM)</label>
                <input type="time" class="form-control" id="duration-update" required>
                <div id="durationErrorUpdate" class="error-message"></div>
            </div>
        </div>
        <div class="text-center mb-3">
            <button type="button" class="btn btn-custom" id="update-btn">Guardar</button>
        </div>
        <div id="success-message-update" class="success-message">Análisis actualizado con éxito.</div>
    </div>
    <div class="section-container">
        <h2>Lista de Análisis</h2>
        <div class="table-container">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Disponible</th>
                    <th>Duracion</th>
                </tr>
                </thead>
                <tbody id="analysis-table-body">
                <c:forEach var="analisis" items="${listaAnalisis}">
                    <tr>
                        <td>${analisis.id}</td>
                        <td>${analisis.nombre}</td>
                        <td>${analisis.descripcion}</td>
                        <td>${analisis.disponible}</td>
                        <td>${analisis.duracion}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    document.getElementById('update-btn').addEventListener('click', async function () {
        const id = document.getElementById('analysis-name-update').value;
        const nombre = document.getElementById('analysis-name-update').options[document.getElementById('analysis-name-update').selectedIndex].text;
        const descripcion = document.getElementById('description-update').value;
        const disponible = document.getElementById('availability').value;
        const duracion = document.getElementById('duration-update').value;
        const params = new URLSearchParams({
            id: id,
            nombre: nombre,
            descripcion: descripcion,
            disponible: disponible,
            duracion: duracion
        }).toString();
        try {
            const response = await fetch('actualizarAnalisis?' + params, {
                method: 'GET'
            });
            const responseText = await response.text();
            if (responseText.includes("exitosa")) {
                document.getElementById('success-message-update').textContent = responseText;
                document.getElementById('success-message-update').style.display = 'block';
                setTimeout(() => {
                    document.getElementById('success-message-update').style.display = 'none';
                }, 2000);
                document.getElementById('analysis-name-update').selectedIndex = 0;
                document.getElementById('description-update').value = '';
                document.getElementById('availability').selectedIndex = 0;
                document.getElementById('duration-update').value = '';
            } else {
                alert('Error al actualizar el análisis');
            }
        } catch (error) {
            console.error('Error al actualizar el análisis:', error);
        }
    });


    document.getElementById('analysis-name-update').addEventListener('change', function() {
        const selectedOption = this.options[this.selectedIndex];
        document.getElementById('description-update').value = selectedOption.dataset.descripcion;
        document.getElementById('availability').value = selectedOption.dataset.disponible.toLowerCase();
        document.getElementById('duration-update').value = selectedOption.dataset.duracion;
    });

    document.getElementById('register-btn').addEventListener('click', async function() {
        const nombreElement = document.getElementById('analysis-name');
        const descripcionElement = document.getElementById('description');
        const duracionElement = document.getElementById('analysis-duration');
        const nombre = nombreElement.value;
        const descripcion = descripcionElement.value;
        const duracion = duracionElement.value;
        const disponible = "si";
        let valid = true;

        if (nombre.trim() === "" || nombre.length > 30) {
            document.getElementById('nameError').textContent = "Por favor ingrese un nombre válido (máximo 30 caracteres).";
            valid = false;
        } else {
            document.getElementById('nameError').textContent = "";
        }

        if (descripcion.trim() === "" || descripcion.length > 100) {
            document.getElementById('descriptionError').textContent = "Por favor ingrese una descripción válida (máximo 100 caracteres).";
            valid = false;
        } else {
            document.getElementById('descriptionError').textContent = "";
        }

        if (!/^([0-1]\d|2[0-3]):([0-5]\d)$/.test(duracion)) {
            document.getElementById('durationError').textContent = "Por favor ingrese una duración válida en formato HH:MM.";
            valid = false;
        } else {
            document.getElementById('durationError').textContent = "";
        }

        if (!valid) return;
        const params = new URLSearchParams({
            nombre: nombre,
            descripcion: descripcion,
            duracion: duracion,
            disponible: disponible
        }).toString();

        try {
            const response = await fetch('registrarAnalisis?' + params);
            const responseText = await response.text();
            const successMessageElement = document.getElementById('success-message-register');
            if (responseText.includes("éxito")) {
                successMessageElement.textContent = responseText;
                successMessageElement.style.color = 'green';
                successMessageElement.style.display = 'block';
                nombreElement.value = "";
                descripcionElement.value = "";
                duracionElement.value = "";
                setTimeout(() => {
                    successMessageElement.style.display = 'none';
                }, 2000);
            } else if (responseText.includes("ya está registrado")) {
                successMessageElement.textContent = responseText;
                successMessageElement.style.color = 'red';
                successMessageElement.style.display = 'block';
            } else {
                successMessageElement.textContent = "Ocurrió un error inesperado.";
                successMessageElement.style.color = 'red';
                successMessageElement.style.display = 'block';
            }
        } catch (error) {
            console.error('Error al registrar el análisis:', error);
            const successMessageElement = document.getElementById('success-message-register');
            successMessageElement.textContent = "Error al registrar el análisis.";
            successMessageElement.style.color = 'red';
            successMessageElement.style.display = 'block';
        }
    });
</script>
</body>
</html>