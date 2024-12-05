package utp.demo.controller.PERSONAL;

import utp.demo.DAO.PERSONAL.ListaAnalisisDAO;
import utp.demo.model.Analisis;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "ListaAnalisisServlet", urlPatterns = {"/ListaAnalisisServlet"})

public class ListaAnalisisServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //SERVLET PARA MOSTRAR LISTA ANALISIS
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");
            List<Analisis> listaAnalisis = ListaAnalisisDAO.obtenerTodosAnalisis();
            request.setAttribute("listaAnalisis", listaAnalisis);
            request.getRequestDispatcher("/PERSONAL/registrar-analisis.jsp").forward(request, response);
        }catch (Exception e){
            logger.warning("ERROR EN LA CLASE PERSONAL-ListaAnalisisServlet: " + e);
        }
    }
}