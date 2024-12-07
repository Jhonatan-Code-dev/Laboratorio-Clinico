package utp.demo.DAO.PERSONAL;

import utp.demo.util.ConexionBD;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.util.logging.Logger;

public class ActualizarAnalisisDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    public static void actualizarAnalisis(int id_analisis, String nombre, String desc_analisis, String disponible, String duracion) throws SQLException {
        ConexionBD conexionBD = new ConexionBD();
        try (Connection connection = conexionBD.getConnection();
             CallableStatement stmt = connection.prepareCall("{CALL actualizar_analisis(?, ?, ?, ?, ?)}")) {
            stmt.setInt(1, id_analisis);
            stmt.setString(2, nombre);
            stmt.setString(3, desc_analisis);
            stmt.setString(4, disponible);
            stmt.setString(5, duracion);
            stmt.executeUpdate();
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-ActualizarAnalisisDAO-METODO: " + e);
        }
    }
}