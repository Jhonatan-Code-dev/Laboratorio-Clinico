package utp.demo.controller.PERSONAL;

import utp.demo.DAO.PERSONAL.PersonalInfoDAO;
import org.apache.commons.lang3.StringEscapeUtils;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet(name = "PersonalInfoServlet", urlPatterns = {"/personalInfo"})
public class PersonalInfoServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(PersonalInfoServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("idPersonal") != null) {
            int idPersonal = (int) session.getAttribute("idPersonal");
            try {
                PersonalInfoDAO personalInfoDAO = new PersonalInfoDAO();
                String[] personalInfo = personalInfoDAO.obtenerInformacionPersonal(idPersonal);
                if (personalInfo != null) {
                    String nombreEscapado = StringEscapeUtils.escapeHtml4(personalInfo[2]);
                    String apellidoEscapado = StringEscapeUtils.escapeHtml4(personalInfo[3]);
                    String fechaNacimientoEscapada = StringEscapeUtils.escapeHtml4(personalInfo[4]);
                    String sexoEscapado = StringEscapeUtils.escapeHtml4(personalInfo[5]);

                    req.setAttribute("idPersonal", personalInfo[0]);
                    req.setAttribute("dni", personalInfo[1]);
                    req.setAttribute("nombre", nombreEscapado);
                    req.setAttribute("apellido", apellidoEscapado);
                    req.setAttribute("fechaNacimiento", fechaNacimientoEscapada);
                    req.setAttribute("sexo", sexoEscapado);

                    req.getRequestDispatcher("/PERSONAL/PersonalInfo.jsp").forward(req, resp);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/login");
                }
            } catch (Exception e) {
                logger.warning("ERROR EN LA CLASE PERSONAL-PersonalInfoServlet: " + e.getMessage());
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}