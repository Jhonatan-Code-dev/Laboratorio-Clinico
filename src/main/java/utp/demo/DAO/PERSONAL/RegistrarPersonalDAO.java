package utp.demo.DAO.PERSONAL;

import org.apache.commons.codec.digest.DigestUtils;
import utp.demo.util.ConexionBD;
import java.sql.*;
import java.util.logging.Logger;

public class RegistrarPersonalDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    private String encriptarMD5(String contrasena) {
        return DigestUtils.md5Hex(contrasena);
    }

    public String registrarPersonal(int idRol, String dni, String nombre, String apellido, String fechaNacimiento, String sexo, String correo, String contrasena) {
        String mensaje = "";
        String sql = "{CALL registrar_personal(?, ?, ?, ?, ?, ?, ?, ?)}";
        String contrasenaEncriptada = encriptarMD5(contrasena);
        ConexionBD conexionBD = new ConexionBD();
        try (Connection conn = conexionBD.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setInt(1, idRol);
            stmt.setString(2, dni);
            stmt.setString(3, nombre);
            stmt.setString(4, apellido);
            stmt.setString(5, fechaNacimiento);
            stmt.setString(6, sexo);
            stmt.setString(7, correo);
            stmt.setString(8, contrasenaEncriptada);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                mensaje = rs.getString("mensaje_resultado");
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-RegistrarPersonalDAO-METODO: " + e);
        }
        return mensaje;
    }
}