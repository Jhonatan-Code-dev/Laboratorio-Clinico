package utp.demo.controller.VALIDADOR;

import org.apache.commons.validator.routines.DateValidator;
import org.apache.commons.validator.routines.EmailValidator;
import org.apache.commons.validator.routines.RegexValidator;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

public class Validaciones {

    //METODO PARA VALIDAR DATOS DE ENTRADA
    public static boolean validarDNI(String dni) {
        RegexValidator dniValidator = new RegexValidator("\\d{8}");
        return dniValidator.isValid(dni);
    }

    private static boolean validarTexto(String texto) {
        RegexValidator textoValidator = new RegexValidator("^[\\p{L} ]+$");
        return texto != null && !texto.trim().isEmpty() && texto.length() <= 30 && textoValidator.isValid(texto);
    }

    public static boolean validarNombre(String nombre) {
        return validarTexto(nombre);
    }

    public static boolean validarApellido(String apellido) {
        return validarTexto(apellido);
    }

    public static boolean validarFechaNacimiento(String fecNac) {
        LocalDate hoyEnPeru = LocalDate.now(ZoneId.of("America/Lima"));
        DateValidator dateValidator = DateValidator.getInstance();
        return fecNac != null && !fecNac.trim().isEmpty() && dateValidator.isValid(fecNac, "yyyy-MM-dd") &&
                !LocalDate.parse(fecNac).isEqual(hoyEnPeru) && LocalDate.parse(fecNac).isBefore(hoyEnPeru);
    }

    public static boolean validarSexo(String sexo) {
        return sexo != null && !sexo.trim().isEmpty() && (sexo.equalsIgnoreCase("M") || sexo.equalsIgnoreCase("F"));
    }

    public static boolean validarCorreo(String correo) {
        EmailValidator emailValidator = EmailValidator.getInstance();
        return correo != null && correo.length() <= 40 && emailValidator.isValid(correo);
    }

    public static boolean validarTelefono(String telefono) {
        RegexValidator telefonoValidator = new RegexValidator("\\d{9}");
        return telefono != null && telefonoValidator.isValid(telefono);
    }

    public static boolean validarContrasena(String contrasena) {
        RegexValidator contrasenaValidator = new RegexValidator("^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{4,8}$");
        return contrasenaValidator.isValid(contrasena);
    }

    public static boolean validarDisponibilidad(String disponible) {
        return "si".equalsIgnoreCase(disponible) || "no".equalsIgnoreCase(disponible);
    }

    public static boolean validarFechaCita(String fechaCita) {
        LocalDate hoyEnPeru = LocalDate.now(ZoneId.of("America/Lima"));
        LocalDate citaDate = LocalDate.parse(fechaCita, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        return !citaDate.isBefore(hoyEnPeru);
    }

    public static boolean validarHoraCita(String horaCita) {
        LocalTime horaInicio = LocalTime.of(7, 0);
        LocalTime horaFin = LocalTime.of(16, 0);
        LocalTime horaCitaTime = LocalTime.parse(horaCita, DateTimeFormatter.ofPattern("HH:mm"));
        return !horaCitaTime.isBefore(horaInicio) && !horaCitaTime.isAfter(horaFin);
    }
}