package utp.demo.business;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.Normalizer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Logger;

public class SubirResultados {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    public static String guardarArchivoConEstructura(String dni, String nombreAnalisis, FilePartReal filePart) {
        try{
            nombreAnalisis = formatearNombreAnalisis(nombreAnalisis);
            String baseDir = System.getProperty("user.dir") + "/HISTORIAL";
            String fechaArchivo = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
            String rutaFinal = String.format("%s/%s/%s/%s/%s", baseDir, dni.charAt(0), dni, fechaArchivo.substring(0, 4), fechaArchivo.substring(5, 7));
            Files.createDirectories(Paths.get(rutaFinal));
            String extension = obtenerExtension(filePart.getSubmittedFileName());
            Path rutaArchivo = Paths.get(rutaFinal, nombreAnalisis + "_" + fechaArchivo + extension);
            try (InputStream inputStream = filePart.getInputStream()) {
                Files.copy(inputStream, rutaArchivo);
            }
            return rutaArchivo.toString().substring(baseDir.length() + 1).replace("\\", "/");
        }catch (Exception e){
            logger.warning("ERROR EN LA CLASE BUSINESS-SubirResultados: " + e);
        }
        return dni;
    }

    private static String obtenerExtension(String nombreArchivo) {
        return nombreArchivo.substring(nombreArchivo.lastIndexOf("."));
    }

    private static String formatearNombreAnalisis(String nombre) {
        String nombreSinAcentos = Normalizer.normalize(nombre, Normalizer.Form.NFD);
        nombreSinAcentos = nombreSinAcentos.replaceAll("[^\\p{ASCII}]", "");
        return nombreSinAcentos.toUpperCase();
    }

    public static class FilePartReal {
        private final InputStream inputStream;
        private final String fileName;

        public FilePartReal(InputStream inputStream, String fileName) {
            this.inputStream = inputStream;
            this.fileName = fileName;
        }

        public InputStream getInputStream() {
            return inputStream;
        }

        public String getSubmittedFileName() {
            return fileName;
        }
    }
}