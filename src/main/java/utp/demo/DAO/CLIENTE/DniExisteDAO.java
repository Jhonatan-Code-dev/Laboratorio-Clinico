package utp.demo.DAO.CLIENTE;

import utp.demo.util.ConexionBD;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

public class DniExisteDAO {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //METODO PARA VERIFICAR DNI EXISTE Y CORREO
    public static boolean[] verificarDniYCorreo(String valor, String tipo) throws IOException {
        boolean[] resultados = new boolean[3];
        try (Connection connection = new ConexionBD().getConnection();
             CallableStatement smt = connection.prepareCall("{CALL verificarDniYCorreo(?, ?)}")) {
            smt.setString(1, valor);
            smt.setString(2, tipo);
            try (ResultSet resultSet = smt.executeQuery()) {
                if (resultSet.next()) {
                    resultados[0] = resultSet.getInt("dni_registrado") == 1;
                    resultados[1] = resultSet.getInt("dni_asociado") == 1;
                    resultados[2] = resultSet.getInt("correo_registrado") == 1;
                }
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE CLIENTE-DniExisteDAO-METODO: " + e);
        }
        return resultados;
    }
}