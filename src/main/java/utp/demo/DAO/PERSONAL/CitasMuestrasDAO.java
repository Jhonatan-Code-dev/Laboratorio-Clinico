package utp.demo.DAO.PERSONAL;

import utp.demo.model.CitaAprobada;
import utp.demo.util.ConexionBD;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class CitasMuestrasDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    public List<CitaAprobada> obtenerCitasAprobadas() {
        List<CitaAprobada> citasAprobadas = new ArrayList<>();
        try (Connection connection = new ConexionBD().getConnection();
             CallableStatement callableStatement = connection.prepareCall("{CALL ObtenerCitasAprobadas()}");
             ResultSet resultSet = callableStatement.executeQuery()) {
            while (resultSet.next()) {
                citasAprobadas.add(new CitaAprobada(
                        resultSet.getInt("id_cliente"),
                        resultSet.getString("dni"),
                        resultSet.getString("nombre_completo"),
                        resultSet.getInt("id_cita"),
                        resultSet.getTimestamp("fec_hora"),
                        resultSet.getString("analisis_con_id"),
                        resultSet.getString("estados_analisis")
                ));
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-CitasMuestrasDAO-METODO: " + e);
        }
        return citasAprobadas;
    }
}