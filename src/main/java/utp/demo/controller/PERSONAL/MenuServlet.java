package utp.demo.controller.PERSONAL;

import utp.demo.DAO.PERSONAL.PersonalInfoDAO;
import org.apache.commons.lang3.StringEscapeUtils;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet(name = "MenuPersonal", urlPatterns = {"/menuPersonal"})
public class MenuServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(MenuServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession sessionPersonal = req.getSession(false);
        if (sessionPersonal != null && sessionPersonal.getAttribute("idPersonal") != null) {
            Integer idPersonal = (Integer) sessionPersonal.getAttribute("idPersonal");
            String rol = (String) sessionPersonal.getAttribute("rol");
            try {
                PersonalInfoDAO personalInfoDAO = new PersonalInfoDAO();
                String[] datosPersonal = personalInfoDAO.obtenerInformacionPersonal(idPersonal);

                if (datosPersonal != null) {
                    String nombreEscapado = StringEscapeUtils.escapeHtml4(datosPersonal[2]);
                    String apellidoEscapado = StringEscapeUtils.escapeHtml4(datosPersonal[3]);

                    req.setAttribute("idPersonal", idPersonal);
                    req.setAttribute("rol", rol);
                    req.setAttribute("nombre", nombreEscapado);
                    req.setAttribute("apellido", apellidoEscapado);

                    req.getRequestDispatcher("/PERSONAL/MenuPersonal.jsp").forward(req, resp);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/loginPersonal");
                }
            } catch (Exception e) {
                logger.warning("ERROR EN LA CLASE PERSONAL-MenuServlet: " + e.getMessage());
                resp.sendRedirect(req.getContextPath() + "/loginPersonal");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/loginPersonal");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}