package utp.demo.model;

import java.util.Objects;
import java.util.StringJoiner;

public class HistoriaPaciente {
    private int idCita;
    private String fechaCita;
    private String analisis;

    public HistoriaPaciente(int idCita, String fechaCita, String analisis) {
        this.idCita = idCita;
        this.fechaCita = fechaCita;
        this.analisis = analisis;
    }

    public int getIdCita() {
        return idCita;
    }

    public void setIdCita(int idCita) {
        this.idCita = idCita;
    }

    public String getFechaCita() {
        return fechaCita;
    }

    public void setFechaCita(String fechaCita) {
        this.fechaCita = fechaCita;
    }

    public String getAnalisis() {
        return analisis;
    }

    public void setAnalisis(String analisis) {
        this.analisis = analisis;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", "Cita [", "]")
                .add("ID: " + idCita)
                .add("Fecha: " + fechaCita)
                .add("Análisis: " + analisis)
                .toString();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        HistoriaPaciente that = (HistoriaPaciente) o;
        return idCita == that.idCita &&
                Objects.equals(fechaCita, that.fechaCita) &&
                Objects.equals(analisis, that.analisis);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idCita, fechaCita, analisis);
    }
}