package utp.demo.DAO.PERSONAL;

import utp.demo.model.Analisis;
import utp.demo.util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class ListaAnalisisDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //METODO PARA LISTA ANALISIS
    public static List<Analisis> obtenerTodosAnalisis() {
        List<Analisis> listaAnalisis = new ArrayList<>();
        String sql = "CALL obtenerTodosAnalisis()";
        ConexionBD conexionBD = new ConexionBD();
        try (Connection connection = conexionBD.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Analisis analisis = new Analisis();
                analisis.setId(resultSet.getInt("id_analisis"));
                analisis.setNombre(resultSet.getString("nombre"));
                analisis.setDescripcion(resultSet.getString("desc_analisis"));
                analisis.setDisponible(resultSet.getString("disponible"));
                analisis.setDuracion(resultSet.getString("duracion"));
                listaAnalisis.add(analisis);
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-ListaAnalisisDAO-METODO: " + e);
        }
        return listaAnalisis;
    }
}