package utp.demo.DAO.PERSONAL;

import utp.demo.util.ConexionBD;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Logger;

public class CambiarEstadoCitaMuestraAnalisisDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    public void cambiarEstadoAnalisis(int idCita, int idAnalisis, String nuevoEstado) throws SQLException {
        String query = "{CALL ActualizarEstadoAnalisisEspecifico(?, ?, ?)}";
        try (Connection connection = new ConexionBD().getConnection();
             CallableStatement callableStatement = connection.prepareCall(query)) {
            callableStatement.setInt(1, idCita);
            callableStatement.setInt(2, idAnalisis);
            callableStatement.setString(3, nuevoEstado);
            callableStatement.executeUpdate();
        }catch (Exception e){
            logger.warning("ERROR EN LA CLASE PERSONAL-CambiarEstadoCitaMuestraAnalisisDAO-METODO: " + e);
        }
    }
}