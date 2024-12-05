<%@ page import="utp.demo.model.HistoriaPaciente" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary-color: #2c3e50;
      --secondary-color: #003B76;
      --background-light: #f4f6f7;
      --text-color: #2c3e50;
      --border-color: #e0e4e6;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
      overflow: hidden;
    }

    .table-responsive {
      overflow-x: auto;
    }
    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0;
    }

    table th {
      background-color: var(--secondary-color);
      color: white;
      font-weight: 600;
      padding: 15px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      border-bottom: 3px solid var(--primary-color);
    }

    thead tr:first-child th:first-child {
      border-top-left-radius: 8px;
    }

    thead tr:first-child th:last-child {
      border-top-right-radius: 8px;
    }

    table td {
      padding: 15px;
      border-bottom: 1px solid var(--border-color);
      transition: background-color 0.3s ease;
    }

    table tr:nth-child(even) {
      background-color: #f9f9f9;
    }

    table tr:hover {
      background-color: #f0f4f7;
    }

    .action-links {
      display: flex;
      gap: 10px;
      justify-content: center;
    }

    .action-links a {
      text-decoration: none;
      padding: 6px 12px;
      border-radius: 4px;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .action-links a:hover {
      opacity: 0.8;
      transform: translateY(-2px);
    }

    .alert {
      background-color: #007cdc;
      color: white;
      padding: 15px;
      text-align: center;
      border-radius: 8px;
      margin: 20px 0;
      font-weight: 500;
    }

    @media (max-width: 768px) {
      body {
        padding: 10px;
      }

      .container {
        border-radius: 0;
      }

      table, tbody, tr, td {
        display: block;
        width: 100%;
      }

      table thead {
        display: none;
      }

      table tr {
        margin-bottom: 10px;
        border: 1px solid var(--border-color);
        border-radius: 8px;
      }

      table td {
        text-align: right;
        padding-left: 50%;
        position: relative;
        border-bottom: 1px solid var(--border-color);
      }

      table td:before {
        content: attr(data-label);
        position: absolute;
        left: 6px;
        width: 45%;
        padding-right: 10px;
        white-space: nowrap;
        text-align: left;
        font-weight: bold;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <% List<HistoriaPaciente> historial = (List<HistoriaPaciente>) request.getAttribute("historial");
    if (historial == null || historial.isEmpty()) { %>
  <div class='alert'>Aún no cuentas con un historial registrado.</div>
  <% } else { %>
  <div class="table-responsive">
    <table>
      <thead>
      <tr>
        <th>Fecha Cita</th>
        <th>Fecha Muestra</th>
        <th>Fecha Subida Resultados</th>
        <th>Nombre Análisis</th>
        <th>Acciones</th>
      </tr>
      </thead>
      <tbody>
      <% for (HistoriaPaciente historia : historial) {
        String[] analisisArray = historia.getAnalisis().split(";");
        for (String analisis : analisisArray) {
          String[] partes = analisis.split(",");
          if (partes.length == 4) {
            String nombreAnalisis = partes[0].split(":")[1].trim();
            String rutaAnalisis = partes[1].trim();
            String fechaMuestra = partes[2].trim();
            String fechaResultados = partes[3].trim();
            String baseURL = "https://www.unionlab.online/archivos/";
            String urlDescargar = baseURL + sanitizarRuta(rutaAnalisis);

            String enlaceDescargar = generarEnlace(urlDescargar, "Descargar PDF", true); %>
      <tr>
        <td data-label="Fecha Cita"><%= historia.getFechaCita() %></td>
        <td data-label="Fecha Muestra"><%= fechaMuestra %></td>
        <td data-label="Fecha Subida Resultados"><%= fechaResultados %></td>
        <td data-label="Nombre Análisis"><%= nombreAnalisis %></td>
        <td data-label="Acciones" class="action-links"><%= enlaceDescargar %></td>
      </tr>
      <% }
      }
      } %>
      </tbody>
    </table>
  </div>
  <% } %>
</div>

<%!
  private String generarEnlace(String url, String texto, boolean esDescarga) {
    String clase = esDescarga ? "pdf-download" : "pdf-view";
    if (esDescarga) {
      return "<a href='" + url + "' class='" + clase + "' download>" + texto + "</a>";
    } else {
      return "<a href='" + url + "' class='" + clase + "' target='_blank'>" + texto + "</a>";
    }
  }

  private String sanitizarRuta(String ruta) {
    if (ruta == null) {
      return "";
    }
    return ruta.replaceAll("\\s+", "%20");
  }
%>
</body>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const table = document.querySelector("table");
    const rows = Array.from(table.querySelectorAll("tbody tr"));
    rows.sort((rowA, rowB) => {
      const dateA = parseDate(rowA.cells[0].innerText);
      const dateB = parseDate(rowB.cells[0].innerText);
      return dateB - dateA;
    });

    const tbody = table.querySelector("tbody");
    rows.forEach(row => tbody.appendChild(row));
  });

  function parseDate(dateString) {
    const [datePart, timePart] = dateString.split(" ");
    const [year, month, day] = datePart.split("-");
    const [hours, minutes, seconds] = timePart.split(":");
    return new Date(year, month - 1, day, hours, minutes, seconds);
  }
</script>

</html>