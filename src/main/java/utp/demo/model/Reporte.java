package utp.demo.model;

import com.google.common.base.MoreObjects;
import com.google.common.base.Objects;

public class Reporte {
    private final String dni;
    private final String nombreCompleto;
    private final String fechaCita;
    private final String estado;
    private final String mesAnio;

    public Reporte(String dni, String nombreCompleto, String fechaCita, String estado, String mesAnio) {
        this.dni = dni;
        this.nombreCompleto = nombreCompleto;
        this.fechaCita = fechaCita;
        this.estado = estado;
        this.mesAnio = mesAnio;
    }

    public String getDni() {
        return dni;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public String getFechaCita() {
        return fechaCita;
    }

    public String getEstado() {
        return estado;
    }

    public String getMesAnio() {
        return mesAnio;
    }

    @Override
    public String toString() {
        return MoreObjects.toStringHelper(this)
                .add("DNI", dni)
                .add("NombreCompleto", nombreCompleto)
                .add("FechaCita", fechaCita)
                .add("Estado", estado)
                .add("MesAnio", mesAnio)
                .toString();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Reporte reporte = (Reporte) o;
        return Objects.equal(dni, reporte.dni) &&
                Objects.equal(nombreCompleto, reporte.nombreCompleto) &&
                Objects.equal(fechaCita, reporte.fechaCita) &&
                Objects.equal(estado, reporte.estado) &&
                Objects.equal(mesAnio, reporte.mesAnio);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(dni, nombreCompleto, fechaCita, estado, mesAnio);
    }
}