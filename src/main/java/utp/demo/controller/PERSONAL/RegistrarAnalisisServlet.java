package utp.demo.controller.PERSONAL;

import utp.demo.DAO.PERSONAL.RegistrarAnalisisDAO;
import org.apache.commons.lang3.StringEscapeUtils;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet(name = "RegistrarAnalisisServlet", urlPatterns = {"/registrarAnalisis"})
public class RegistrarAnalisisServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/plain;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            String duracion = request.getParameter("duracion");
            String disponible = "si";

            if (nombre == null || nombre.trim().isEmpty() || nombre.length() > 30) {
                out.write("Parámetro no válido: El nombre es obligatorio y debe tener como máximo 30 caracteres.");
                return;
            }
            if (descripcion == null || descripcion.trim().isEmpty() || descripcion.length() > 100) {
                out.write("Parámetro no válido: La descripción es obligatoria y debe tener como máximo 100 caracteres.");
                return;
            }
            if (duracion == null || !duracion.matches("^([01]\\d|2[0-3]):[0-5]\\d$")) {
                out.write("Parámetro no válido: La duración debe estar en formato HH:MM (ejemplo: 02:30).");
                return;
            }

            nombre = StringEscapeUtils.escapeHtml4(nombre);
            descripcion = StringEscapeUtils.escapeHtml4(descripcion);
            duracion = StringEscapeUtils.escapeHtml4(duracion);

            try {
                String mensaje = RegistrarAnalisisDAO.registrarAnalisis(nombre, descripcion, disponible, duracion);
                out.write(mensaje);
            } catch (SQLException e) {
                out.write("Error al registrar el análisis: " + e.getMessage());
            }
        } catch (RuntimeException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-RegistrarAnalisisServlet: " + e);
        }
    }
}