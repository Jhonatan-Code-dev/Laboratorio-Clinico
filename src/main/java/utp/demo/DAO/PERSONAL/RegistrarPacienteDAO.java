package utp.demo.DAO.PERSONAL;

import utp.demo.util.ConexionBD;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.logging.Logger;

public class RegistrarPacienteDAO {

    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //METODO PARA REGISTRAR PACIENTE
    public static boolean registrarPaciente(String dni, String nombre, String apellido, String fechaNacimiento, String sexo, String fechaRegistro, String telefono, String direccion) {
        String sql = "{CALL registrar_paciente(?, ?, ?, ?, ?, ?, ?, ?)}";
        ConexionBD conexionBD = new ConexionBD();
        try (Connection conn = conexionBD.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setString(1, dni);
            stmt.setString(2, nombre);
            stmt.setString(3, apellido);
            stmt.setString(4, fechaNacimiento);
            stmt.setString(5, sexo);
            stmt.setString(6, fechaRegistro);
            stmt.setObject(7, telefono, Types.VARCHAR);
            stmt.setObject(8, direccion, Types.VARCHAR);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-RegistrarPacienteDAO-METODO: " + e);
            return false;
        }
    }
}