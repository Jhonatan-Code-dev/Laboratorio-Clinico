package utp.demo.controller.PERSONAL;

import utp.demo.DAO.PERSONAL.ListaCitasDAO;
import utp.demo.model.ListaCitas;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Logger;

@WebServlet("/obtenerCitasPendientes")
public class ListaCitasServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //SERVLET PARA MOSTRAR LISTA CITAS
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<ListaCitas> citasPendientes = ListaCitasDAO.obtenerCitasPendientes();
            List<ListaCitas> citasUnicas = eliminarCitasDuplicadas(citasPendientes);
            request.setAttribute("citasPendientes", citasUnicas);
            request.getRequestDispatcher("/PERSONAL/ListaCitas.jsp").forward(request, response);
        }catch (Exception e){
            logger.warning("ERROR EN LA CLASE PERSONAL-ListaCitasServlet: " + e);
        }
    }

    private List<ListaCitas> eliminarCitasDuplicadas(List<ListaCitas> citasPendientes) {
        Set<Integer> idCitasSet = new HashSet<>();
        List<ListaCitas> citasUnicas = new ArrayList<>();
        for (ListaCitas cita : citasPendientes) {
            if (idCitasSet.add(cita.getIdCita())) {
                citasUnicas.add(cita);
            }
        }
        return citasUnicas;
    }
}