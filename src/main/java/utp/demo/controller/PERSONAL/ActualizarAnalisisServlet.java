package utp.demo.controller.PERSONAL;

import utp.demo.controller.VALIDADOR.Validaciones;
import utp.demo.DAO.PERSONAL.ActualizarAnalisisDAO;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet(name = "actualizarAnalisisServlet", urlPatterns = {"/actualizarAnalisis"})
public class ActualizarAnalisisServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    // Servlet para actualizar análisis
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            response.setContentType("text/html; charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            String idStr = request.getParameter("id");
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            String disponible = request.getParameter("disponible");
            String duracion = request.getParameter("duracion");
            if ((idStr == null || idStr.trim().isEmpty()) || (nombre == null || nombre.trim().isEmpty()) || (descripcion == null || descripcion.trim().isEmpty()) || (disponible == null || disponible.trim().isEmpty()) || (duracion == null || duracion.trim().isEmpty()) || !Validaciones.validarDisponibilidad(disponible)) {
                out.write("Parámetros no válidos: Por favor verifique los campos nombre, descripción, disponibilidad ('si' o 'no') y duración (HH:MM).");
                return;
            }
            int id = Integer.parseInt(idStr);
            try {
                ActualizarAnalisisDAO.actualizarAnalisis(id, nombre, descripcion, disponible, duracion);
                out.write("Actualización exitosa");
            } catch (SQLException e) {
                out.write("Error en la actualización");
            }
        } catch (Exception e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-ActualizarAnalisisServlet: " + e);
        }
    }
}