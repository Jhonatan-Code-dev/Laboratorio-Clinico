package utp.demo.controller.CLIENTE;

import utp.demo.DAO.CLIENTE.DniExisteDAO;
import utp.demo.DAO.CLIENTE.RegistrarClienteDAO;
import utp.demo.controller.VALIDADOR.Validaciones;
import java.io.*;
import java.util.logging.Logger;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "RegistroServlet", urlPatterns = {"/registro"})
public class PacienteWebRegistrarServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("registro.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        try {
            req.setCharacterEncoding("UTF-8");
            resp.setCharacterEncoding("UTF-8");
            String dni = req.getParameter("dni");
            String nombre = req.getParameter("nombre");
            String apellido = req.getParameter("apellido");
            String fecNac = req.getParameter("fecNac");
            String sexo = req.getParameter("sexo");
            String correo = req.getParameter("correo");
            String contrasena = req.getParameter("contrasena");

            boolean[] resultados = DniExisteDAO.verificarDniYCorreo(dni, "dni");
            boolean[] resultadosCorreo = DniExisteDAO.verificarDniYCorreo(correo, "correo");
            if (!Validaciones.validarDNI(dni) ||
                    !Validaciones.validarNombre(nombre) ||
                    !Validaciones.validarApellido(apellido) ||
                    !Validaciones.validarSexo(sexo) ||
                    resultados[1] ||
                    resultadosCorreo[2] ||
                    !Validaciones.validarContrasena(contrasena) ||
                    !Validaciones.validarCorreo(correo)) {
                return;
            }
            RegistrarClienteDAO.insertarCliente(dni, nombre, apellido, fecNac, sexo);
            RegistrarClienteDAO.registrarSesion(dni, correo, contrasena);
            resp.sendRedirect(req.getContextPath() + "/login");
        } catch (Exception e) {
            logger.warning("ERROR EN LA CLASE CLIENTE-PacienteWebRegistrarServlet: " + e);
        }
    }
}