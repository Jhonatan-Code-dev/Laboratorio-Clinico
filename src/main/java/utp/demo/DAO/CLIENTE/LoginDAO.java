package utp.demo.DAO.CLIENTE;

import utp.demo.util.ConexionBD;
import org.apache.commons.codec.digest.DigestUtils;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

public class LoginDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    // METODO PARA INICIAR SESION
    public static Integer login(String correo, String contrasena) throws IOException {
        ConexionBD conexionBD = new ConexionBD();
        try (Connection connection = conexionBD.getConnection();
             CallableStatement callableStatement = connection.prepareCall("{CALL login(?)}")) {
            callableStatement.setString(1, correo);
            try (ResultSet resultSet = callableStatement.executeQuery()) {
                if (resultSet.next()) {
                    String hashAlmacenado = resultSet.getString("contrasena");
                    Integer idCliente = resultSet.getInt("id_cliente");
                    if (idCliente == 0 || hashAlmacenado == null) {
                        return null;
                    }
                    String hashIngresado = DigestUtils.sha256Hex(contrasena);
                    if (hashAlmacenado.equals(hashIngresado)) {
                        return idCliente;
                    } else {
                        return null;
                    }
                }
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE CLIENTE-LoginDAO-METODO: " + e);
        }
        return null;
    }
}