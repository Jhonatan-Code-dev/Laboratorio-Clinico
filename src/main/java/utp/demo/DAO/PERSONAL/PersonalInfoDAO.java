package utp.demo.DAO.PERSONAL;

import utp.demo.util.ConexionBD;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.logging.Logger;

public class PersonalInfoDAO {

    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    public String[] obtenerInformacionPersonal(int idPersonal) {
        String[] personalInfo = new String[6];
        String procedimiento = "{CALL ObtenerInformacionPersonal(?)}";
        try (Connection connection = new ConexionBD().getConnection();
             CallableStatement callableStatement = connection.prepareCall(procedimiento)) {
            callableStatement.setInt(1, idPersonal);
            try (ResultSet resultSet = callableStatement.executeQuery()) {
                if (resultSet.next()) {
                    personalInfo[0] = String.valueOf(resultSet.getInt("id_personal"));
                    personalInfo[1] = resultSet.getString("dni");
                    personalInfo[2] = resultSet.getString("nombre");
                    personalInfo[3] = resultSet.getString("apellido");
                    personalInfo[4] = resultSet.getString("fec_nac");
                    personalInfo[5] = resultSet.getString("sexo");
                }
            }
        } catch (Exception e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-PersonalInfoDAO-METODO: " + e);
        }
        return personalInfo;
    }
}