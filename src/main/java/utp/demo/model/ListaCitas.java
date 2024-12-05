package utp.demo.model;

import java.util.Date;

public class ListaCitas {
    private int idCliente;
    private String dni;
    private String nombreCompleto;
    private int idCita;
    private Date fecHora;
    private String estadoCita;
    private int idAnalisisCita;
    private int idAnalisis;
    private String nombreAnalisis;
    private String estadoAnalisis;

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

    public Date getFecHora() {
        return fecHora;
    }

    public void setFecHora(Date fecHora) {
        this.fecHora = fecHora;
    }

    public String getEstadoCita() {
        return estadoCita;
    }

    public void setEstadoCita(String estadoCita) {
        this.estadoCita = estadoCita;
    }

    public int getIdAnalisisCita() {
        return idAnalisisCita;
    }

    public void setIdAnalisisCita(int idAnalisisCita) {
        this.idAnalisisCita = idAnalisisCita;
    }

    public int getIdAnalisis() {
        return idAnalisis;
    }

    public void setIdAnalisis(int idAnalisis) {
        this.idAnalisis = idAnalisis;
    }

    public String getNombreAnalisis() {
        return nombreAnalisis;
    }

    public void setNombreAnalisis(String nombreAnalisis) {
        this.nombreAnalisis = nombreAnalisis;
    }

    public String getEstadoAnalisis() {
        return estadoAnalisis;
    }

    public void setEstadoAnalisis(String estadoAnalisis) {
        this.estadoAnalisis = estadoAnalisis;
    }
}