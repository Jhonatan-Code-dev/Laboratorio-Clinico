package utp.demo.DAO.PERSONAL;

import utp.demo.util.ConexionBD;
import utp.demo.model.HistoriaPaciente;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class HistorialPacienteDniDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    public List<HistoriaPaciente> obtenerHistorialPorDNI(String dni) throws SQLException {
        List<HistoriaPaciente> historial = new ArrayList<>();
        String query = "{CALL ObtenerHistorialResultadosPorDNI(?)}";
        try (Connection connection = new ConexionBD().getConnection();
             CallableStatement callableStatement = connection.prepareCall(query)) {
            callableStatement.setString(1, dni);
            try (ResultSet resultSet = callableStatement.executeQuery()) {
                while (resultSet.next()) {
                    HistoriaPaciente historia = new HistoriaPaciente(
                            resultSet.getInt("id_cita"),
                            resultSet.getString("fecha_cita"),
                            resultSet.getString("analisis")
                    );
                    historial.add(historia);
                }
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-HistorialPacienteDniDAO-METODO: " + e);
        }
        return historial;
    }
}