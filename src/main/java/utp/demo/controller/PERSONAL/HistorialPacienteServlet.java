package utp.demo.controller.PERSONAL;

import utp.demo.DAO.PERSONAL.HistorialPacienteDniDAO;
import utp.demo.model.HistoriaPaciente;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "HistorialPacienteServlet", urlPatterns = {"/HistorialPaciente"})
public class HistorialPacienteServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dni = request.getParameter("dni");
        response.setContentType("text/plain;charset=UTF-8");
        if (dni == null || dni.isEmpty()) {
            request.getRequestDispatcher("/PERSONAL/HistorialPacienteProporcionado.jsp").forward(request, response);
            return;
        }
        try {
            List<HistoriaPaciente> historial = new HistorialPacienteDniDAO().obtenerHistorialPorDNI(dni);
            if (historial.isEmpty()) {
                response.getWriter().write("No se encontraron resultados para el paciente con DNI: " + dni);
            } else {
                for (HistoriaPaciente historia : historial) {
                    String[] analisisArray = historia.getAnalisis().split(";");
                    for (String analisis : analisisArray) {
                        String[] partes = analisis.split(",");
                        if (partes.length == 4) {
                            String nombreAnalisis = partes[0].split(":")[1].trim();
                            String rutaAnalisis = partes[1].trim();
                            String fechaMuestra = partes[2].trim();
                            String fechaResultados = partes[3].trim();
                            String baseURL = "https://www.unionlab.online/archivos/";
                            rutaAnalisis = sanitizarRuta(rutaAnalisis);
                            String urlPrevisualizar = baseURL + rutaAnalisis;
                            String urlDescargar = baseURL + rutaAnalisis;
                            String enlacePrevisualizar = generarEnlace(urlPrevisualizar, "Ver PDF", false);
                            String enlaceDescargar = generarEnlace(urlDescargar, "Descargar PDF", true);
                            response.getWriter().write(
                                    historia.getFechaCita() + "," + fechaMuestra + "," + fechaResultados + "," +
                                            nombreAnalisis + "," + enlacePrevisualizar + " | " + enlaceDescargar + "\n"
                            );
                        }
                    }
                }
            }
        } catch (SQLException e) {
            response.getWriter().write("Error al obtener el historial del paciente: " + e.getMessage());
        } catch (Exception e) {
            response.getWriter().write("Actualmente no tiene un historial registrado.");
            logger.warning("ERROR EN LA CLASE PERSONAL-HistorialPacienteServlet: " + e);
        }
    }

    private String generarEnlace(String url, String texto, boolean esDescarga) {
        if (esDescarga) {
            return "<a href='" + url + "' download>" + texto + "</a>";
        } else {
            return "<a href='javascript:void(0);' onclick='verPDF(\"" + url + "\")'>" + texto + "</a>";
        }
    }
    private String sanitizarRuta(String ruta) {
        if (ruta == null) {
            return "";
        }
        return ruta.replaceAll("\\s+", "%20");
    }
}