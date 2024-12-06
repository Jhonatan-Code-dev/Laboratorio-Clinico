<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laboratorio Clínico - Subida de Resultados</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        .titulo-principal {
            text-align: center;
            color: #0044cc;
            margin: 2.5rem 0;
            font-weight: bold;
            font-size: 2.5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        .titulo-principal::after {
            content: '';
            display: block;
            width: 100px;
            height: 4px;
            background: #0044cc;
            margin: 10px auto;
            border-radius: 2px;
        }

        .tabla-resultados {
            width: 100%;
            table-layout: auto;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 2rem;
            box-shadow: 0 8px 16px rgba(0, 68, 204, 0.15);
            background: white;
            border: 1px solid rgba(0, 68, 204, 0.1);
        }

        .tabla-resultados th {
            background: #0044cc;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9rem;
            padding: 1.2rem 1rem;
            letter-spacing: 0.5px;
        }

        .tabla-resultados td {
            padding: 1.2rem 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #e8eaf6;
            transition: all 0.3s ease;
        }

        .btn-subir {
            background: #0044cc;
            color: white;
            border: none;
            padding: 0.7rem 1.2rem;
            border-radius: 8px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
            box-shadow: 0 2px 4px rgba(0, 68, 204, 0.2);
        }

        .btn-subir:hover {
            background: #0033aa;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 68, 204, 0.3);
        }

        .btn-enviar {
            background: #007bff; /* Azul */
            color: white;
            border: none;
            padding: 0.7rem 1.2rem;
            border-radius: 8px;
            display: none;
            font-weight: 500;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .btn-enviar:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }

        .detalle-analisis {
            display: none;
            margin-top: 10px;
            transition: all 0.3s ease-in-out;
            background-color: #f5f6fa;
        }

        .detalle-analisis td {
            border: none;
            padding: 1.2rem;
        }

        .analisis-header {
            background: #e8eaf6;
            font-weight: bold;
            color: #0044cc;
        }

        .estado-listo {
            background-color: #e8f5e9 !important;
            color: #2e7d32 !important;
        }

        .tabla-resultados tr:hover {
            background-color: #f8f9fe;
            cursor: pointer;
            transform: scale(1.002);
            box-shadow: 0 2px 8px rgba(0, 68, 204, 0.1);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            background: linear-gradient(135deg, #ffffff, #f5f6fa);
            border-radius: 20px;
            box-shadow: 0 10px 20px rgba(0, 68, 204, 0.1);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .tabla-resultados tbody tr {
            animation: fadeIn 0.5s ease-out forwards;
        }

        #mensaje {
            padding: 15px;
            font-size: 1rem;
            font-weight: bold;
            border-radius: 5px;
            max-width: 400px;
            width: 100%;
            margin: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            transition: opacity 0.5s ease;
        }

        #mensaje.success {
            background-color: #28a745;
            color: white;
        }

        #mensaje.error {
            background-color: #dc3545;
            color: white;
        }

    </style>
