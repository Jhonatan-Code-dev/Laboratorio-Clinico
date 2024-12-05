package utp.demo.controller.CLIENTE;

import utp.demo.DAO.CLIENTE.DniExisteDAO;
import java.io.*;
import java.util.logging.Logger;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "validar", urlPatterns = {"/validar"})
public class ValidarDniCorreoServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //SERVLET PARA VALIDAR DNI Y CORREO SI EXISTEN EN LA BASE DE DATOS
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String dni = request.getParameter("dni");
            String correo = request.getParameter("correo");
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            if ((dni != null && !dni.isEmpty()) || (correo != null && !correo.isEmpty())) {
                boolean[] resultados = DniExisteDAO.verificarDniYCorreo(dni != null ? dni : correo, dni != null ? "dni" : "correo");
                String responseText = resultados[0] + "," + resultados[1] + "," + resultados[2];
                response.getWriter().write(responseText);
            } else {
                response.getWriter().write("Por favor, proporciona un DNI o un correo.");
            }
        }catch (Exception e){
            logger.warning("ERROR EN LA CLASE CLIENTE-ValidarDniCorreoServlet: " + e);
        }
    }
}