package utp.demo.DAO.PERSONAL;

import utp.demo.model.Paciente;
import utp.demo.util.ConexionBD;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class ListaPacienteDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //METODO DE LISTA PACIENTE
    public static List<Paciente> obtenerListaClientes() throws SQLException {
        String query = "{CALL ObtenerListaClientes()}";
        List<Paciente> listaPacientes = new ArrayList<>();
        ConexionBD conexionBD = new ConexionBD();
        try (Connection connection = conexionBD.getConnection();
             CallableStatement stmt = connection.prepareCall(query);
             ResultSet resultSet = stmt.executeQuery()) {
            while (resultSet.next()) {
                listaPacientes.add(new Paciente(
                        resultSet.getInt("id_cliente"),
                        resultSet.getString("dni"),
                        resultSet.getString("nombre"),
                        resultSet.getString("apellido"),
                        resultSet.getString("fec_nac"),
                        resultSet.getString("sexo"),
                        resultSet.getString("fecha_registro"),
                        resultSet.getString("telefono"),
                        resultSet.getString("direccion")
                ));
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-ListaPacienteDAO-METODO: " + e);
        }
        return listaPacientes;
    }
}