<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reserva de Cita</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        .container {
            max-width: 100%;
            margin-top: 10px;
        }
        h1 {
            text-align: center;
            color: #004081;
            margin-bottom: 20px;
        }
        .btn-primary {
            background-color: #004081;
            border-color: #004081;
        }
        .btn-primary:hover {
            background-color: #004081;
            border-color: #004081;
        }
        .section-container {
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        .form-control, .form-select {
            border-radius: 10px;
            padding: 10px;
            border: 1px solid #adb5bd;
            transition: all 0.3s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: #004081;
            box-shadow: 0 0 5px rgba(0, 86, 179, 0.2);
        }
        .error-message {
            color: red;
            font-size: 0.875em;
            margin-top: 0.25em;
        }
        .grid-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 10px;
        }
        .checkbox-group {
            display: flex;
            align-items: center;
        }
        .checkbox-group label {
            margin-left: 5px;
        }
        .table-container {
            overflow-x: auto;
        }
        #success-message, #error-message {
            display: none;
            text-align: center;
            margin-top: 20px;
        }
        #success-message {
            color: green;
        }
        #error-message {
            color: red;
        }

        .table {
            background-color: #f9f9f9;
            border-radius: 10px;
            overflow: hidden;
        }
        .table thead th {
            background-color: #004081;
            color: white;
            text-align: center;
            padding: 10px;
        }
        .table tbody tr:nth-child(odd) {
            background-color: #e9ecef;
        }
        .table tbody tr:hover {
            background-color: #cce5ff;
            cursor: pointer;
        }
        .table tbody td {
            text-align: center;
            padding: 10px;
            border: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="section-container">
        <h1>Reservar Cita</h1>
        <form id="reservation-form" onsubmit="reserveAppointment(event)">
            <div class="row mb-3">
                <div class="col-md-6 col-12">
                    <label for="appointment-date" class="form-label">Fecha de la Cita</label>
                    <input type="date" class="form-control" id="appointment-date" name="date" required oninput="validateAppointmentDate()">
                    <div id="dateError" class="error-message"></div>
                </div>
                <div class="col-md-6 col-12">
                    <label for="appointment-time" class="form-label">Hora de la Cita</label>
                    <input type="time" class="form-control" id="appointment-time" name="time" required oninput="validateAppointmentTime()">
                    <div id="timeError" class="error-message"></div>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-12">
                    <label for="analysis" class="form-label">Seleccione los análisis</label>
                    <div class="grid-container">
                        <c:forEach var="analisis" items="${analisisDisponibles}">
                            <div class="checkbox-group">
                                <input type="checkbox" id="${analisis.id}" name="analysis[]" value="${analisis.id}">
                                <label for="${analisis.id}">${analisis.nombre}</label>
                            </div>
                        </c:forEach>
                    </div>
                    <div id="analysisError" class="error-message"></div>
                </div>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">Reservar</button>
            </div>
            <div id="success-message">Cita reservada con éxito.</div>
            <div id="error-message">Error al reservar cita.</div>
        </form>

        <h1 class="mt-5">Mis Citas</h1>
        <div class="table-container">
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Fecha y Hora</th>
                    <th>Estado</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="cita" items="${citas}">
                    <tr>
                        <td>${cita.fecHora}</td>
                        <td>${cita.estado}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
    function validateAppointmentDate() {
        const dateInput = document.getElementById("appointment-date");
        const dateError = document.getElementById("dateError");
        const appointmentDate = new Date(dateInput.value);
        const peruTimeZone = 'America/Lima';
        const options = { timeZone: peruTimeZone, year: 'numeric', month: '2-digit', day: '2-digit' };
        const peruDateString = new Intl.DateTimeFormat('es-PE', options).format(new Date());
        const [day, month, year] = peruDateString.split("/").map(Number);
        const todayPeru = new Date(year, month - 1, day);
        todayPeru.setHours(0, 0, 0, 0);
        const yesterdayPeru = new Date(todayPeru);
        yesterdayPeru.setDate(todayPeru.getDate() - 1);
        appointmentDate.setHours(0, 0, 0, 0);
        if (appointmentDate.getTime() !== yesterdayPeru.getTime() && appointmentDate < todayPeru) {
            dateError.textContent = "La cita solo puede programarse para el días anteriores a hoy.";
            dateInput.classList.add("error");
            return false;
        }
        dateError.textContent = "";
        dateInput.classList.remove("error");
        dateInput.classList.add("valid");
        return true;
    }

    function validateAppointmentTime() {
        const timeInput = document.getElementById("appointment-time");
        const timeError = document.getElementById("timeError");
        const timeValue = timeInput.value;
        if (timeValue < "07:00" || timeValue > "16:00") {
            timeError.textContent = "La hora de la cita debe estar entre las 7:00 AM y las 4:00 PM.";
            timeInput.classList.add("error");
            return false;
        }
        timeError.textContent = "";
        timeInput.classList.remove("error");
        timeInput.classList.add("valid");
        return true;
    }

    function validateForm() {
        const dateIsValid = validateAppointmentDate();
        const timeIsValid = validateAppointmentTime();
        const analysisIsValid = validateAnalysis();
        return dateIsValid && timeIsValid && analysisIsValid;
    }

    function validateAnalysis() {
        const analysisError = document.getElementById("analysisError");
        const checkedAnalysis = document.querySelectorAll('input[name="analysis[]"]:checked');
        if (checkedAnalysis.length === 0) {
            analysisError.textContent = "Debe seleccionar al menos un análisis.";
            return false;
        }
        analysisError.textContent = "";
        return true;
    }

    async function reserveAppointment(event) {
        event.preventDefault();
        if (!validateForm()) {
            return;
        }
        const date = document.getElementById('appointment-date').value || '';
        const time = document.getElementById('appointment-time').value || '';
        const analysis = [];
        document.querySelectorAll('input[name="analysis[]"]:checked').forEach((checkbox) => {
            analysis.push(checkbox.value);
        });
        const params = new URLSearchParams({
            date: date,
            time: time,
            'analysis[]': analysis.join(',')
        }).toString();
        try {
            const response = await fetch('reservarCita?' + params);
            const message = document.getElementById('success-message');
            if (response.ok) {
                message.textContent = 'Cita reservada con éxito.';
                message.style.display = 'block';
                document.getElementById('appointment-date').value = '';
                document.getElementById('appointment-time').value = '';
                document.querySelectorAll('input[name="analysis[]"]').forEach((checkbox) => {
                    checkbox.checked = false;
                });
                setTimeout(() => {
                    message.style.display = 'none';
                }, 2000);
            } else {
                const errorText = await response.text();
                const errorMessage = document.getElementById('error-message');
                errorMessage.textContent = errorText;
                errorMessage.style.display = 'block';
                setTimeout(() => {
                    errorMessage.style.display = 'none';
                }, 2000);
            }
        } catch (error) {
            const errorMessage = document.getElementById('error-message');
            errorMessage.textContent = 'Error al reservar cita.';
            errorMessage.style.display = 'block';
            setTimeout(() => {
                errorMessage.style.display = 'none';
            }, 2000);
        }
    }
</script>
</body>
</html>