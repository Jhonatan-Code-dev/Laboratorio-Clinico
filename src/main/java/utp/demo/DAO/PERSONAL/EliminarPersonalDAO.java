package utp.demo.DAO.PERSONAL;

import utp.demo.util.ConexionBD;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

public class EliminarPersonalDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    public String eliminarUsuarioPorDNI(String dni) {
        String mensaje = "";
        try (Connection connection = new ConexionBD().getConnection();
             CallableStatement callableStatement = connection.prepareCall("{CALL EliminarUsuarioPorDNI(?)}")) {
            callableStatement.setString(1, dni);
            boolean hasResult = callableStatement.execute();
            if (hasResult) {
                try (ResultSet resultSet = callableStatement.getResultSet()) {
                    if (resultSet.next()) {
                        mensaje = resultSet.getString("mensaje");
                    }
                }
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-EliminarPersonalDAO-METODO: " + e);
        }
        return mensaje;
    }
}