package utp.demo.util;

import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Logger;

public class ConexionBD {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    public Connection getConnection() throws SQLException {
        try {
            Context initContext = new InitialContext();
            DataSource ds = (DataSource) initContext.lookup("java:/MariaDB");
            return ds.getConnection();
        } catch (NamingException e) {
            logger.severe("Error en la base de datos" + e);
        }
        return null;
    }

    public void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                logger.severe("Error cerrar conexion en la base de datos" + e);
            }
        }
    }
}