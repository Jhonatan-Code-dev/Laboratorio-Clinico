# Sistema de Gestión de Laboratorio Clínico

## Descripción

El sistema de gestión de laboratorio clínico permite a los usuarios reservar citas para análisis específicos, gestionar estas reservas, notificar estados mediante Gmail, controlar errores del sistema mediante auditorías y gestionar resultados de análisis. Todo esto está desarrollado para ejecutarse en un servidor **WildFly**.  

El sistema incluye funcionalidades avanzadas para administrar roles, actualizar disponibilidades, gestionar resultados y auditar errores en tiempo real, brindando una solución integral para laboratorios clínicos.  

---

## Funcionalidades principales

### 1. **Gestión de Citas**
- **Reservas de citas:** Los pacientes pueden reservar citas para análisis clínicos específicos seleccionando fecha, hora y tipo de análisis.
- **Confirmación de citas:** Un encargado revisa las solicitudes y puede aceptarlas o rechazarlas.
- **Notificaciones automáticas:** Se envían correos electrónicos a los pacientes utilizando Gmail para confirmar, rechazar o reprogramar las citas.
- **Actualización de disponibilidad:** Al confirmar o rechazar una cita, el sistema actualiza automáticamente la disponibilidad del laboratorio.

### 2. **Gestión de Resultados**
- **Subida de resultados:** Los encargados pueden subir resultados de análisis en formato PDF.
- **Notificación de resultados:** El sistema envía un correo al paciente notificándole que sus resultados están disponibles.
- **Acceso seguro:** Los pacientes pueden visualizar y descargar sus resultados desde una interfaz segura.

### 3. **Control de Roles y Usuarios**
- **Roles del sistema:**  
  - **Administrador:** Gestiona usuarios, roles y configuración global del sistema.  
  - **Encargado:** Administra citas, análisis y resultados.  
  - **Paciente:** Solicita citas, visualiza resultados y actualiza su información personal.  
- **Gestión de usuarios:** Crear, actualizar y eliminar usuarios con restricciones basadas en su rol.

### 4. **Auditoría del Sistema**
- **Registro de eventos:** El sistema registra actividades críticas, como errores del servidor, cambios en configuraciones o fallos en notificaciones.
- **Notificación de errores:** El administrador recibe notificaciones por correo electrónico cuando ocurren fallos en el sistema.
- **Panel de auditoría:** Interfaz para consultar logs de eventos y errores.

### 5. **Gestión de Análisis**
- **Catálogo de análisis:** Lista de análisis clínicos disponibles con descripción y precio.
- **Actualización de disponibilidad:** Permite agregar, editar o eliminar tipos de análisis.
- **Gestión de horarios:** Configuración de horarios disponibles para cada análisis.

---

## Tecnologías utilizadas

### Backend
- **Lenguaje:** Java
- **Frameworks:** Jakarta EE
- **Servidor de aplicaciones:** WildFly

### Frontend
- **HTML5, CSS3, JavaScript**
- **Framework:** Bootstrap

### Integraciones
- **Correo:** Gmail API para notificaciones automáticas.
- **Auditoría:** Logback y SLF4J para gestión de logs.
