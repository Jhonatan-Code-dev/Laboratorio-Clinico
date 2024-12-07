package utp.demo.controller.PERSONAL;

import utp.demo.DAO.PERSONAL.CitasMuestrasDAO;
import utp.demo.model.CitaAprobada;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/muestras")
public class CitasMuestrasServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            CitasMuestrasDAO citasDAO = new CitasMuestrasDAO();
            List<CitaAprobada> citasAprobadas = citasDAO.obtenerCitasAprobadas();
            request.setAttribute("citasAprobadas", citasAprobadas);
            request.getRequestDispatcher("/PERSONAL/RecolectarMuestra.jsp").forward(request, response);
        }catch (Exception e){
            logger.warning("ERROR EN LA CLASE PERSONAL-CitasMuestrasServlet: " + e);
        }
    }
}