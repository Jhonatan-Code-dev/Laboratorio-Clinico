package utp.demo.controller.PERSONAL;

import utp.demo.DAO.PERSONAL.ListaAnalisisDAO;
import utp.demo.DAO.PERSONAL.ListaPacienteDAO;
import utp.demo.model.Analisis;
import utp.demo.model.Paciente;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/PruebasAnalisisServlet")
public class PruebasAnalisisServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //SERVLET MOSTRAR LISTA DE PACIENTES Y ANALISIS
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");
            List<Analisis> listaAnalisis = ListaAnalisisDAO.obtenerTodosAnalisis();
            request.setAttribute("listaAnalisis", listaAnalisis);
            List<Paciente> listaPacientes = ListaPacienteDAO.obtenerListaClientes();
            request.setAttribute("listaPacientes", listaPacientes);
            request.getRequestDispatcher("/PERSONAL/ListaCitas.jsp").forward(request, response);
        } catch (Exception e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-PruebasAnalisisServlet: " + e);
        }
    }
}