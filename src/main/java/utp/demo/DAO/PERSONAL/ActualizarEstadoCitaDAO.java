package utp.demo.DAO.PERSONAL;

import utp.demo.util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Logger;

public class ActualizarEstadoCitaDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //METODO PARA ACTUALIZAR ESTADO CITA PACIENTE
    public static void cambiarEstadoCita(int p_id_cita, boolean p_aprobar) {
        ConexionBD conexionBD = new ConexionBD();
        try (Connection connection = conexionBD.getConnection();
             PreparedStatement statement = connection.prepareStatement("{CALL CambiarEstadoCita(?, ?)}")) {
            statement.setInt(1, p_id_cita);
            statement.setBoolean(2, p_aprobar);
            statement.executeUpdate();
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-ActualizarEstadoCitaDAO-METODO: " + e);
        }
    }
}