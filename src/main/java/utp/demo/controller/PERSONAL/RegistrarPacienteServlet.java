package utp.demo.controller.PERSONAL;

import utp.demo.DAO.PERSONAL.RegistrarPacienteDAO;
import utp.demo.DAO.CLIENTE.DniExisteDAO;
import utp.demo.controller.VALIDADOR.Validaciones;
import org.apache.commons.lang3.StringEscapeUtils;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.logging.Logger;

@WebServlet(name = "RegistrarPacienteServlet", urlPatterns = {"/registrarPaciente"})
public class RegistrarPacienteServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String dni = request.getParameter("dni");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String fechaNacimiento = request.getParameter("fechaNacimiento");
            String sexo = request.getParameter("sexo");
            String telefono = request.getParameter("telefono");
            String direccion = request.getParameter("direccion");
            String fechaRegistro = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            response.setContentType("text/plain;charset=UTF-8");

            boolean[] verificacion = DniExisteDAO.verificarDniYCorreo(dni, "dni");
            boolean dniNoRegistrado = !verificacion[0];

            boolean isValid = dni != null && Validaciones.validarDNI(dni)
                    && nombre != null && Validaciones.validarNombre(nombre)
                    && apellido != null && Validaciones.validarApellido(apellido)
                    && fechaNacimiento != null && Validaciones.validarFechaNacimiento(fechaNacimiento)
                    && Validaciones.validarSexo(sexo)
                    && (telefono == null || telefono.isEmpty() || Validaciones.validarTelefono(telefono))
                    && dniNoRegistrado;

            if (isValid) {
                nombre = StringEscapeUtils.escapeHtml4(nombre);
                apellido = StringEscapeUtils.escapeHtml4(apellido);
                sexo = StringEscapeUtils.escapeHtml4(sexo);
                telefono = telefono != null ? StringEscapeUtils.escapeHtml4(telefono) : null;
                direccion = direccion != null ? StringEscapeUtils.escapeHtml4(direccion) : null;

                boolean registrado = RegistrarPacienteDAO.registrarPaciente(dni, nombre, apellido, fechaNacimiento, sexo, fechaRegistro, telefono, direccion);
                if (registrado) {
                    response.getWriter().write("Paciente registrado con éxito.");
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Error al registrar paciente.");
                }
            } else {
                String errorMessage = "Datos inválidos o DNI ya registrado: ";
                if (!dniNoRegistrado) {
                    errorMessage += "El DNI ya está registrado.";
                } else {
                    errorMessage += "Revise los datos ingresados.";
                }
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(errorMessage);
            }
        } catch (Exception e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-RegistrarPacienteServlet: " + e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error en el servidor. Intente nuevamente.");
        }
    }
}