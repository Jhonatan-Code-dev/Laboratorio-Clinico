package utp.demo.DAO.PERSONAL;

import utp.demo.model.LoginPersonalResult;
import utp.demo.util.ConexionBD;
import org.apache.commons.codec.digest.DigestUtils;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

public class LoginPersonalDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    private static String encriptarMD5(String contrasena) {
        return DigestUtils.md5Hex(contrasena);
    }

    public static LoginPersonalResult login(String correo, String contrasena) {
        ConexionBD conexionBD = new ConexionBD();
        LoginPersonalResult result = null;
        try (Connection connection = conexionBD.getConnection();
             CallableStatement callableStatement = connection.prepareCall("{CALL LoginPersonal(?, ?)}")) {
            callableStatement.setString(1, correo);
            String contrasenaEncriptada = encriptarMD5(contrasena);
            callableStatement.setString(2, contrasenaEncriptada);
            try (ResultSet resultSet = callableStatement.executeQuery()) {
                if (resultSet.next() && resultSet.getObject("id_personal") != null) {
                    Integer idPersonal = resultSet.getInt("id_personal");
                    String rol = resultSet.getString("rol");
                    result = new LoginPersonalResult(idPersonal, rol);
                }
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-LoginPersonalDAO-METODO: " + e);
        }
        return result;
    }
}