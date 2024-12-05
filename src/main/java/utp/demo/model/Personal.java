package utp.demo.model;

import com.google.common.base.Preconditions;
import com.google.common.base.Joiner;
import java.util.Date;

public class Personal {

    private int idPersonal;
    private String dni;
    private String nombre;
    private String apellido;
    private Date fechaNacimiento;
    private String sexo;
    private String correo;
    private String nombreRol;

    public Personal() {}

    public Personal(int idPersonal, String dni, String nombre, String apellido, Date fechaNacimiento, String sexo, String correo, String nombreRol) {
        this.idPersonal = idPersonal;
        this.dni = Preconditions.checkNotNull(dni, "El DNI no puede ser nulo");
        this.nombre = Preconditions.checkNotNull(nombre, "El nombre no puede ser nulo");
        this.apellido = Preconditions.checkNotNull(apellido, "El apellido no puede ser nulo");
        this.fechaNacimiento = Preconditions.checkNotNull(fechaNacimiento, "La fecha de nacimiento no puede ser nula");
        this.sexo = Preconditions.checkNotNull(sexo, "El sexo no puede ser nulo");
        this.correo = Preconditions.checkNotNull(correo, "El correo no puede ser nulo");
        this.nombreRol = Preconditions.checkNotNull(nombreRol, "El nombre del rol no puede ser nulo");
    }

    public int getIdPersonal() {
        return idPersonal;
    }

    public void setIdPersonal(int idPersonal) {
        this.idPersonal = idPersonal;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = Preconditions.checkNotNull(dni, "El DNI no puede ser nulo");
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = Preconditions.checkNotNull(nombre, "El nombre no puede ser nulo");
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = Preconditions.checkNotNull(apellido, "El apellido no puede ser nulo");
    }

    public Date getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = Preconditions.checkNotNull(fechaNacimiento, "La fecha de nacimiento no puede ser nula");
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = Preconditions.checkNotNull(sexo, "El sexo no puede ser nulo");
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = Preconditions.checkNotNull(correo, "El correo no puede ser nulo");
    }

    public String getNombreRol() {
        return nombreRol;
    }

    public void setNombreRol(String nombreRol) {
        this.nombreRol = Preconditions.checkNotNull(nombreRol, "El nombre del rol no puede ser nulo");
    }

    @Override
    public String toString() {
        return Joiner.on(", ").skipNulls().join(
                "Personal{idPersonal=" + idPersonal,
                "dni='" + dni + "'",
                "nombre='" + nombre + "'",
                "apellido='" + apellido + "'",
                "fechaNacimiento=" + fechaNacimiento,
                "sexo='" + sexo + "'",
                "correo='" + correo + "'",
                "nombreRol='" + nombreRol + "'"
        );
    }
}