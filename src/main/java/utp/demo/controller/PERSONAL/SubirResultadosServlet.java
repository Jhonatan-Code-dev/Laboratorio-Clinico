package utp.demo.controller.PERSONAL;

import utp.demo.DAO.PERSONAL.SubirResultadosDAO;
import utp.demo.model.ResultadoCita;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/subir")
public class SubirResultadosServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            SubirResultadosDAO subirResultadosDAO = new SubirResultadosDAO() {
                @Override
                protected Connection getConnection() {
                    return null;
                }
            };
            List<ResultadoCita> resultados = subirResultadosDAO.obtenerMuestrasConEstados();
            request.setAttribute("resultados", resultados);
            request.getRequestDispatcher("/PERSONAL/subir-resultados.jsp").forward(request, response);
        }catch (Exception e){
            logger.warning("ERROR EN LA CLASE PERSONAL-SubirResultadosServlet: " + e);
        }
    }
}