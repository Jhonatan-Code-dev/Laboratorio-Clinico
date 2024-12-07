package utp.demo.controller.PERSONAL;

import utp.demo.DAO.PERSONAL.CambiarEstadoCitaMuestraAnalisisDAO;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/cambiarEstadoAnalisis")
public class CambiarEstadoCitaMuestraAnalisisServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    private final CambiarEstadoCitaMuestraAnalisisDAO cambiarEstadoDAO = new CambiarEstadoCitaMuestraAnalisisDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int idCita = Integer.parseInt(request.getParameter("idCita"));
            int idAnalisis = Integer.parseInt(request.getParameter("idAnalisis").trim());
            String nuevoEstado = request.getParameter("estado");
            cambiarEstadoDAO.cambiarEstadoAnalisis(idCita, idAnalisis, nuevoEstado);
            response.getWriter().write("Estado del análisis actualizado exitosamente");
        } catch (Exception e) {
            response.getWriter().write("Error al actualizar el estado del análisis: " + e.getMessage());
            logger.warning("ERROR EN LA CLASE PERSONAL-CambiarEstadoCitaMuestraAnalisisServlet: " + e);
        }
    }
}