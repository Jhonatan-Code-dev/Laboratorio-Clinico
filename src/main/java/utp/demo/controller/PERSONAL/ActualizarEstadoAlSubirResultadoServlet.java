package utp.demo.controller.PERSONAL;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import utp.demo.DAO.PERSONAL.ActualizarEstadoAlSubirResultadoDAO;
import utp.demo.business.SubirResultados;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.Normalizer;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/subirResultado")
public class ActualizarEstadoAlSubirResultadoServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (ServletFileUpload.isMultipartContent(request)) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            try {
                List<FileItem> items = upload.parseRequest(request);
                String dni = null, nombreAnalisis = null;
                int idMuestra = -1;
                SubirResultados.FilePartReal filePart = null;
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        if ("dni".equals(item.getFieldName())) dni = item.getString();
                        if ("nombreAnalisis".equals(item.getFieldName())) nombreAnalisis = item.getString();
                        if ("idMuestra".equals(item.getFieldName())) idMuestra = Integer.parseInt(item.getString());
                    } else if ("filePart".equals(item.getFieldName()) && item.getName() != null && !item.getName().isEmpty()) {
                        if (item.getSize() > MAX_FILE_SIZE) {
                            response.getWriter().write("El archivo es demasiado grande. El tamaño maximo permitido es 10 MB.");
                            return;
                        }
                        filePart = new SubirResultados.FilePartReal(item.getInputStream(), item.getName());
                    }
                }
                if (nombreAnalisis != null) {
                    nombreAnalisis = formatearNombreAnalisis(nombreAnalisis);
                }
                if (dni != null && nombreAnalisis != null && filePart != null && idMuestra > 0) {
                    String rutaArchivo = SubirResultados.guardarArchivoConEstructura(dni, nombreAnalisis, filePart);
                    ActualizarEstadoAlSubirResultadoDAO dao = new ActualizarEstadoAlSubirResultadoDAO();
                    dao.actualizarEstadoAlSubirResultado(idMuestra, rutaArchivo);
                    response.getWriter().write("Archivo subido y estado actualizado con exito.");
                } else {
                    response.getWriter().write("Faltan parametros necesarios.");
                }
            } catch (Exception e) {
                logger.warning("ERROR EN LA CLASE PERSONAL-ActualizarEstadoAlSubirResultadoServlet: " + e);
                response.getWriter().write("Error al procesar la solicitud. " + e.getMessage());
            }
        } else {
            response.getWriter().write("La solicitud no es de tipo multipart.");
        }
    }

    private String formatearNombreAnalisis(String nombre) {
        String nombreSinAcentos = Normalizer.normalize(nombre, Normalizer.Form.NFD);
        nombreSinAcentos = nombreSinAcentos.replaceAll("[^\\p{ASCII}]", "");
        return nombreSinAcentos.toUpperCase();
    }
}