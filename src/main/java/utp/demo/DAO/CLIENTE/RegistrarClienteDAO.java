package utp.demo.DAO.CLIENTE;

import utp.demo.util.ConexionBD;
import org.apache.commons.codec.digest.DigestUtils;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.logging.Logger;

public class RegistrarClienteDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    // METODO PARA REGISTRAR CLIENTE
    public static void insertarCliente(String dni, String nombre, String apellido, String fecNac, String sexo) {
        LocalDateTime fechaRegistro = LocalDateTime.now(ZoneId.of("America/Lima"));
        Timestamp timestampRegistro = Timestamp.valueOf(fechaRegistro);
        try (Connection connection = new ConexionBD().getConnection();
             CallableStatement callableStatement = connection.prepareCall("{CALL insertar_cliente(?, ?, ?, ?, ?, ?)}")) {
            callableStatement.setString(1, dni);
            callableStatement.setString(2, nombre);
            callableStatement.setString(3, apellido);
            callableStatement.setDate(4, java.sql.Date.valueOf(fecNac));
            callableStatement.setString(5, sexo);
            callableStatement.setTimestamp(6, timestampRegistro);
            callableStatement.execute();
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE CLIENTE-RegistrarClienteDAO-METODO: " + e);
        }
    }

    // METODO PARA REGISTRAR SESION (CON CONTRASEÑA ENCRIPTADA)
    public static void registrarSesion(String dni, String correo, String contrasena) {
        String contrasenaEncriptada = encriptarContrasena(contrasena);
        try (Connection connection = new ConexionBD().getConnection();
             CallableStatement callableStatement = connection.prepareCall("{call registrar_sesion(?, ?, ?)}")) {
            callableStatement.setString(1, dni);
            callableStatement.setString(2, correo);
            callableStatement.setString(3, contrasenaEncriptada);
            callableStatement.execute();
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE CLIENTE-RegistrarClienteDAO-METODO: " + e);
        }
    }

    private static String encriptarContrasena(String contrasena) {
        return DigestUtils.sha256Hex(contrasena);
    }
}