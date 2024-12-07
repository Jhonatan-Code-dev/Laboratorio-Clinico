package utp.demo.controller.PERSONAL;

import utp.demo.DAO.PERSONAL.LoginPersonalDAO;
import utp.demo.model.LoginPersonalResult;
import java.io.IOException;
import java.util.UUID;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginPersonalServlet", urlPatterns = {"/loginPersonal"})
public class LoginPersonalServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    // SERVLET PARA VERIFICAR CREDENCIALES DEL PERSONAL Y RUTA
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String csrfToken = UUID.randomUUID().toString();
            HttpSession session = req.getSession(true);
            session.setAttribute("csrfToken", csrfToken);
            req.setAttribute("csrfToken", csrfToken);
            String action = req.getParameter("action");
            if ("logout".equalsIgnoreCase(action)) {
                if (session != null) {
                    session.invalidate();
                }
                resp.sendRedirect(req.getContextPath() + "/loginPersonal");
            } else {
                req.getRequestDispatcher("/PERSONAL/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-LoginPersonalServlet: " + e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String correo = req.getParameter("correo");
        String contrasena = req.getParameter("contrasena");

        String sessionToken = (String) req.getSession().getAttribute("csrfToken");
        String csrToken = req.getParameter("csrfToken");

        if (sessionToken == null || !sessionToken.equals(csrToken)) {
            req.setAttribute("loginError", "Token CSRF inválido.");
            req.getRequestDispatcher("/PERSONAL/login.jsp").forward(req, resp);
            return;
        }

        if (correo == null || contrasena == null) {
            req.setAttribute("loginError", "Correo y contraseña son requeridos.");
            req.getRequestDispatcher("/PERSONAL/login.jsp").forward(req, resp);
            return;
        }
        try {
            LoginPersonalResult result = LoginPersonalDAO.login(correo, contrasena);
            if (result != null) {
                HttpSession session = req.getSession(true);
                session.setAttribute("idPersonal", result.getIdPersonal());
                session.setAttribute("rol", result.getRol());
                resp.sendRedirect(req.getContextPath() + "/menuPersonal");
            } else {
                req.setAttribute("loginError", "Correo o contraseña incorrectos.");
                req.getRequestDispatcher("/PERSONAL/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-LoginPersonalServlet: " + e);
            req.setAttribute("loginError", "Hubo un error en el inicio de sesión. Por favor, intente nuevamente.");
            req.getRequestDispatcher("/PERSONAL/login.jsp").forward(req, resp);
        }
    }
}