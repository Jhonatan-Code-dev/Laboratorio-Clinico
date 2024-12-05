package utp.demo.controller.CLIENTE;

import utp.demo.DAO.CLIENTE.UsuarioInfoDAO;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet(name = "MenuServlet", urlPatterns = {"/menuPaciente"})
public class MenuServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //SERVLET PARA MENU PACIENTE
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, IOException {
        try {
            HttpSession session = req.getSession(false);
            if (session != null && session.getAttribute("idCliente") != null) {
                int idCliente = (int) session.getAttribute("idCliente");
                UsuarioInfoDAO usuarioInfoDAO = new UsuarioInfoDAO();
                String[] datosCliente = null;
                try {
                    datosCliente = usuarioInfoDAO.obtenerDatosCliente(idCliente);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                if (datosCliente != null) {
                    req.setAttribute("nombre", datosCliente[1]);
                    req.setAttribute("apellido", datosCliente[2]);
                }
                req.getRequestDispatcher("MenuPaciente.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/login");
            }
        }catch(Exception e) {
            logger.warning("ERROR EN LA CLASE CLIENTE-MenuServlet: " + e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}