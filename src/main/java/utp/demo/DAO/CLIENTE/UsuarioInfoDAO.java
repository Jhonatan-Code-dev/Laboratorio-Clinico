package utp.demo.DAO.CLIENTE;

import utp.demo.util.ConexionBD;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

public class UsuarioInfoDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    public String[] obtenerDatosCliente(int idCliente) throws SQLException {
        String query = "{CALL ObtenerDatosCliente(?)}";
        try (Connection conn = new ConexionBD().getConnection();
             CallableStatement stmt = conn.prepareCall(query)) {
            stmt.setInt(1, idCliente);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String[] datosCliente = new String[7];
                    datosCliente[0] = rs.getString("dni");
                    datosCliente[1] = rs.getString("nombre");
                    datosCliente[2] = rs.getString("apellido");
                    datosCliente[3] = rs.getDate("fec_nac").toString();
                    datosCliente[4] = rs.getString("sexo");
                    datosCliente[5] = rs.getString("telefono");
                    datosCliente[6] = rs.getString("direccion");
                    return datosCliente;
                }
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE CLIENTE-UsuarioInfoDAO-METODO: " + e);
        }
        return null;
    }
}