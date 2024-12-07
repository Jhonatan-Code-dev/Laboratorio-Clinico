<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Paciente - MediConnect</title>
    <link rel="icon" href="/path/to/medical-logo.png" type="image/png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-blue-100: #e6f2ff;
            --primary-blue-200: #b3d9ff;
            --primary-blue-300: #80c1ff;
            --primary-blue-400: #4da8ff;
            --primary-blue-500: #1a8cff;
            --primary-blue-600: #0066cc;
            --primary-blue-700: #004c99;
            --primary-blue-800: #003366;
            --primary-blue-900: #001a33;
            --text-color-light: #f4f6f9;
            --text-color-dark: #333;
            --background-light: #f4f6f7;
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Roboto', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--primary-blue-100);
            color: var(--text-color-dark);
            line-height: 1.6;
        }
        .dashboard-container {
            display: flex;
            min-height: 100vh;
            position: relative;
        }
        .sidebar {
            position: fixed;
            width: 300px;
            height: 100vh;
            background: linear-gradient(135deg, var(--primary-blue-700), var(--primary-blue-900));
            color: white;
            padding: 30px 20px;
            display: flex;
            flex-direction: column;
            box-shadow: 5px 0 15px rgba(0,0,0,0.1);
            z-index: 100;
            top: 0;
        }
        .user-profile {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }
        .user-profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--primary-blue-400);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
            transition: transform 0.3s ease;
            background-color: var(--primary-blue-200);
            color: var(--primary-blue-700);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
        }
        .user-profile-image i {
            font-size: 5rem;
        }
        .user-profile-image:hover {
            transform: scale(1.05);
        }
        .user-name {
            margin-top: 15px;
            font-size: 1.4rem;
            font-weight: 600;
            color: white;
        }
        .nav-menu {
            flex-grow: 1;
        }
        .nav-menu .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 12px 20px;
            margin-bottom: 10px;
            border-radius: 10px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .nav-menu .nav-link i {
            font-size: 1.2rem;
            width: 30px;
            text-align: center;
        }
        .nav-menu .nav-link:hover, .nav-menu .nav-link.active {
            background-color: var(--primary-blue-500);
            color: white;
            transform: translateX(10px);
        }
        .logout-btn {
            background-color: var(--primary-blue-400);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: background-color 0.3s ease;
            position: absolute;
            bottom: 30px;
            left: 20px;
            right: 20px;
        }
        .logout-btn:hover {
            background-color: var(--primary-blue-600);
        }
        .content-area {
            margin-left: 300px;
            flex-grow: 1;
            padding: 40px;
            background-color: var(--primary-blue-100);
            overflow-y: auto;
            height: 100vh;
        }
        .dashboard-header h1 {
            color: var(--primary-blue-800);
            font-weight: 700;
            font-size: 2.5rem;
        }
        .welcome-message {
            background: linear-gradient(135deg, var(--primary-blue-500), var(--primary-blue-700));
            color: white;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .welcome-message h2 {
            margin-bottom: 10px;
            font-size: 1.8rem;
        }
        .quick-stats {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background-color: white;
            border-radius: 15px;
            padding: 20px;
            flex-grow: 1;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 20px;
            transition: transform 0.3s ease;
            border: 1px solid var(--primary-blue-200);
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 25px rgba(0,0,0,0.15);
        }
        .stat-card i {
            font-size: 2.5rem;
            color: var(--primary-blue-600);
        }
        .stat-card-content h3 {
            font-size: 1.2rem;
            color: var(--primary-blue-800);
            margin-bottom: 5px;
        }
        .stat-card-content p {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-blue-900);
        }
        .recent-activity h2 {
            color: var(--primary-blue-800);
            border-bottom: 2px solid var(--primary-blue-300);
            padding-bottom: 10px;
            margin-bottom: 15px;
        }
        @media (max-width: 768px) {
            .dashboard-container {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            .content-area {
                margin-left: 0;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="user-profile">
            <div class="user-profile-image">
                <i class="fas fa-user"></i>
            </div>
            <div class="user-name">${nombre} ${apellido}</div>
        </div>
        <nav class="nav-menu">
            <a href="mostrarAnalisisDisponibles" class="nav-link" onclick="loadContent(this.href, event)">
                <i class="fas fa-calendar-check"></i> Mis Citas
            </a>
            <a href="HistorialUsuario" class="nav-link" onclick="loadContent(this.href, event)">
                <i class="fas fa-notes-medical"></i> Historial Médico
            </a>
            <a href="usuarioInfo" class="nav-link" onclick="loadContent(this.href, event)">
                <i class="fas fa-cog"></i> Info
            </a>
        </nav>
        <a href="login?action=logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
        </a>
    </div>
    <div class="content-area" id="content">
        <div class="welcome-message">
            <h2>¡Bienvenido, ${nombre}!</h2>
            <p>Aquí puedes gestionar tu información médica, ver tus próximas citas y consultar tu historial médico.</p>
        </div>
        <div class="quick-stats">
            <div class="stat-card">
                <i class="fas fa-calendar-alt"></i>
                <div class="stat-card-content">
                    <h3>Mis Citas</h3>
                    <p>${numeroCitas} Citas</p>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-file-medical"></i>
                <div class="stat-card-content">
                    <h3>Historial Médico</h3>
                    <p>${registrosMedicos} Registros</p>
                </div>
            </div>
        </div>
    </div>
</div>

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
            .catch(error => {
                console.error('Error:', error);
                contentDiv.innerHTML = `<div class="alert alert-danger">Error al cargar el contenido. Intente nuevamente.</div>`;
            });
    }
    document.addEventListener('DOMContentLoaded', () => {
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', function(event) {
                document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
                this.classList.add('active');
            });
        });
        document.querySelectorAll('.stat-card').forEach(card => {
            card.addEventListener('click', function() {
                const href = this.getAttribute('onclick').match(/'([^']*)'/)[1];
                window.location.href = href;
            });
        });
    });
</script>
</body>
</html>