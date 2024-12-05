package utp.demo.controller.PERSONAL;

import utp.demo.DAO.PERSONAL.ActualizarEstadoCitaDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.logging.Logger;
@WebServlet("/actualizarEstadoCita")
public class ActualizarEstadoCitaServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String idCitaParam = request.getParameter("idCita");
        String aprobarParam = request.getParameter("aprobar");

        if (idCitaParam != null && aprobarParam != null) {
            try {
                int idCita = Integer.parseInt(idCitaParam);
                boolean aprobar = Boolean.parseBoolean(aprobarParam);
                ActualizarEstadoCitaDAO.cambiarEstadoCita(idCita, aprobar);
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"status\":\"success\"}");
            } catch (NumberFormatException e) {
                logger.warning("Error de formato en idCita: " + idCitaParam);
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Formato de número incorrecto para idCita: " + idCitaParam + "\"}");
            } catch (Exception e) {
                logger.warning("Error al actualizar el estado de la cita: " + e);
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Error al actualizar el estado de la cita.\"}");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Faltan parámetros requeridos. idCita: " + idCitaParam + ", aprobar: " + aprobarParam + "\"}");
        }
    }
}