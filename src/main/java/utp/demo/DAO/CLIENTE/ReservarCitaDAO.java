package utp.demo.DAO.CLIENTE;

import utp.demo.util.ConexionBD;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.util.logging.Logger;

public class ReservarCitaDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //METODO PARA RESERVAR CITA
    public static void reservarCita(int idCliente, String fecHora, String fecCreacion, String analisisIds) throws SQLException {
        try (Connection connection = new ConexionBD().getConnection();
             CallableStatement stmt = connection.prepareCall("{CALL ReservarCita(?, ?, ?, ?)}")) {
            stmt.setInt(1, idCliente);
            stmt.setString(2, fecHora);
            stmt.setString(3, fecCreacion);
            stmt.setString(4, analisisIds);
            stmt.execute();
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE CLIENTE-ReservarCitaDAO-METODO: " + e);
        }
    }
}