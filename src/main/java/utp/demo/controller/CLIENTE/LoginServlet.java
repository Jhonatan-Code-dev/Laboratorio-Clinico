package utp.demo.controller.CLIENTE;

import utp.demo.DAO.CLIENTE.LoginDAO;
import utp.demo.DAO.CLIENTE.UsuarioInfoDAO;
import utp.demo.util.ContadorUsuariosActivos;
import java.io.*;
import java.util.logging.Logger;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.util.UUID;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String csrfToken = UUID.randomUUID().toString();
            req.getSession().setAttribute("csrfToken", csrfToken);
            if ("logout".equals(req.getParameter("action"))) {
                req.getSession(false).invalidate();
                ContadorUsuariosActivos.decrementar();
                resp.sendRedirect(req.getContextPath() + "/login");
            } else {
                req.setAttribute("csrfToken", csrfToken);
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            logger.warning("ERROR EN LA CLASE CLIENTE-LoginServlet: " + e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        try {
            String csrfTokenFromRequest = req.getParameter("csrfToken");
            String csrfTokenFromSession = (String) req.getSession().getAttribute("csrfToken");
            if (csrfTokenFromSession == null || !csrfTokenFromSession.equals(csrfTokenFromRequest)) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Token CSRF inválido.");
                return;
            }
            String correo = req.getParameter("correo");
            String contrasena = req.getParameter("contrasena");
            Integer idCliente = LoginDAO.login(correo, contrasena);
            if (idCliente != null) {
                UsuarioInfoDAO usuarioInfoDAO = new UsuarioInfoDAO();
                String[] datosCliente = usuarioInfoDAO.obtenerDatosCliente(idCliente);
                if (datosCliente != null) {
                    HttpSession session = req.getSession(true);
                    session.setAttribute("idCliente", idCliente);
                    ContadorUsuariosActivos.incrementar();
                    session.setAttribute("dniCliente", datosCliente[0]);
                    resp.sendRedirect(req.getContextPath() + "/menuPaciente");
                } else {
                    req.setAttribute("loginError", "No se encontraron los datos del cliente.");
                    req.getRequestDispatcher("login.jsp").forward(req, resp);
                }
            } else {
                req.setAttribute("loginError", "Correo electrónico o contraseña incorrectos.");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            logger.warning("ERROR EN LA CLASE CLIENTE-LoginServlet: " + e);
        }
    }
}