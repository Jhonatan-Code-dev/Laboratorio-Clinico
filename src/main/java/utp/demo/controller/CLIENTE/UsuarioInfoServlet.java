package utp.demo.controller.CLIENTE;

import utp.demo.DAO.CLIENTE.UsuarioInfoDAO;
import org.apache.commons.text.StringEscapeUtils;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet(name = "UsuarioInfoServlet", urlPatterns = {"/usuarioInfo"})
public class UsuarioInfoServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("idCliente") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        int idCliente = (int) session.getAttribute("idCliente");
        try {
            UsuarioInfoDAO usuarioInfoDAO = new UsuarioInfoDAO();
            String[] datosCliente = usuarioInfoDAO.obtenerDatosCliente(idCliente);
            if (datosCliente != null) {
                request.setAttribute("dni", StringEscapeUtils.escapeHtml4(datosCliente[0]));
                request.setAttribute("nombre", StringEscapeUtils.escapeHtml4(datosCliente[1]));
                request.setAttribute("apellido", StringEscapeUtils.escapeHtml4(datosCliente[2]));
                request.setAttribute("fec_nac", StringEscapeUtils.escapeHtml4(datosCliente[3]));
                request.setAttribute("sexo", StringEscapeUtils.escapeHtml4(datosCliente[4]));
                request.setAttribute("telefono", StringEscapeUtils.escapeHtml4(datosCliente[5]));
                request.setAttribute("direccion", StringEscapeUtils.escapeHtml4(datosCliente[6]));
                RequestDispatcher dispatcher = request.getRequestDispatcher("usuarioInfo.jsp");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("error", StringEscapeUtils.escapeHtml4("No se encontraron datos para el cliente."));
                RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
                dispatcher.forward(request, response);
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE CLIENTE-UsuarioInfoServlet: " + e);
            request.setAttribute("error", StringEscapeUtils.escapeHtml4("Error al obtener los datos del cliente: " + e.getMessage()));
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}