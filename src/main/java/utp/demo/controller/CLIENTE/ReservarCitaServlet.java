package utp.demo.controller.CLIENTE;

import utp.demo.controller.VALIDADOR.Validaciones;
import utp.demo.DAO.CLIENTE.ReservarCitaDAO;
import utp.demo.DAO.PERSONAL.ListaAnalisisDAO;
import utp.demo.model.Analisis;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

@WebServlet("/reservarCita")
public class ReservarCitaServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //SERVLET PARA RESERVAR CITA
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                Integer idCliente = (Integer) session.getAttribute("idCliente");
                if (idCliente != null) {
                    List<Analisis> listaAnalisis = ListaAnalisisDAO.obtenerTodosAnalisis();
                    String date = request.getParameter("date");
                    String time = request.getParameter("time");
                    if (!Validaciones.validarFechaCita(date)) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        response.getWriter().write("La fecha de la cita debe ser igual o posterior a la fecha actual.");
                        return;
                    }
                    if (!Validaciones.validarHoraCita(time)) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        response.getWriter().write("La hora de la cita debe estar entre las 07:00 AM y las 04:00 PM.");
                        return;
                    }
                    String fecHora = date + " " + time + ":00";
                    ZonedDateTime now = ZonedDateTime.now(ZoneId.of("America/Lima"));
                    String fecCreacion = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                    String[] selectedAnalysis = request.getParameterValues("analysis[]");
                    String analisisIds = "";

                    if (selectedAnalysis != null) {
                        List<String> selectedIds = Arrays.stream(selectedAnalysis).map(str -> str.split("-")[0]).collect(Collectors.toList());
                        analisisIds = String.join(",", selectedIds);
                    }

                    ReservarCitaDAO.reservarCita(idCliente, fecHora, fecCreacion, analisisIds);
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Cita reservada con éxito.");
                } else {
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    response.getWriter().write("No has iniciado sesión. Por favor, inicia sesión.");
                }
            } else {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("No has iniciado sesión. Por favor, inicia sesión.");
            }

        } catch (Exception e) {
            logger.warning("ERROR EN LA CLASE CLIENTE-ReservarCitaServlet: " + e);
        }
    }
}