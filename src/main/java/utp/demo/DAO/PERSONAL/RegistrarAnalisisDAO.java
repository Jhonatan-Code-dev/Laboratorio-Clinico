package utp.demo.DAO.PERSONAL;

import utp.demo.util.ConexionBD;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

public class RegistrarAnalisisDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    public static String registrarAnalisis(String nombre, String descripcion, String disponible, String duracion) throws SQLException {
        duracion = duracion.substring(0, 5);
        ConexionBD conexionBD = new ConexionBD();
        try (Connection conn = conexionBD.getConnection();
             CallableStatement stmt = conn.prepareCall("{CALL RegistrarAnalisis(?, ?, ?, ?)}")) {
            stmt.setString(1, nombre);
            stmt.setString(2, descripcion);
            stmt.setString(3, disponible);
            stmt.setString(4, duracion);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("mensaje");
            }
            return "Error desconocido.";
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-RegistrarAnalisisDAO-METODO: " + e);
            return null;
        }
    }
}