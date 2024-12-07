package utp.demo.controller.PERSONAL;

import utp.demo.DAO.PERSONAL.EliminarPersonalDAO;
import utp.demo.DAO.PERSONAL.ListaPersonal;
import utp.demo.DAO.PERSONAL.RegistrarPersonalDAO;
import utp.demo.controller.VALIDADOR.Validaciones;
import org.apache.commons.lang3.StringEscapeUtils;
import utp.demo.model.Personal;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "registrarPersonal", urlPatterns = {"/registrarPersonal"})
public class RegistrarPersonalServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        String mensajeResultado = null;

        try {
            if (accion == null || accion.isEmpty()) {
                ListaPersonal listaPersonal = new ListaPersonal();
                List<Personal> personalList = listaPersonal.obtenerListaPersonal();
                request.setAttribute("personalList", personalList);
                request.getRequestDispatcher("/PERSONAL/personal.jsp").forward(request, response);
                return;
            }

            if ("eliminar".equalsIgnoreCase(accion)) {
                String dni = request.getParameter("dni");
                new EliminarPersonalDAO().eliminarUsuarioPorDNI(dni);
                mensajeResultado = "Personal eliminado exitosamente";
            } else if ("registrar".equalsIgnoreCase(accion)) {
                String dni = request.getParameter("dni");
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String fechaNacimiento = request.getParameter("fechaNacimiento");
                String sexo = request.getParameter("sexo");
                String correo = request.getParameter("correo");
                String contrasena = request.getParameter("contrasena");
                int idRol = Integer.parseInt(request.getParameter("idRol"));

                if (!Validaciones.validarDNI(dni) || !Validaciones.validarNombre(nombre) || !Validaciones.validarApellido(apellido) ||
                        !Validaciones.validarFechaNacimiento(fechaNacimiento) || !Validaciones.validarSexo(sexo) || !Validaciones.validarCorreo(correo)) {
                    mensajeResultado = "Error: Algunos campos no son válidos.";
                } else {
                    dni = StringEscapeUtils.escapeHtml4(dni);
                    nombre = StringEscapeUtils.escapeHtml4(nombre);
                    apellido = StringEscapeUtils.escapeHtml4(apellido);
                    fechaNacimiento = StringEscapeUtils.escapeHtml4(fechaNacimiento);
                    sexo = StringEscapeUtils.escapeHtml4(sexo);
                    correo = StringEscapeUtils.escapeHtml4(correo);
                    contrasena = StringEscapeUtils.escapeHtml4(contrasena);

                    mensajeResultado = new RegistrarPersonalDAO().registrarPersonal(idRol, dni, nombre, apellido, fechaNacimiento, sexo, correo, contrasena);
                }
            } else {
                mensajeResultado = "Acción desconocida.";
            }
        } catch (Exception e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-RegistrarPersonalServlet: " + e);
            mensajeResultado = "Error en el servidor. Intente nuevamente.";
        }

        request.setAttribute("mensajeResultado", mensajeResultado);
        ListaPersonal listaPersonal = new ListaPersonal();
        List<Personal> personalList = listaPersonal.obtenerListaPersonal();
        request.setAttribute("personalList", personalList);
        request.getRequestDispatcher("/PERSONAL/personal.jsp").forward(request, response);
    }
}