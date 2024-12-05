package utp.demo.DAO.NOTIFICACION;

import utp.demo.business.email.EnviarGmailCita;
import utp.demo.util.ConexionBD;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

public class NotificacionDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    public static void notificarCitasAprobadas() {
        String queryObtenerCitas = "{CALL ObtenerCitasAprobadasClientes()}";
        try (Connection connection = new ConexionBD().getConnection();
             CallableStatement callableStatement = connection.prepareCall(queryObtenerCitas);
             ResultSet resultSet = callableStatement.executeQuery()) {
            if (!resultSet.isBeforeFirst()) {
                return;
            }

            while (resultSet.next()) {
                int idCita = resultSet.getInt("id_cita");
                String fechaHora = resultSet.getString("fec_hora");
                String estado = resultSet.getString("estado");
                String nombreCliente = resultSet.getString("nombre_cliente");
                String apellidoCliente = resultSet.getString("apellido_cliente");
                String correoCliente = resultSet.getString("correo_cliente");

                if (correoCliente != null && !correoCliente.isEmpty()) {
                    try {
                        EnviarGmailCita.enviarNotificacionCita(fechaHora, correoCliente, idCita);
                        notificarCita(idCita);
                    } catch (Exception e) {
                        logger.warning("Error al enviar la notificación de cita para el ID: " + idCita + " debido a: " + e.getMessage());
                    }
                } else {
                    logger.warning("No hay correo disponible para la cita con ID: " + idCita);
                }
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE NOTIFICACION-NotificacionDAO-METODO: " + e);
        }
    }

    public static void notificarCita(int idCita) {
        String queryNotificarCita = "{CALL NotificarCita(?, ?)}";
        try (Connection connection = new ConexionBD().getConnection();
             CallableStatement callableStatement = connection.prepareCall(queryNotificarCita)) {
            callableStatement.setInt(1, idCita);
            callableStatement.setString(2, "enviado");
            callableStatement.execute();
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE NOTIFICACION-NotificacionDAO-METODO: " + e);
        }
    }
}