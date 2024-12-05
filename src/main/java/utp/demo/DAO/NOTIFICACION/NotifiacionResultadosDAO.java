package utp.demo.DAO.NOTIFICACION;

import utp.demo.util.ConexionBD;
import utp.demo.business.email.EnviarResultadosPaciente;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class NotifiacionResultadosDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    public static void obtenerResultadosYRegistrarEnvio() {
        List<List<Object>> resultados = new ArrayList<>();
        ConexionBD conexionBD = new ConexionBD();
        Connection connection = null;
        try {
            connection = conexionBD.getConnection();
            String sql = "{CALL ObtenerResultadosNoEnviados()}";
            try (CallableStatement stmt = connection.prepareCall(sql);
                 ResultSet rs = stmt.executeQuery()) {
                if (!rs.isBeforeFirst()) {
                    return;
                }

                while (rs.next()) {
                    int idResultado = rs.getInt("id_resultado");
                    String nombreCliente = rs.getString("nombre_completo_cliente");
                    String correoCliente = rs.getString("correo_cliente");
                    String nombreAnalisis = rs.getString("nombre_analisis");
                    String rutaResultado = rs.getString("ruta");

                    EnviarResultadosPaciente.enviarNotificacion(nombreCliente, correoCliente, nombreAnalisis, rutaResultado);

                    boolean exito = registrarEnviar(idResultado);
                    if (!exito) {
                        logger.warning("Error al registrar el envío para el resultado con ID: " + idResultado);
                    }
                }
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE NOTIFICACION-NotifiacionResultadosDAO-METODO: " + e);
        } finally {
            conexionBD.closeConnection(connection);
        }
    }

    private static boolean registrarEnviar(int idResultado) {
        ConexionBD conexionBD = new ConexionBD();
        Connection connection = null;
        boolean exito = false;
        try {
            connection = conexionBD.getConnection();
            String sql = "{CALL RegistrarEnviar(?)}";
            try (CallableStatement stmt = connection.prepareCall(sql)) {
                stmt.setInt(1, idResultado);
                stmt.execute();
                exito = true;
            }
        } catch (SQLException e) {
            logger.warning("Error al registrar el envío para el ID de resultado: " + idResultado + " debido a: " + e);
        } finally {
            conexionBD.closeConnection(connection);
        }

        return exito;
    }
}