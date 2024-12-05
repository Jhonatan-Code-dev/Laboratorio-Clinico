package utp.demo.DAO.CLIENTE;

import utp.demo.model.Cita;
import utp.demo.util.ConexionBD;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class MostrarEstadoCitaDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //METODO PARA MOSTRAR ESTADO CITA
    public static List<Cita> mostrarCitaPaciente(int clienteId, String fechaHora) {
        List<Cita> citas = new ArrayList<>();
        String sql = "{CALL mostrarCitaPaciente(?, ?)}";
        ConexionBD conexionBD = new ConexionBD();
        try (Connection conexion = conexionBD.getConnection();
             CallableStatement callableStatement = conexion.prepareCall(sql)) {
            callableStatement.setInt(1, clienteId);
            callableStatement.setString(2, fechaHora);
            try (ResultSet resultSet = callableStatement.executeQuery()) {
                while (resultSet.next()) {
                    citas.add(new Cita(
                            resultSet.getInt("id_cita"),
                            resultSet.getInt("id_cliente"),
                            resultSet.getString("fec_hora"),
                            resultSet.getString("estado")
                    ));
                }
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE CLIENTE-MostrarEstadoCitaDAO-METODO: " + e);
        }
        return citas;
    }
}