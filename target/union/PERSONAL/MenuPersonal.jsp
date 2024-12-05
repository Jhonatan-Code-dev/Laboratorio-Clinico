<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú - Personal Autorizado</title>
    <link rel="icon" href="${pageContext.request.contextPath}/img/Green Brown Minimalist Shield Hand Logo.png" type="image/png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.2/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .sidebar {
            background: linear-gradient(135deg, #0044cc, #002080);
            height: 100vh;
            padding-top: 20px;
            position: fixed;
            width: 260px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            box-shadow: 3px 0 15px rgba(0, 0, 0, 0.2);
            border-radius: 0 20px 20px 0;
        }
        .user-info {
            text-align: center;
            margin-top: 20px;
        }
        .user-info img {
            border-radius: 50%;
            width: 120px;
            height: 120px;
            object-fit: cover;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }
        .user-info h5 {
            color: white;
            margin-top: 10px;
            font-size: 1.3rem;
            font-weight: bold;
        }
        .sidebar .nav-link {
            color: white !important;
            padding: 10px 15px;
            border-radius: 10px;
            transition: background-color 0.3s;
        }
        .sidebar .nav-link:hover {
            background-color: #ffcc00;
            color: #0044cc !important;
        }
        .btn-logout-cerrar {
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #ffcc00, #e6b800);
            width: 100%;
            height: 50px;
            border: none;
            border-radius: 10px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
            color: #333;
            transition: background-color 0.3s;
        }
        .btn-logout-cerrar:hover {
            background-color: #d4a700;
        }
        .content {
            margin-left: 270px;
            padding: 40px;
            background-color: #f8f9fa;
            min-height: 100vh;
            border-radius: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .content h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: #0044cc;
            font-weight: bold;
        }
        .content p {
            font-size: 1.15rem;
            color: #333;
        }
        .section-label {
            display: inline-block;
            background-color: #ffcc00;
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
            color: #0044cc;
            margin-bottom: 15px;
        }
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
                border-radius: 0;
            }
            .content {
                margin-left: 0;
                padding: 20px;
                border-radius: 0;
            }
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="user-info">
        <img src="https://thumbs.dreamstime.com/z/hombre-cient%C3%ADfico-en-laboratorio-ilustraci%C3%B3n-vectorial-con-capa-de-y-gafas-experimento-qu%C3%ADmico-277038242.jpg" alt="Foto de Usuario">
        <h5>${nombre} ${apellido}</h5>
    </div>


    <c:if test="${sessionScope.rol == 'Administrador'}">
        <a class="nav-link" href="registrarPersonal" onclick="loadContent(this.href, event)">
            <i class="bi bi-person-badge-fill"></i> Registrar Personal
        </a>
        <a class="nav-link" href="ListaAnalisisServlet" onclick="loadContent(this.href, event)">
            <i class="bi bi-clipboard-check"></i> Registrar Análisis
        </a>
        <a class="nav-link" href="HistorialPaciente" onclick="loadContent(this.href, event)">
            <i class="bi bi-journal-bookmark-fill"></i> Historial
        </a>
        <a class="nav-link" href="GenerarReporte" onclick="loadContent(this.href, event)">
            <i class="bi bi-file-earmark-bar-graph-fill"></i> Generar Reportes
        </a>
        <a class="nav-link" href="personalInfo" onclick="loadContent(this.href, event)">
            <i class="bi bi-gear-fill"></i> Configuraciones
        </a>
    </c:if>

    <c:if test="${sessionScope.rol == 'Recepcionista'}">
        <a class="nav-link" href="obtenerCitasPendientes" onclick="loadContent(this.href, event)">
            <i class="bi bi-calendar-check-fill"></i> Lista Citas
        </a>
        <a class="nav-link" href="muestras" onclick="loadContent(this.href, event)">
            <i class="bi bi-box-seam"></i> Muestras
        </a>
        <a class="nav-link" href="subir" onclick="loadContent(this.href, event)">
            <i class="bi bi-upload"></i> Subir Resultados
        </a>
        <a class="nav-link" href="ListaPacienteServlet" onclick="loadContent(this.href, event)">
            <i class="bi bi-person-plus-fill"></i> Registrar Paciente
        </a>
        <a class="nav-link" href="HistorialPaciente" onclick="loadContent(this.href, event)">
            <i class="bi bi-journal-bookmark-fill"></i> Historial
        </a>
        <a class="nav-link" href="personalInfo" onclick="loadContent(this.href, event)">
            <i class="bi bi-gear-fill"></i> Configuraciones
        </a>
    </c:if>



    <c:if test="${sessionScope.rol == 'Laboratorista'}">
        <a class="nav-link" href="muestras" onclick="loadContent(this.href, event)">
            <i class="bi bi-box-seam"></i> Muestras
        </a>
        <a class="nav-link" href="subir" onclick="loadContent(this.href, event)">
            <i class="bi bi-upload"></i> Subir Resultados
        </a>
        <a class="nav-link" href="ListaAnalisisServlet" onclick="loadContent(this.href, event)">
            <i class="bi bi-clipboard-check"></i> Registrar Análisis
        </a>
        <a class="nav-link" href="HistorialPaciente" onclick="loadContent(this.href, event)">
            <i class="bi bi-journal-bookmark-fill"></i> Historial
        </a>
        <a class="nav-link" href="personalInfo" onclick="loadContent(this.href, event)">
            <i class="bi bi-gear-fill"></i> Configuraciones
        </a>
    </c:if>


    <div class="p-3">
        <a class="btn-logout-cerrar" href="loginPersonal?action=logout">
            <img src="${pageContext.request.contextPath}/svg/exit.svg" alt="Cerrar Sesión" width="20" height="20" class="me-2">
            Cerrar Sesión
        </a>
    </div>

