package utp.demo.DAO.PERSONAL;

import utp.demo.model.Reporte;
import utp.demo.util.ConexionBD;
import com.google.common.collect.ImmutableList;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class GenerarReporteDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //METODO PARA GENERAR REPORTE
    public static List<Reporte> generarReporteCitasAprobadas() {
        List<Reporte> reportes = new ArrayList<>();
        ConexionBD conexionBD = new ConexionBD();
        try (Connection connection = conexionBD.getConnection();
             CallableStatement callableStatement = connection.prepareCall("{CALL GenerarReporteCitasAprobadas()}");
             ResultSet resultSet = callableStatement.executeQuery()) {
            while (resultSet.next()) {
                String dni = resultSet.getString("DNI");
                String nombreCompleto = resultSet.getString("NombreCompleto");
                String fechaCita = resultSet.getString("FechaCita");
                String estado = resultSet.getString("Estado");
                String mesAnio = resultSet.getString("MesAnio");
                Reporte reporte = new Reporte(dni, nombreCompleto, fechaCita, estado, mesAnio);
                reportes.add(reporte);
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-GenerarReporteDAO-METODO: " + e);
        }
        return ImmutableList.copyOf(reportes);
    }
}