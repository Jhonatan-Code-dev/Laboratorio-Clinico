<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Historial de Paciente</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>

    body {
      background-color: #f4f6f9;
    }

    .custom-header {
      color: #0044cc;
      padding: 15px;
      font-size: 32px;
      font-weight: bold;
    }

    .table-medical {
      background-color: #ffffff;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      border-radius: 10px;
      overflow: hidden;
      margin: 0 auto;
    }

    .table-medical thead {
      background-color: #0044cc;
      color: white;
    }

    .table-medical th, .table-medical td {
      padding: 12px;
      text-align: center;
    }

    .pdf-viewer {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 80%;
      height: 80%;
      z-index: 1050;
      background: white;
      box-shadow: 0 0 20px rgba(0,0,0,0.3);
      border-radius: 10px;
      display: none;
    }

    .pdf-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0,0,0,0.5);
      z-index: 1040;
      display: none;
    }

    .table-medical tbody tr:hover {
      background-color: #f0f4ff;
      transition: background-color 0.3s ease;
    }
  </style>
</head>
<body>
<div class="container mt-5">
  <h1 class="text-center custom-header mb-4">Buscar Historial de Paciente</h1>
  <div class="row justify-content-center">
    <div class="col-md-6">
      <form onsubmit="event.preventDefault(); obtenerHistorial();" class="mb-4">
        <div class="input-group">
          <input type="text" id="dni" class="form-control" placeholder="Ingrese DNI del paciente" required maxlength="8">
          <button type="submit" class="btn btn-primary" style="background-color: #0044cc; border-color: #0044cc;">
            Buscar
          </button>
        </div>
      </form>
    </div>
  </div>

  <div id="resultados" class="text-center mb-3"></div>

  <div class="table-responsive">
    <table class="table table-hover table-medical">
      <thead>
      <tr>
        <th>FECHA CITA</th>
        <th>FECHA MUESTRA</th>
        <th>FECHA SUBIDA RESULTADOS</th>
        <th>NOMBRE ANÁLISIS</th>
        <th>ACCIONES</th>
      </tr>
      </thead>
      <tbody id="tablaHistorial">
      </tbody>
    </table>
  </div>
</div>
<div id="pdfOverlay" class="pdf-overlay"></div>
<div id="pdfViewer" class="pdf-viewer">
  <div class="d-flex justify-content-between p-3 bg-light">
    <h5 class="m-0">Vista Previa de Documento</h5>
    <button onclick="cerrarPDF()" class="btn btn-danger btn-sm">Cerrar</button>
  </div>
  <iframe id="visorPDF" style="width: 100%; height: calc(100% - 60px); border: none;"></iframe>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function validarDni() {
    var dni = document.getElementById("dni").value;
    var dniRegex = /^[0-9]{8}$/;
    if (!dniRegex.test(dni)) {
      document.getElementById("resultados").innerHTML = `<div class="alert alert-danger">El DNI debe tener 8 dígitos y solo números.</div>`;
      return false;
    }
    document.getElementById("resultados").innerHTML = '';
    return true;
  }

  async function obtenerHistorial() {
    var dni = document.getElementById("dni").value;

    if (!validarDni()) {
      return;
    }

    try {
      let response = await fetch('HistorialPaciente?dni=' + dni, {
        method: 'GET',
        headers: {
          'Content-Type': 'text/plain'
        }
      });

      let data = await response.text();
      document.getElementById("tablaHistorial").innerHTML = '';

      if (data.includes("No se encontraron resultados") || data.includes("Error al obtener el historial")) {
        document.getElementById("resultados").innerHTML = `<div class="alert alert-danger">${data}</div>`;
      } else {
        var rows = data.split("\n");
        rows.forEach(row => {
          if (row.trim()) {
            var cells = row.split(",");
            var tableRow = document.createElement("tr");

            cells.forEach((cell, index) => {
              var tableCell = document.createElement("td");

              if (index === cells.length - 1) {
                tableCell.innerHTML = cell;
              } else {
                tableCell.textContent = cell;
              }

              tableRow.appendChild(tableCell);
            });

            document.getElementById("tablaHistorial").appendChild(tableRow);
          }
        });
      }

    } catch (error) {
      document.getElementById("resultados").innerHTML = `<div class="alert alert-danger">Error al obtener los datos: ${error.message}</div>`;
    }
  }

  function verPDF(url) {
    const pdfViewer = document.getElementById("pdfViewer");
    const pdfOverlay = document.getElementById("pdfOverlay");
    const iframe = document.getElementById("visorPDF");

    iframe.src = url;
    pdfViewer.style.display = "block";
    pdfOverlay.style.display = "block";
  }

  function cerrarPDF() {
    const pdfViewer = document.getElementById("pdfViewer");
    const pdfOverlay = document.getElementById("pdfOverlay");
    const iframe = document.getElementById("visorPDF");

    iframe.src = '';
    pdfViewer.style.display = "none";
    pdfOverlay.style.display = "none";
  }
</script>

</body>
</html>
