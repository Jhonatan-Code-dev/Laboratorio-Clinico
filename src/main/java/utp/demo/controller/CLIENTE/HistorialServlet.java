package utp.demo.controller.CLIENTE;

import utp.demo.DAO.PERSONAL.HistorialPacienteDniDAO;
import utp.demo.model.HistoriaPaciente;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "HistorialServlet", urlPatterns = {"/HistorialUsuario"})
public class HistorialServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            String dni = (session != null) ? (String) session.getAttribute("dniCliente") : null;
            if (dni == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            response.setContentType("text/html;charset=UTF-8");
            List<HistoriaPaciente> historial = new HistorialPacienteDniDAO().obtenerHistorialPorDNI(dni);
            request.setAttribute("historial", historial);
            RequestDispatcher dispatcher = request.getRequestDispatcher("historial.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE CLIENTE-HistorialServlet: " + e);
            request.setAttribute("error", "Error al obtener el historial del paciente: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}