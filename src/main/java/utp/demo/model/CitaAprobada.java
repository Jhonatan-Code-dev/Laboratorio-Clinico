package utp.demo.model;

import java.sql.Timestamp;

public class CitaAprobada {

    private int idCliente;
    private String dni;
    private String nombreCompleto;
    private int idCita;
    private Timestamp fechaHora;
    private String analisisConId;
    private String estadosAnalisis;

    public CitaAprobada(int idCliente, String dni, String nombreCompleto, int idCita, Timestamp fechaHora, String analisisConId, String estadosAnalisis) {
        this.idCliente = idCliente;
        this.dni = dni;
        this.nombreCompleto = nombreCompleto;
        this.idCita = idCita;
        this.fechaHora = fechaHora;
        this.analisisConId = analisisConId;
        this.estadosAnalisis = estadosAnalisis;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public int getIdCita() {
        return idCita;
    }

    public void setIdCita(int idCita) {
        this.idCita = idCita;
    }

    public Timestamp getFechaHora() {
        return fechaHora;
    }

    public void setFechaHora(Timestamp fechaHora) {
        this.fechaHora = fechaHora;
    }


    public String getAnalisisConId() {
        return analisisConId;
    }

    public void setAnalisisConId(String analisisConId) {
        this.analisisConId = analisisConId;
    }

    public String getEstadosAnalisis() {
        return estadosAnalisis;
    }

    public void setEstadosAnalisis(String estadosAnalisis) {
        this.estadosAnalisis = estadosAnalisis;
    }
}