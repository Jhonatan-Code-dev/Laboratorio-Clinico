package utp.demo.model;

import com.google.common.base.Joiner;

public class Paciente {
    private final int idCliente;
    private final String dni;
    private final String nombre;
    private final String apellido;
    private final String fechaNacimiento;
    private final String sexo;
    private final String fechaRegistro;
    private final String telefono;
    private final String direccion;

    public Paciente(int idCliente, String dni, String nombre, String apellido, String fechaNacimiento, String sexo,
                    String fechaRegistro, String telefono, String direccion) {
        this.idCliente = idCliente;
        this.dni = dni;
        this.nombre = nombre;
        this.apellido = apellido;
        this.fechaNacimiento = fechaNacimiento;
        this.sexo = sexo;
        this.fechaRegistro = fechaRegistro;
        this.telefono = telefono;
        this.direccion = direccion;
    }

    public Paciente() {
        this.idCliente = 0;
        this.dni = "";
        this.nombre = "";
        this.apellido = "";
        this.fechaNacimiento = "";
        this.sexo = "";
        this.fechaRegistro = "";
        this.telefono = "";
        this.direccion = "";
    }

    @Override
    public String toString() {
        return Joiner.on(", ").join(
                "ID Cliente: " + idCliente,
                "DNI: " + dni,
                "Nombre: " + nombre,
                "Apellido: " + apellido,
                "Fecha de Nacimiento: " + fechaNacimiento,
                "Sexo: " + sexo,
                "Fecha de Registro: " + fechaRegistro,
                "Teléfono: " + telefono,
                "Dirección: " + direccion
        );
    }

    public int getIdCliente() { return idCliente; }
    public String getDni() { return dni; }
    public String getNombre() { return nombre; }
    public String getApellido() { return apellido; }
    public String getFechaNacimiento() { return fechaNacimiento; }
    public String getSexo() { return sexo; }
    public String getFechaRegistro() { return fechaRegistro; }
    public String getTelefono() { return telefono; }
    public String getDireccion() { return direccion; }
}