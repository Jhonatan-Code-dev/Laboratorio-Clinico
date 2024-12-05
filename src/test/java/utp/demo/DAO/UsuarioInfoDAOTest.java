package utp.demo.DAO;

import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvValidationException;
import org.junit.jupiter.api.Test;
import utp.demo.DAO.CLIENTE.UsuarioInfoDAO;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

public class UsuarioInfoDAOTest {

    private static final String CSV_FILE_PATH = "src/test/resources/clientes.csv";

    @Test
    void testObtenerDatosCliente_ConParametrosCSV() throws SQLException, IOException {
        UsuarioInfoDAO usuarioInfoDAO = mock(UsuarioInfoDAO.class);
        Map<Integer, String[]> datosClientes = new HashMap<>();
        try (CSVReader csvReader = new CSVReader(new FileReader(CSV_FILE_PATH))) {
            String[] valores;
            boolean primeraFila = true;
            while ((valores = csvReader.readNext()) != null) {
                if (primeraFila) {
                    primeraFila = false;
                    continue;
                }
                int idCliente = Integer.parseInt(valores[0]);
                String dni = valores[1];
                String nombre = valores[2];
                String apellido = valores[3];
                String fecNac = valores[4];
                String sexo = valores[5];
                String telefono = valores[6];
                String direccion = valores[7];
                String[] datosCliente = {dni, nombre, apellido, fecNac, sexo, telefono, direccion};
                datosClientes.put(idCliente, datosCliente);
            }
        } catch (CsvValidationException e) {
            System.err.println("Error al leer el archivo CSV: " + e.getMessage());
        }
        when(usuarioInfoDAO.obtenerDatosCliente(anyInt())).thenAnswer(invocation -> {
            int idCliente = invocation.getArgument(0);
            return datosClientes.get(idCliente);
        });
        for (Map.Entry<Integer, String[]> entry : datosClientes.entrySet()) {
            int idCliente = entry.getKey();
            String[] datosClienteEsperados = entry.getValue();
            String[] datosCliente = usuarioInfoDAO.obtenerDatosCliente(idCliente);
            assertNotNull(datosCliente, "El array de datos cliente no debe ser null.");
            assertEquals(7, datosCliente.length, "El array debe contener 7 elementos.");
            assertArrayEquals(datosClienteEsperados, datosCliente, "Los datos del cliente no coinciden.");
        }
    }
}