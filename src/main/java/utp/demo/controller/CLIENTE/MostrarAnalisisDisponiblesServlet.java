package utp.demo.controller.CLIENTE;

import utp.demo.DAO.PERSONAL.ListaAnalisisDAO;
import utp.demo.DAO.CLIENTE.MostrarEstadoCitaDAO;
import utp.demo.model.Analisis;
import utp.demo.model.Cita;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

@WebServlet("/mostrarAnalisisDisponibles")
public class MostrarAnalisisDisponiblesServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //SERVLET PARA MOSTRAR ANALISIS DISPONIBLES AL PACIENTE
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Analisis> todosAnalisis = ListaAnalisisDAO.obtenerTodosAnalisis();
            List<Analisis> analisisDisponibles = todosAnalisis.stream().filter(analisis -> "SI".equalsIgnoreCase(analisis.getDisponible())).collect(Collectors.toList());
            request.setAttribute("analisisDisponibles", analisisDisponibles);

            HttpSession session = request.getSession(false);
            if (session != null) {
                Integer clienteId = (Integer) session.getAttribute("idCliente");

                if (clienteId != null) {
                    ZoneId zonaPeru = ZoneId.of("America/Lima");
                    LocalDateTime fechaHoraActual = LocalDateTime.now(zonaPeru);
                    String fechaHora = fechaHoraActual.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                    List<Cita> citas = MostrarEstadoCitaDAO.mostrarCitaPaciente(clienteId, fechaHora);
                    request.setAttribute("citas", citas);
                } else {
                    request.setAttribute("loginError", "No has iniciado sesión. Por favor, inicia sesión.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("loginError", "No has iniciado sesión. Por favor, inicia sesión.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            request.getRequestDispatcher("reservar-cita.jsp").forward(request, response);
        }catch (Exception e){
            logger.warning("ERROR EN LA CLASE CLIENTE-MostrarAnalisisDisponiblesServlet: " + e);
        }
    }
}