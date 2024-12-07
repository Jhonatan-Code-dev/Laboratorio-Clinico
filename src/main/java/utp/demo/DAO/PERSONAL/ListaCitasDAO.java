package utp.demo.DAO.PERSONAL;

import utp.demo.model.ListaCitas;
import utp.demo.util.ConexionBD;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class ListaCitasDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //METODO DE LISTA DE CITAS
    public static List<ListaCitas> obtenerCitasPendientes() {
        List<ListaCitas> citasPendientes = new ArrayList<>();
        String query = "{CALL ObtenerCitasPendientes()}";
        ConexionBD conexionBD = new ConexionBD();
        try (Connection connection = conexionBD.getConnection();
             CallableStatement stmt = connection.prepareCall(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                ListaCitas cita = mapRowToCita(rs);
                citasPendientes.add(cita);
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-ListaCitasDAO-METODO: " + e);
        }
        return citasPendientes;
    }

    private static ListaCitas mapRowToCita(ResultSet rs) throws SQLException {
        ListaCitas cita = new ListaCitas();
        cita.setIdCliente(rs.getInt("id_cliente"));
        cita.setDni(rs.getString("dni"));
        cita.setNombreCompleto(rs.getString("nombre_completo"));
        cita.setIdCita(rs.getInt("id_cita"));
        cita.setFecHora(rs.getTimestamp("fec_hora"));
        cita.setEstadoCita(rs.getString("estado_cita"));
        cita.setIdAnalisisCita(rs.getInt("id_analisis_cita"));
        cita.setIdAnalisis(rs.getInt("id_analisis"));
        cita.setNombreAnalisis(rs.getString("nombre_analisis"));
        cita.setEstadoAnalisis(rs.getString("estado_analisis"));
        return cita;
    }
}