</head>
<body>
<div class="container mt-4">
    <h2 class="titulo-principal">
        Subir Resultados
    </h2>
    <div id="mensaje" class="alert" style="display: none; position: fixed; top: 10px; right: 10px; z-index: 9999; transition: all 0.5s ease;">
        <span id="mensaje-text"></span>
    </div>
    <div class="table-responsive">
        <table class="tabla-resultados table table-striped">
            <thead>
            <tr>
                <th>ID Cita</th>
                <th>Nombre Completo</th>
                <th>DNI</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="resultado" items="${resultados}">
                <tr onclick="toggleDetalle(${resultado.idCita})">
                    <td>${resultado.idCita}</td>
                    <td>${resultado.nombreCompleto}</td>
                    <td>${resultado.dniCliente}</td>
                </tr>
                <tr id="detalle-${resultado.idCita}" class="detalle-analisis">
                    <td colspan="4">
                        <table class="table table-bordered">
                            <thead class="analisis-header">
                            <tr>
                                <th>ID Muestra</th>
                                <th>Nombre Análisis</th>
                                <th>Fecha Muestra</th>
                                <th>Estado</th>
                                <th>Acción</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="analisis" items="${resultado.parseAnalisis()}">
                                <tr id="tr-${analisis.idMuestra}" style="background-color: ${analisis.estado == 'Listo' ? '#e8f5e9' : 'transparent'};">
                                    <td style="background-color: ${analisis.estado == 'Listo' ? '#e8f5e9' : 'transparent'}">${analisis.idMuestra}</td>
                                    <td style="background-color: ${analisis.estado == 'Listo' ? '#e8f5e9' : 'transparent'}">${analisis.nombreAnalisis}</td>
                                    <td style="background-color: ${analisis.estado == 'Listo' ? '#e8f5e9' : 'transparent'}">${analisis.fechaMuestra}</td>
                                    <td style="background-color: ${analisis.estado == 'Listo' ? '#e8f5e9' : 'transparent'}">
                                            ${analisis.estado}
                                    </td>
                                    <td style="background-color: ${analisis.estado == 'Listo' ? '#e8f5e9' : 'transparent'};">
                                        <c:if test="${analisis.estado != 'Listo'}">
                                            <input type="file"
                                                   id="input-file-${analisis.idMuestra}"
                                                   accept=".pdf"
                                                   onchange="mostrarBotonEnviar(${resultado.idCita}, ${analisis.idMuestra})"
                                                   onclick="this.value = null">
                                            <button
                                                    class="btn btn-enviar"
                                                    id="btn-enviar-${analisis.idMuestra}"
                                                    onclick="subirArchivo('${resultado.dniCliente}', '${analisis.nombreAnalisis}', ${resultado.idCita}, ${analisis.idMuestra})">
                                                Enviar
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    function toggleDetalle(idCita) {
        var detalle = document.getElementById("detalle-" + idCita);
        detalle.style.display = detalle.style.display === "table-row" ? "none" : "table-row";
    }

    function mostrarMensaje(tipo, mensaje) {
        const mensajeDiv = document.getElementById("mensaje");
        const mensajeText = document.getElementById("mensaje-text");
        mensajeDiv.className = 'alert';
        mensajeText.textContent = mensaje;

        if (tipo === 'exito') {
            mensajeDiv.classList.add('success');
        } else if (tipo === 'error') {
            mensajeDiv.classList.add('error');
        }

        mensajeDiv.style.display = 'block';
        setTimeout(() => {
            mensajeDiv.style.display = 'none';
        }, 3000);
    }


    function mostrarBotonEnviar(idCita, idMuestra) {
        var inputFile = document.getElementById("input-file-" + idMuestra);
        var btnEnviar = document.getElementById("btn-enviar-" + idMuestra);
        var errorMsg = document.getElementById("error-msg-" + idMuestra);
        var archivo = inputFile.files[0];
        if (archivo) {
            var tamañoMaximo = 10 * 1024 * 1024;
            if (archivo.size > tamañoMaximo) {
                if (!errorMsg) {
                    errorMsg = document.createElement("div");
                    errorMsg.id = "error-msg-" + idMuestra;
                    errorMsg.style.color = "red";
                    errorMsg.style.fontSize = "0.9rem";
                    errorMsg.innerText = "El archivo es demasiado grande. El tamaño máximo permitido es 10 MB.";
                    inputFile.parentElement.appendChild(errorMsg);
                }
                btnEnviar.style.display = "none";
            } else if (archivo.type !== 'application/pdf') {
                if (!errorMsg) {
                    errorMsg = document.createElement("div");
                    errorMsg.id = "error-msg-" + idMuestra;
                    errorMsg.style.color = "red";
                    errorMsg.style.fontSize = "0.9rem";
                    errorMsg.innerText = "Por favor, selecciona un archivo PDF.";
                    inputFile.parentElement.appendChild(errorMsg);
                }
                btnEnviar.style.display = "none";
            } else {
                if (errorMsg) {
                    errorMsg.remove();
                }
                btnEnviar.style.display = "inline-block";
            }
        } else {
            btnEnviar.style.display = "none";
        }
    }

    function subirArchivo(dniCliente, nombreAnalisis, idCita, idMuestra) {
        var inputFile = document.getElementById("input-file-" + idMuestra);
        var archivo = inputFile.files[0];

        if (archivo && archivo.type === 'application/pdf') {
            var formData = new FormData();
            formData.append("timestamp", new Date().getTime());
            formData.append("dni", dniCliente.trim());
            formData.append("nombreAnalisis", nombreAnalisis.trim());
            formData.append("idMuestra", idMuestra);
            formData.append("filePart", archivo);

            fetch("subirResultado", {
                method: "POST",
                body: formData,
                headers: {
                    'Cache-Control': 'no-cache, no-store, must-revalidate',
                    'Pragma': 'no-cache',
                    'Expires': '0'
                }
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! Status: ${response.status}`);
                    }
                    return response.text();
                })
                .then(data => {
                    mostrarMensaje('exito', data);
                    if (data.includes("éxito")) {
                        const filaAnalisis = document.getElementById(`tr-${idMuestra}`);
                        if (filaAnalisis) {
                            filaAnalisis.querySelectorAll('td').forEach(td => {
                                td.style.backgroundColor = '#e8f5e9';
                            });
                            const estadoTd = filaAnalisis.children[3];
                            if (estadoTd) {
                                estadoTd.textContent = 'Listo';
                            }
                            const controlsTd = filaAnalisis.children[4];
                            if (controlsTd) {
                                controlsTd.innerHTML = '';
                            }
                        }
                        inputFile.value = '';
                    }
                })
                .catch(error => {
                    mostrarMensaje('error', "Ocurrió un error al enviar el archivo. Verifica tu conexión o inténtalo más tarde.");
                    inputFile.value = '';
                });
        } else {
            mostrarMensaje('error', "Por favor, selecciona un archivo PDF.");
        }
    }
</script>
</body>
</html>