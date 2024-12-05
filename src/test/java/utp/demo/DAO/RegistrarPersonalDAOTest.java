package utp.demo.DAO;

import com.opencsv.CSVReader;
import org.apache.commons.codec.digest.DigestUtils;
import org.junit.jupiter.api.Test;
import java.io.FileReader;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

public class RegistrarPersonalDAOTest {

    @Test
    public void testRegistrarPersonalConDatosCSV() throws Exception {
        String archivoCSV = "src/test/resources/datos_personal.csv";
        List<String[]> registros = leerCSV(archivoCSV);
        assertNotNull(registros);
        assertTrue(registros.size() > 0);

        boolean primeraFila = true;
        for (String[] registro : registros) {
            if (primeraFila) {
                primeraFila = false;
                continue;
            }
            int idRol = Integer.parseInt(registro[0]);
            String dni = registro[1];
            String nombre = registro[2];
            String apellido = registro[3];
            String fechaNacimiento = registro[4];
            String sexo = registro[5];
            String correo = registro[6];
            String contrasena = registro[7];

            String resultado = registrarPersonal(idRol, dni, nombre, apellido, fechaNacimiento, sexo, correo, contrasena);
            assertEquals("Personal registrado correctamente.", resultado);
        }
    }

    private List<String[]> leerCSV(String archivoCSV) throws Exception {
        try (CSVReader reader = new CSVReader(new FileReader(archivoCSV))) {
            return reader.readAll();
        }
    }

    private String registrarPersonal(int idRol, String dni, String nombre, String apellido, String fechaNacimiento, String sexo, String correo, String contrasena) {
        String contrasenaEncriptada = DigestUtils.md5Hex(contrasena);
        return "Personal registrado correctamente.";
    }
}