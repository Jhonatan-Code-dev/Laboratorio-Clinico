package utp.demo.DAO.PERSONAL;

import utp.demo.util.ConexionBD;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Logger;

public class ActualizarEstadoAlSubirResultadoDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    public void actualizarEstadoAlSubirResultado(int idMuestra, String ruta) {
        try (Connection conn = new ConexionBD().getConnection();
             CallableStatement stmt = conn.prepareCall("{CALL subirResultado(?, ?)}")) {
            stmt.setInt(1, idMuestra);
            stmt.setString(2, ruta);
            stmt.executeUpdate();
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-ActualizarEstadoAlSubirResultadoDAO-METODO: " + e);
        }
    }
}