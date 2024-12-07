package utp.demo.DAO.PERSONAL;

import utp.demo.model.Personal;
import utp.demo.util.ConexionBD;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class ListaPersonal {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    // Metodo para obtener la lista de personal
    public List<Personal> obtenerListaPersonal() {
        List<Personal> listaPersonal = new ArrayList<>();
        String sql = "{CALL obtener_datos_personal()}";
        ConexionBD conexionBD = new ConexionBD();
        try (Connection conn = conexionBD.getConnection();
             CallableStatement stmt = conn.prepareCall(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Personal personal = new Personal();
                personal.setIdPersonal(rs.getInt("id_personal"));
                personal.setDni(rs.getString("dni"));
                personal.setNombre(rs.getString("nombre"));
                personal.setApellido(rs.getString("apellido"));
                personal.setFechaNacimiento(rs.getDate("fec_nac"));
                personal.setSexo(rs.getString("sexo"));
                personal.setCorreo(rs.getString("correo"));
                personal.setNombreRol(rs.getString("nombre_rol"));
                listaPersonal.add(personal);
            }
        } catch (SQLException e) {
            logger.warning("ERROR EN LA CLASE PERSONAL-ListaPersonal-METODO: " + e);
        }
        return listaPersonal;
    }
}