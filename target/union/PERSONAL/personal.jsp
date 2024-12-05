<%@ page import="utp.demo.model.Personal" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro Personal</title>
    <link rel="icon" href="${pageContext.request.contextPath}/img/Green Brown Minimalist Shield Hand Logo.png" type="image/png">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.1/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .form-label { font-weight: 500; }
        .error-message {
            top: 1rem;
            font-size: 0.875rem;
            height: 20px;
            display: block;
        }
        .custom-last-row {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            width: 100%;
        }
        .custom-last-row > div { flex: 1; }
        .mensaje-resultado {
            display: none;
            margin-top: 1rem;
        }
    </style>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-12 col-xl-11">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="card-title mb-0">
                        <i class="bi bi-person-plus-fill me-2"></i>
                        Registro de Personal
                    </h4>
                </div>
                <div class="card-body">
                    <form id="personalForm" class="row g-3">
                        <input type="hidden" name="accion" value="registrar">
                        <div class="col-md-4">
                            <label for="idRol" class="form-label">Rol</label>
                            <select id="idRol" name="idRol" class="form-select" required>
                                <option value="">Seleccionar...</option>
                                <option value="1">Administrador</option>
                                <option value="2">Recepcionista</option>
                                <option value="3">Laboratorista</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="dni" class="form-label">DNI</label>
                            <input type="text" class="form-control" id="dni" name="dni" maxlength="8" required
                                   oninput="(() => {
                                       const regex = /^[0-9]{8}$/;
                                       const isValid = regex.test(this.value);
                                       document.getElementById('dniError').textContent =
                                           isValid ? '' : 'El DNI debe tener exactamente 8 dígitos numéricos.';
                                       this.classList.toggle('is-invalid', !isValid);
                                   })()">
                            <span id="dniError" class="error-message text-danger"></span>
                        </div>
                        <div class="col-md-4">
                            <label for="nombre" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" maxlength="30" required
                                   oninput="(() => {
                                       const regex = /^[A-Za-zÑñÁáÉéÍíÓóÚú ]+$/;
                                       const isValid = regex.test(this.value) && this.value.length <= 30;
                                       document.getElementById('nombreError').textContent =
                                           isValid ? '' : 'El nombre solo puede contener letras y no exceder 30 caracteres.';
                                       this.classList.toggle('is-invalid', !isValid);
                                   })()">
                            <span id="nombreError" class="error-message text-danger"></span>
                        </div>

                        <div class="col-md-4">
                            <label for="apellido" class="form-label">Apellido</label>
                            <input type="text" class="form-control" id="apellido" name="apellido" maxlength="30" required
                                   oninput="(() => {
                                       const regex = /^[A-Za-zÑñÁáÉéÍíÓóÚú ]+$/;
                                       const isValid = regex.test(this.value) && this.value.length <= 30;
                                       document.getElementById('apellidoError').textContent =
                                           isValid ? '' : 'El apellido solo puede contener letras y no exceder 30 caracteres.';
                                       this.classList.toggle('is-invalid', !isValid);
                                   })()">
                            <span id="apellidoError" class="error-message text-danger"></span>
                        </div>
                        <div class="col-md-4">
                            <label for="fechaNacimiento" class="form-label">Fecha de Nacimiento</label>
                            <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" required
                                   oninput="(() => {
                                       const today = new Date();
                                       const fechaNac = new Date(this.value);
                                       const isValid = this.value && fechaNac < today;
                                       document.getElementById('fechaNacimientoError').textContent =
                                           isValid ? '' : 'La fecha de nacimiento debe ser anterior a hoy.';
                                       this.classList.toggle('is-invalid', !isValid);
                                   })()">
                            <span id="fechaNacimientoError" class="error-message text-danger"></span>
                        </div>
                        <div class="col-md-4">
                            <label for="sexo" class="form-label">Sexo</label>
                            <select id="sexo" name="sexo" class="form-select" required>
                                <option value="">Seleccionar...</option>
                                <option value="M">Masculino</option>
                                <option value="F">Femenino</option>
                            </select>
                        </div>

                        <div class="col-12">
                            <div class="custom-last-row">
                                <div>
                                    <label for="correo" class="form-label">Correo Electrónico</label>
                                    <input type="email" class="form-control" id="correo" name="correo" maxlength="40" required
                                           oninput="(() => {
                                               const isValid = this.value.length <= 40 && this.value.includes('@');
                                               document.getElementById('correoError').textContent =
                                                   isValid ? '' : 'Ingrese un correo válido que no exceda los 40 caracteres.';
                                               this.classList.toggle('is-invalid', !isValid);
                                           })()">
                                    <span id="correoError" class="error-message text-danger"></span>
                                </div>
                                <div>
                                    <label for="contrasena" class="form-label">Contraseña</label>
                                    <input type="password" class="form-control" id="contrasena" name="contrasena" required>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 text-center mt-4">
                            <button type="submit" class="btn btn-primary px-5">
                                <i class="bi bi-person-plus-fill me-2"></i>
                                Registrar Personal
                            </button>
                        </div>
                    </form>

                    <div id="mensajeExito" class="alert alert-success mensaje-resultado" role="alert"></div>
                    <div id="mensajeError" class="alert alert-danger mensaje-resultado" role="alert"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="mt-5 mb-5">
    <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover text-center" style="max-width: 77%; margin: 0 auto;">
            <thead class="table-dark">
            <tr>
                <th>Rol</th>
                <th>DNI</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Fecha de Nacimiento</th>
                <th>Sexo</th>
                <th>Correo</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% for (Personal personal : (List<Personal>) request.getAttribute("personalList")) { %>
            <tr>
                <td><%= personal.getNombreRol() %></td>
                <td><%= personal.getDni() %></td>
                <td><%= personal.getNombre() %></td>
                <td><%= personal.getApellido() %></td>
                <td><%= personal.getFechaNacimiento() %></td>
                <td><%= personal.getSexo() %></td>
                <td><%= personal.getCorreo() %></td>
                <td>
                    <button type="button" class="btn btn-danger btn-sm" onclick="eliminarPersonal('<%= personal.getDni() %>')">
                        <i class="bi bi-trash-fill"></i> Eliminar
                    </button>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<script>
    async function registerPersonal(event) {
        event.preventDefault();
        console.log("Inicio del registro de personal");

        const dni = document.getElementById('dni').value || '';
        const nombre = document.getElementById('nombre').value || '';
        const apellido = document.getElementById('apellido').value || '';
        const fechaNacimiento = document.getElementById('fechaNacimiento').value || '';
        const sexo = document.getElementById('sexo').value || '';
        const correo = document.getElementById('correo').value || '';
        const contrasena = document.getElementById('contrasena').value || '';
        const idRol = document.getElementById('idRol').value || '';

        const params = new URLSearchParams({
            accion: 'registrar',
            dni: dni,
            nombre: nombre,
            apellido: apellido,
            fechaNacimiento: fechaNacimiento,
            sexo: sexo,
            correo: correo,
            contrasena: contrasena,
            idRol: idRol
        }).toString();

        try {
            const response = await fetch('registrarPersonal?' + params);
            const message = document.getElementById('mensajeExito');
            const errorMessage = document.getElementById('mensajeError');

            if (response.ok) {
                message.textContent = 'Personal registrado con éxito.';
                message.style.display = 'block';
                document.getElementById('dni').value = '';
                document.getElementById('nombre').value = '';
                document.getElementById('apellido').value = '';
                document.getElementById('fechaNacimiento').value = '';
                document.getElementById('sexo').value = '';
                document.getElementById('correo').value = '';
                document.getElementById('contrasena').value = '';
                document.getElementById('idRol').value = '';
                setTimeout(() => {
                    message.style.display = 'none';
                    location.reload();
                }, 2000);
            } else {
                const errorText = await response.text();
                errorMessage.textContent = errorText;
                errorMessage.style.display = 'block';
                setTimeout(() => {
                    errorMessage.style.display = 'none';
                }, 2000);
            }
        } catch (error) {
            const errorMessage = document.getElementById('mensajeError');
            errorMessage.textContent = 'Error al registrar personal.';
            errorMessage.style.display = 'block';
            setTimeout(() => {
                errorMessage.style.display = 'none';
            }, 2000);
        }
    }
    document.getElementById('personalForm').addEventListener('submit', registerPersonal);

    async function eliminarPersonal(dni) {
        try {
            const response = await fetch('registrarPersonal?accion=eliminar&dni=' + dni);

            const resultText = await response.text();
            if (resultText.includes("Personal eliminado exitosamente")) {
                alert('Personal eliminado correctamente');
                location.reload();
            } else {
                alert('Error al eliminar el personal');
            }
        } catch (error) {
            console.error('Error:', error);
            alert('Hubo un error al eliminar el personal.');
        }
    }
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>