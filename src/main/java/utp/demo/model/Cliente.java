package utp.demo.model;

import com.google.common.base.Preconditions;
import java.time.LocalDate;
import java.util.Objects;

public class Cliente {

    private String dni;
    private String nombre;
    private String apellido;
    private LocalDate fecNac;
    private String sexo;

    public Cliente(String dni, String nombre, String apellido, LocalDate fecNac, String sexo) {
        Preconditions.checkArgument(dni != null && !dni.trim().isEmpty(), "El DNI no puede ser nulo o vacío");
        Preconditions.checkArgument(nombre != null && !nombre.trim().isEmpty(), "El nombre no puede ser nulo o vacío");
        Preconditions.checkArgument(apellido != null && !apellido.trim().isEmpty(), "El apellido no puede ser nulo o vacío");
        Preconditions.checkArgument(fecNac != null, "La fecha de nacimiento no puede ser nula");
        Preconditions.checkArgument(sexo != null && (sexo.equalsIgnoreCase("M") || sexo.equalsIgnoreCase("F")), "El sexo debe ser 'M' o 'F'");

        this.dni = dni;
        this.nombre = nombre;
        this.apellido = apellido;
        this.fecNac = fecNac;
        this.sexo = sexo;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public LocalDate getFecNac() {
        return fecNac;
    }

    public void setFecNac(LocalDate fecNac) {
        this.fecNac = fecNac;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    @Override
    public String toString() {
        return "Cliente{" +
                "dni='" + dni + '\'' +
                ", nombre='" + nombre + '\'' +
                ", apellido='" + apellido + '\'' +
                ", fecNac=" + fecNac +
                ", sexo='" + sexo + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Cliente cliente = (Cliente) o;
        return Objects.equals(dni, cliente.dni) &&
                Objects.equals(nombre, cliente.nombre) &&
                Objects.equals(apellido, cliente.apellido) &&
                Objects.equals(fecNac, cliente.fecNac) &&
                Objects.equals(sexo, cliente.sexo);
    }

    @Override
    public int hashCode() {
        return Objects.hash(dni, nombre, apellido, fecNac, sexo);
    }
}