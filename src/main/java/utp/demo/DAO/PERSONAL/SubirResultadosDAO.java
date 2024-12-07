package utp.demo.DAO.PERSONAL;

import utp.demo.model.ResultadoCita;
import utp.demo.util.ConexionBD;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public abstract class SubirResultadosDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    public List<ResultadoCita> obtenerMuestrasConEstados() {
        List<ResultadoCita> resultados = new ArrayList<>();
        try (Connection connection = new ConexionBD().getConnection();
             CallableStatement callableStatement = connection.prepareCall("{CALL obtenerMuestrasConEstados()}");
             ResultSet resultSet = callableStatement.executeQuery()) {

            while (resultSet.next()) {
                resultados.add(new ResultadoCita(
                        resultSet.getInt("id_cita"),
                        resultSet.getString("nombre_completo"),
                        resultSet.getString("dni_cliente"),
                        resultSet.getString("analisis_muestras")
                ));
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-SubirResultadosDAO-METODO: " + e);
        }
        return resultados;
    }

    protected abstract Connection getConnection();
}