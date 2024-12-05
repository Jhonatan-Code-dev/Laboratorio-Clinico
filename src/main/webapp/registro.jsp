<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${pageContext.request.contextPath}/img/Green Brown Minimalist Shield Hand Logo.png" type="image/png">
    <title>Registro UnionLab</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fff;
        }

        .container {
            display: flex;
            height: 100vh;
        }

        .right-panel {
            flex: 1;
            background-color: #0096ad;
            color: white;
            padding: 2rem;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-end;
        }

        .right-panel h1 {
            font-size: 24px;
            display: flex;
            align-items: center;
        }

        .right-panel h1 .logo {
            width: 40px;
            height: auto;
        }

        .right-panel img {
            width: 100%;
            max-width: 400px;
            height: auto;
            margin-bottom: 2rem;
            align-self: center;
        }

        .right-panel p {
            text-align: center;
            font-size: 1.2rem;
            margin-bottom: 2rem;
            width: 100%;
        }

        .left-panel {
            flex: 1;
            background-color: white;
            padding: 2rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .left-panel h2 {
            text-align: center;
        }

        .left-panel .regresar {
            color: #0096ad;
            font-size: 1rem;
            text-decoration: none;
            align-self: flex-start;
            margin-bottom: 10px;
            background-color: #fff;
            border-radius: 5px;
            padding: 10px;
        }

        .login-form {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            max-width: 300px;
            width: 100%;
        }

        label {
            color: #333;
            margin-bottom: 0.5rem;
        }

        input, select {
            width: 100%;
            padding: 0.5rem;
            margin-bottom: 1rem;
            border: 1px solid #c5c4c4;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .error {
            color: red;
            font-size: 0.8rem;
            margin-bottom: 1rem;
            display: block;
        }

        .error-message {
            color: red;
            font-size: 0.8rem;
            margin-bottom: 1rem;
            display: none;
        }

        .valid {
            border-color: green;
        }

        .invalid {
            border-color: red;
        }

        .input-container {
            position: relative;
            width: 100%;
        }

        .input-container input {
            padding-right: 40px;
        }

        .eye-icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            width: 20px;
            height: 20px;
        }

        button {
            padding: 0.5rem 1rem;
            background-color: #0096ad;
            color: white;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 1rem;
            width: 100px;
        }

        button:hover {
            background-color: #007f7f;
        }

        .register-link {
            margin-top: 1rem;
            text-align: center;
        }

        .register-link a {
            color: #0096ad;
            text-decoration: none;
        }

        @media (max-width: 1024px) {
            .container {
                flex-direction: column;
                height: auto;
            }

            .left-panel {
                padding: 1rem;
            }

            .right-panel {
                padding: 1rem;
            }

            .right-panel img {
                width: 100%;
                height: auto;
            }
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                height: auto;
            }

            .left-panel, .right-panel {
                padding: 1rem;
            }

            .right-panel img {
                display: none;
            }

            .right-panel h1 {
                font-size: 18px;
                text-align: center;
            }

            .left-panel h2 {
                font-size: 20px;
            }
        }

        @media (max-width: 468px) {
            .left-panel {
                padding: 0.5rem;
            }
            .right-panel {
                display: none;
            }
            .left-panel h2 {
                font-size: 18px;
            }

            .login-form {
                max-width: 100%;
                padding: 0.5rem;
            }

            input, button {
                width: 100%;
            }

            label {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="left-panel">
        <div class="login-form">
            <a class="regresar" href="inicio.jsp">Regresar</a>
            <h2>Regístrate</h2>

            <form action="registro" method="post" onsubmit="return validarFormulario(event)">
                <label for="correo">Correo Electrónico:</label>
                <input type="email" id="correo" name="correo" required maxlength="40" oninput="validarCorreo()" placeholder="Ingrese su correo electrónico" />
                <div id="correoError" class="error"></div>

                <label for="contrasena">Contraseña:</label>
                <div class="password-container">
                    <input type="password" id="contrasena" name="contrasena" required minlength="4" maxlength="8" oninput="validarContrasena()" placeholder="Ingrese su contraseña" />
                </div>
                <div id="contrasenaError" class="error"></div>

                <label for="dni">DNI:</label>
                <input type="text" id="dni" name="dni" required maxlength="8" oninput="validarDNI()" placeholder="Ingrese su DNI" />
                <div id="dniError" class="error"></div>

                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" name="nombre" required maxlength="30" oninput="validarNombre()" placeholder="Ingrese su nombre" />
                <div id="nombreError" class="error"></div>

                <label for="apellido">Apellido:</label>
                <input type="text" id="apellido" name="apellido" required maxlength="30" oninput="validarApellido()" placeholder="Ingrese su apellido" />
                <div id="apellidoError" class="error"></div>

                <label for="fecNac">Fecha de Nacimiento:</label>
                <input type="date" id="fecNac" name="fecNac" required oninput="validarFechaNacimiento()" />
                <div id="fecNacError" class="error"></div>

                <label for="sexo">Sexo:</label>
                <select id="sexo" name="sexo" required onchange="validarSexo()">
                    <option value="">Seleccione una opción</option>
                    <option value="M">Masculino</option>
                    <option value="F">Femenino</option>
                </select>
                <div id="sexoError" class="error"></div>

                <button type="submit">Registrar Paciente</button>
            </form>
            <div class="register-link">
                <p>¿Ya tienes cuenta? <a href="login">Inicia sesión</a></p>
            </div>
        </div>
    </div>
    <div class="right-panel">
        <h1>
            <img class="logo" src="${pageContext.request.contextPath}/img/Green Brown Minimalist Shield Hand Logo.png" alt="">UnionLab
        </h1>
        <img src="${pageContext.request.contextPath}/img/imagenregistro.png" alt="">
        <p>
            <span style="color:white">Agenda tus análisis médicos y revisa tus resultados de la <br> manera</span>
            <span style="color:blue">más simple y rápida</span>
        </p>
    </div>
</div>

<script>
    function validarFechaNacimiento() {
        const fecNacInput = document.getElementById("fecNac");
        const fecNacValue = new Date(fecNacInput.value);
        const errorMessage = document.getElementById("fecNacError");
        if (isNaN(fecNacValue.getTime())) {
            errorMessage.textContent = "La fecha de nacimiento es obligatoria.";
            fecNacInput.classList.remove("valid");
            return false;
        }
        const today = new Date();
        const todayInPeru = new Date(today.toLocaleString("en-US", { timeZone: "America/Lima" }));
        fecNacValue.setHours(0, 0, 0, 0);
        todayInPeru.setHours(0, 0, 0, 0);
        if (fecNacValue >= todayInPeru) {
            errorMessage.textContent = `Fecha Invalida.`;
            fecNacInput.classList.remove("valid");
            return false;
        } else {
            errorMessage.textContent = "";
            fecNacInput.classList.add("valid");
            return true;
        }
    }

    async function validarCorreo() {
        const correoInput = document.getElementById("correo");
        const correoValue = correoInput.value;
        const errorMessage = document.getElementById("correoError");
        if (correoValue.trim() === "") {
            errorMessage.textContent = "El correo no puede estar vacío.";
            correoInput.classList.remove("valid");
            return false;
        }
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(correoValue) || correoValue.length > 40) {
            errorMessage.textContent = "Ingrese un correo electrónico válido con menos de 40 caracteres.";
            correoInput.classList.remove("valid");
            return false;
        }
        try {
            const response = await fetch('validar?correo=' + encodeURIComponent(correoValue));
            const result = await response.text();
            const [dniRegistrado, dniAsociado, correoRegistrado] = result.split(',').map(val => val.trim() === 'true');
            if (correoRegistrado) {
                errorMessage.textContent = "El correo ya está registrado.";
                correoInput.classList.remove("valid");
                return false;
            } else {
                errorMessage.textContent = "";
                correoInput.classList.add("valid");
                return true;
            }
        } catch (error) {
            console.error('Error:', error);
            errorMessage.textContent = "Error al validar el correo.";
            correoInput.classList.remove("valid");
            return false;
        }
    }

    async function validarDNI() {
        const dniInput = document.getElementById("dni");
        const dniValue = dniInput.value;
        const errorMessage = document.getElementById("dniError");
        if (!/^\d{8}$/.test(dniValue)) {
            errorMessage.textContent = "El DNI debe tener 8 dígitos.";
            dniInput.classList.remove("valid");
            return false;
        }

        try {
            const response = await fetch('validar?dni=' + encodeURIComponent(dniValue));
            const result = await response.text();
            const [dniRegistrado, dniAsociado, correoRegistrado] = result.split(',').map(val => val.trim() === 'true');
            if (dniAsociado) {
                errorMessage.textContent = "DNI ya asociado a otra cuenta.";
                dniInput.classList.remove("valid");
                return false;
            } else {
                errorMessage.textContent = "";
                dniInput.classList.add("valid");
                return true;
            }
        } catch (error) {
            console.error('Error:', error);
            errorMessage.textContent = "Error al validar el DNI.";
            dniInput.classList.remove("valid");
            return false;
        }
    }

    function validarCampoTexto(inputValue, errorElementId, fieldName) {
        const errorMessage = document.getElementById(errorElementId);
        if (inputValue.trim() === "") {
            errorMessage.textContent = `El ${fieldName} no puede estar vacío.`;
            return false;
        }
        if (!/^[\p{L} ]+$/u.test(inputValue) || inputValue.length > 30) {
            errorMessage.textContent = `El ${fieldName} no puede contener números, símbolos o tener más de 30 caracteres.`;
            return false;
        }
        errorMessage.textContent = "";
        return true;
    }

    function validarNombre() {
        const nombreInput = document.getElementById("nombre");
        const esNombreValido = validarCampoTexto(nombreInput.value, "nombreError", "nombre");
        nombreInput.classList.toggle("valid", esNombreValido);
        return esNombreValido;
    }

    function validarApellido() {
        const apellidoInput = document.getElementById("apellido");
        const esApellidoValido = validarCampoTexto(apellidoInput.value, "apellidoError", "apellido");
        apellidoInput.classList.toggle("valid", esApellidoValido);
        return esApellidoValido;
    }

    function validarContrasena() {
        const contrasenaInput = document.getElementById("contrasena");
        const contrasenaValue = contrasenaInput.value;
        const errorMessage = document.getElementById("contrasenaError");
        if (contrasenaValue.trim() === "") {
            errorMessage.textContent = "La contraseña no puede estar vacía.";
            contrasenaInput.classList.remove("valid");
            return false;
        }
        const passwordPattern = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{4,8}$/;
        if (!passwordPattern.test(contrasenaValue)) {
            errorMessage.textContent = "La contraseña debe tener entre 4 y 8 caracteres, al menos una mayúscula, una minúscula y un dígito.";
            contrasenaInput.classList.remove("valid");
            return false;
        }
        errorMessage.textContent = "";
        contrasenaInput.classList.add("valid");
        return true;
    }


    function validarSexo() {
        const sexoInput = document.getElementById("sexo");
        const sexoValue = sexoInput.value;
        const errorMessage = document.getElementById("sexoError");
        if (sexoValue === "") {
            errorMessage.textContent = "Seleccione un sexo.";
            sexoInput.classList.remove("valid");
            return false;
        } else {
            errorMessage.textContent = "";
            sexoInput.classList.add("valid");
            return true;
        }
    }

    async function validarFormulario(event) {
        event.preventDefault();
        const esDNIValido = await validarDNI();
        const esNombreValido = validarNombre();
        const esApellidoValido = validarApellido();
        const esCorreoValido = validarCorreo();
        const esContrasenaValida = validarContrasena();
        const esFechaNacimientoValida = validarFechaNacimiento();
        const esSexoValido = validarSexo();
        if (!esDNIValido || !esNombreValido || !esApellidoValido || !esCorreoValido || !esContrasenaValida || !esFechaNacimientoValida || !esSexoValido) {
            return false;
        }
        event.target.submit();
    }
</script>
</body>
</html>