<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registro de Paciente</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <style>
    .container {
      max-width: 100%;
      margin-top: 10px;
    }
    h1, h2 {
      text-align: center;
      color: #0056b3;
      margin-bottom: 20px;
    }
    .btn-primary {
      background-color: #0056b3;
      border-color: #0056b3;
    }
    .btn-primary:hover {
      background-color: #004494;
      border-color: #004494;
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
      border-color: #0056b3;
      box-shadow: 0 0 5px rgba(0, 86, 179, 0.2);
    }
    .error-message {
      color: red;
      font-size: 0.875em;
      margin-top: 0.25em;
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
  </style>
</head>
<body>
<div class="container">
  <div class="section-container">
    <h1>Registro de Paciente</h1>
    <form id="registration-form" onsubmit="registerPatient(event)">
      <div class="row mb-3">
        <div class="col-md-4 col-12">
          <label for="dni" class="form-label">DNI</label>
          <input type="text" class="form-control" id="dni" name="dni" required maxlength="8" oninput="validarDNI()">
          <div id="dniError" class="error-message"></div>
        </div>
        <div class="col-md-4 col-12">
          <label for="nombre" class="form-label">Nombre</label>
          <input type="text" class="form-control" id="nombre" name="nombre" required maxlength="30" oninput="validarNombre()">
          <div id="nombreError" class="error-message"></div>
        </div>
        <div class="col-md-4 col-12">
          <label for="apellido" class="form-label">Apellido</label>
          <input type="text" class="form-control" id="apellido" name="apellido" required maxlength="30" oninput="validarApellido()">
          <div id="apellidoError" class="error-message"></div>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-md-6 col-12">
          <label for="fechaNacimiento" class="form-label">Fecha de Nacimiento</label>
          <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" required oninput="validarFechaNacimiento()">
          <div id="fechaNacimientoError" class="error-message"></div>
        </div>
        <div class="col-md-6 col-12">
          <label for="sexo" class="form-label">Sexo</label>
          <select class="form-select" id="sexo" name="sexo" required oninput="validarSexo()">
            <option value="" disabled selected>Seleccione...</option>
            <option value="M">Masculino</option>
            <option value="F">Femenino</option>
          </select>
          <div id="sexoError" class="error-message"></div>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-md-6 col-12">
          <label for="telefono" class="form-label">Teléfono</label>
          <input type="tel" class="form-control" id="telefono" name="telefono" placeholder="Número de teléfono" maxlength="9" oninput="validarTelefono()">
          <div id="telefonoError" class="error-message"></div>
        </div>
        <div class="col-md-6 col-12">
          <label for="direccion" class="form-label">Dirección</label>
          <input type="text" class="form-control" id="direccion" name="direccion" placeholder="Dirección" maxlength="40" oninput="validarDireccion()">
          <div id="direccionError" class="error-message"></div>
        </div>
      </div>
      <div class="text-center">
        <button type="submit" class="btn btn-primary">Registrar</button>
      </div>
      <div id="success-message">Paciente registrado con éxito.</div>
      <div id="error-message">Error al registrar paciente.</div>
    </form>
  </div>
  <div class="section-container">
    <h2>Lista de Pacientes</h2>
    <label for="search-dni"></label>
    <input type="text" class="form-control mb-3" id="search-dni" placeholder="Buscar por DNI" maxlength="8" oninput="buscarPaciente()">
    <div class="table-container">
    <table class="table table-striped">
      <thead>
      <tr>
        <th>DNI</th>
        <th>Nombre</th>
        <th>Apellido</th>
        <th>Fecha de Nacimiento</th>
        <th>Sexo</th>
        <th>Teléfono</th>
        <th>Dirección</th>
      </tr>
      </thead>
      <tbody id="patient-table-body">
      <c:forEach var="paciente" items="${listaPacientes}">
        <tr>
          <td>${paciente.dni}</td>
          <td>${paciente.nombre}</td>
          <td>${paciente.apellido}</td>
          <td>${paciente.fechaNacimiento}</td>
          <td>${paciente.sexo}</td>
          <td>${paciente.telefono}</td>
          <td>${paciente.direccion}</td>
        </tr>
      </c:forEach>
      <tr id="not-found-row" style="display: none;">
        <td colspan="7" class="text-center">No se encontraron resultados</td>
      </tr>
      </tbody>
    </table>
    </div>
  </div>
</div>
<script>
  async function registerPatient(event) {
    event.preventDefault();
    console.log("Inicio del registro de paciente");
    const dni = document.getElementById('dni').value || '';
    const nombre = document.getElementById('nombre').value || '';
    const apellido = document.getElementById('apellido').value || '';
    const fechaNacimiento = document.getElementById('fechaNacimiento').value || '';
    const sexo = document.getElementById('sexo').value || '';
    const telefono = document.getElementById('telefono').value || '';
    const direccion = document.getElementById('direccion').value || '';
    const params = new URLSearchParams({
      dni: dni,
      nombre: nombre,
      apellido: apellido,
      fechaNacimiento: fechaNacimiento,
      sexo: sexo,
      telefono: telefono,
      direccion: direccion
    }).toString();

    try {
      const response = await fetch('registrarPaciente?' + params);
      const message = document.getElementById('success-message');
      if (response.ok) {
        message.textContent = 'Paciente registrado con éxito.';
        message.style.display = 'block';
        document.getElementById('dni').value = '';
        document.getElementById('nombre').value = '';
        document.getElementById('apellido').value = '';
        document.getElementById('fechaNacimiento').value = '';
        document.getElementById('sexo').value = '';
        document.getElementById('telefono').value = '';
        document.getElementById('direccion').value = '';
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
      errorMessage.textContent = 'Error al registrar paciente.';
      errorMessage.style.display = 'block';
      setTimeout(() => {
        errorMessage.style.display = 'none';
      }, 2000);
    }
  }

  async function validarDNI() {
    const dniInput = document.getElementById("dni");
    const dniError = document.getElementById("dniError");
    const pattern = /^\d{8}$/;
    if (dniInput.value.trim() === "") {
      dniError.textContent = "";
      dniInput.classList.remove("error", "valid");
      return false;
    }
    if (!pattern.test(dniInput.value)) {
      dniError.textContent = "El DNI debe ser un número de 8 cifras.";
      dniInput.classList.add("error");
      return false;
    }
    const response = await fetch("validar?dni=" + dniInput.value);
    const text = await response.text();
    const [dniRegistrado] = text.split(',');
    if (dniRegistrado === "true") {
      dniError.textContent = "El DNI ya está registrado.";
      dniInput.classList.add("error");
      return false;
    } else {
      dniError.textContent = "";
      dniInput.classList.remove("error");
      dniInput.classList.add("valid");
      return true;
    }
  }

  function validarCampoTexto(inputValue, errorElementId, fieldName, pattern, maxLength, errorMessageText, opcional = false) {
    const errorMessage = document.getElementById(errorElementId);
    const inputField = document.getElementById(fieldName);
    if (opcional && inputValue.trim() === "") {
      errorMessage.textContent = "";
      inputField.classList.remove("error", "valid");
      return true;
    }
    if (!pattern.test(inputValue) || inputValue.length > maxLength) {
      errorMessage.textContent = errorMessageText;
      inputField.classList.add("error");
      return false;
    }
    errorMessage.textContent = "";
    inputField.classList.remove("error");
    inputField.classList.add("valid");
    return true;
  }

  function validarNombre() {
    const pattern = /^[a-zA-ZÑñÁáÉéÍíÓóÚúÜü\s]{1,30}$/;
    return validarCampoTexto(
            document.getElementById("nombre").value,
            "nombreError",
            "nombre",
            pattern,
            30,
            "El nombre debe contener solo letras y tener un máximo de 30 caracteres."
    );
  }

  function validarApellido() {
    const pattern = /^[a-zA-ZÑñÁáÉéÍíÓóÚúÜü\s]{1,30}$/;
    return validarCampoTexto(
            document.getElementById("apellido").value,
            "apellidoError",
            "apellido",
            pattern,
            30,
            "El apellido debe contener solo letras y tener un máximo de 30 caracteres."
    );
  }

  function validarFechaNacimiento() {
    const fecNacInput = document.getElementById("fechaNacimiento");
    const fecNacValue = fecNacInput.value;
    const errorMessage = document.getElementById("fechaNacimientoError");
    const today = new Date();
    const todayFormatted = today.toISOString().split('T')[0];
    if (!fecNacValue) {
      errorMessage.textContent = "La fecha de nacimiento es obligatoria.";
      fecNacInput.classList.remove("valid");
      fecNacInput.classList.add("error");
      return false;
    } else if (fecNacValue >= todayFormatted) {
      errorMessage.textContent = "La fecha de nacimiento debe ser anterior a hoy.";
      fecNacInput.classList.remove("valid");
      fecNacInput.classList.add("error");
      return false;
    } else {
      errorMessage.textContent = "";
      fecNacInput.classList.remove("error");
      fecNacInput.classList.add("valid");
      return true;
    }
  }

  function validarTelefono() {
    const telefonoInput = document.getElementById("telefono");
    const pattern = /^\d{9}$/;
    if (telefonoInput.value.trim() === "") {
      return true;
    }
    return validarCampoTexto(
            telefonoInput.value,
            "telefonoError",
            "telefono",
            pattern,
            9,
            "El teléfono debe ser un número de 9 cifras.",
            true
    );
  }

  function validarDireccion() {
    const direccionInput = document.getElementById("direccion");
    const pattern = /^(.{1,40})$/;
    if (direccionInput.value.trim() === "") {
      return true;
    }
    return validarCampoTexto(
            direccionInput.value,
            "direccionError",
            "direccion",
            pattern,
            40,
            "La dirección no puede exceder los 40 caracteres.",
            true
    );
  }

  function validarSexo() {
    const sexoSelect = document.getElementById("sexo");
    const errorMessage = document.getElementById("sexoError");
    if (sexoSelect.value === '') {
      errorMessage.textContent = "Seleccione el sexo.";
      sexoSelect.classList.remove("valid");
      sexoSelect.classList.add("error");
      return false;
    } else {
      errorMessage.textContent = "";
      sexoSelect.classList.remove("error");
      sexoSelect.classList.add("valid");
      return true;
    }
  }

  function buscarPaciente() {
    const dniInput = document.getElementById("search-dni").value.trim();
    const patientRows = document.querySelectorAll("#patient-table-body tr");
    const notFoundRow = document.getElementById("not-found-row");

    let found = false;

    if (dniInput.length === 8) {
      patientRows.forEach(row => {
        const dniCell = row.cells[0]?.textContent || '';
        if (dniCell === dniInput) {
          row.style.display = "";
          found = true;
        } else {
          row.style.display = "none";
        }
      });
    } else {
      patientRows.forEach(row => {
        row.style.display = "";
      });
      notFoundRow.style.display = "none";
    }
    if (!found && dniInput.length === 8) {
      notFoundRow.style.display = "";
    } else {
      notFoundRow.style.display = "none";
    }
  }
</script>
</body>
</html>