</div>
<div class="content" id="content">
    <h1>¡Bienvenido al Panel ${nombre} ${apellido}, ${sessionScope.rol} Autorizado de UnionLab!</h1>

    <div class="row mt-4">
        <c:if test="${sessionScope.rol == 'Recepcionista'}">
            <div class="col-md-4 mb-4">
                <a href="ListaPacienteServlet" class="card text-center text-decoration-none shadow-sm rounded" onclick="loadContent(this.href, event)">
                    <div class="card-body">
                        <i class="bi bi-person-plus-fill" style="font-size: 2rem;"></i>
                        <h5 class="card-title mt-3 text-dark">Registrar Paciente</h5>
                        <p class="card-text text-dark">Añadir nuevos pacientes al sistema.</p>
                    </div>
                </a>
            </div>

            <div class="col-md-4 mb-4">
                <a href="obtenerCitasPendientes" class="card text-center text-decoration-none shadow-sm rounded" onclick="loadContent(this.href, event)">
                    <div class="card-body">
                        <i class="bi bi-calendar-check-fill" style="font-size: 2rem;"></i>
                        <h5 class="card-title mt-3 text-dark">Lista Citas</h5>
                        <p class="card-text text-dark">Consulta y gestiona las citas pendientes.</p>
                    </div>
                </a>
            </div>
        </c:if>


        <c:if test="${sessionScope.rol == 'Laboratorista' || sessionScope.rol == 'Recepcionista'}">
            <div class="col-md-4 mb-4"> <a href="muestras" class="card text-center text-decoration-none shadow-sm rounded" onclick="loadContent(this.href, event)"> <div class="card-body"> <i class="bi bi-box-seam" style="font-size: 2rem; color: #007bff;"></i> <h5 class="card-title mt-3 text-dark">Muestras</h5> <p class="card-text text-dark">Gestionar las muestras recogidas.</p> </div> </a> </div>
            <div class="col-md-4 mb-4">
                <a href="subir" class="card text-center text-decoration-none shadow-sm rounded" onclick="loadContent(this.href, event)">
                    <div class="card-body">
                        <i class="bi bi-upload" style="font-size: 2rem;"></i>
                        <h5 class="card-title mt-3 text-dark">Subir Resultados</h5>
                        <p class="card-text text-dark">Subir los resultados de las pruebas.</p>
                    </div>
                </a>
            </div>
            <div class="col-md-4 mb-4">
                <a href="HistorialPaciente" class="card text-center text-decoration-none shadow-sm rounded" onclick="loadContent(this.href, event)">
                    <div class="card-body">
                        <i class="bi bi-archive-fill" style="font-size: 2rem;"></i>
                        <h5 class="card-title mt-3 text-dark">Historial</h5>
                        <p class="card-text text-dark">Consulta el historial de los pacientes.</p>
                    </div>
                </a>
            </div>
        </c:if>


        <c:if test="${sessionScope.rol == 'Laboratorista' || sessionScope.rol == 'Administrador'}">
                <div class="col-md-4 mb-4">
                    <a href="ListaAnalisisServlet" class="card text-center text-decoration-none shadow-sm rounded" onclick="loadContent(this.href, event)">
                        <div class="card-body">
                            <i class="bi bi-clipboard-check" style="font-size: 2rem;"></i>
                            <h5 class="card-title mt-3 text-dark">Registrar Análisis</h5>
                            <p class="card-text text-dark">Registra nuevos análisis en el sistema.</p>
                        </div>
                    </a>
                </div>
        </c:if>



        <c:if test="${sessionScope.rol == 'Administrador'}">
            <div class="col-md-4 mb-4">
                <a href="registrarPersonal" class="card text-center text-decoration-none shadow-sm rounded" onclick="loadContent(this.href, event)">
                    <div class="card-body">
                        <i class="bi bi-person-badge-fill" style="font-size: 2rem;"></i>
                        <h5 class="card-title mt-3 text-dark">Registrar Personal</h5>
                        <p class="card-text text-dark">Añadir nuevos miembros del personal.</p>
                    </div>
                </a>
            </div>
            <div class="col-md-4 mb-4">
                <a href="GenerarReporte" class="card text-center text-decoration-none shadow-sm rounded" onclick="loadContent(this.href, event)">
                    <div class="card-body">
                        <i class="bi bi-file-earmark-bar-graph-fill" style="font-size: 2rem;"></i>
                        <h5 class="card-title mt-3 text-dark">Generar Reportes</h5>
                        <p class="card-text text-dark">Crea y visualiza reportes detallados.</p>
                    </div>
                </a>
            </div>
        </c:if>


        <c:if test="${sessionScope.rol == 'Laboratorista' || sessionScope.rol == 'Administrador' || sessionScope.rol == 'Recepcionista'}">
            <div class="col-md-4 mb-4">
                <a href="personalInfo" class="card text-center text-decoration-none shadow-sm rounded" onclick="loadContent(this.href, event)">
                    <div class="card-body">
                        <i class="bi bi-gear-fill" style="font-size: 2rem;"></i>
                        <h5 class="card-title mt-3 text-dark">Configuraciones</h5>
                        <p class="card-text text-dark">Ajusta las configuraciones del sistema.</p>
                    </div>
                </a>
            </div>
        </c:if>



    </div>
</div>

<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.2/font/bootstrap-icons.min.css" rel="stylesheet">


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function loadContent(page, event) {
        event.preventDefault();
        const contentDiv = document.getElementById('content');
        fetch(page)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Error al cargar el contenido.');
                }
                return response.text();
            })
            .then(html => {
                const tempDiv = document.createElement('div');
                tempDiv.innerHTML = html;
                contentDiv.innerHTML = tempDiv.querySelector('.content') ? tempDiv.querySelector('.content').innerHTML : tempDiv.innerHTML;
                const scripts = tempDiv.querySelectorAll('script');
                scripts.forEach(script => {
                    const newScript = document.createElement('script');
                    if (script.src) {
                        newScript.src = script.src;
                    } else {
                        newScript.text = script.innerHTML;
                    }
                    document.body.appendChild(newScript);
                });
            })
    }

    document.addEventListener('DOMContentLoaded', () => {
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', function(event) {
                loadContent(this.getAttribute('href'), event);
            });
        });
    });
</script>
</body>
</html>
