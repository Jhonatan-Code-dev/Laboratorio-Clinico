package utp.demo.model;

import java.util.ArrayList;
import java.util.List;

public class ResultadoCita {

    private int idCita;
    private String nombreCompleto;
    private String dniCliente;
    private String analisisMuestras;

    public ResultadoCita(int idCita, String nombreCompleto, String dniCliente, String analisisMuestras) {
        this.idCita = idCita;
        this.nombreCompleto = nombreCompleto;
        this.dniCliente = dniCliente;
        this.analisisMuestras = analisisMuestras;
    }

    public int getIdCita() {
        return idCita;
    }

    public void setIdCita(int idCita) {
        this.idCita = idCita;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public String getDniCliente() {
        return dniCliente;
    }

    public void setDniCliente(String dniCliente) {
        this.dniCliente = dniCliente;
    }

    public String getAnalisisMuestras() {
        return analisisMuestras;
    }

    public void setAnalisisMuestras(String analisisMuestras) {
        this.analisisMuestras = analisisMuestras;
    }

    public List<Analisis> parseAnalisis() {
        List<Analisis> analisisList = new ArrayList<>();
        String[] analisisArray = analisisMuestras.split(";");

        for (String analisis : analisisArray) {
            String[] parts = analisis.split(",");
            if (parts.length == 3) {
                String[] idNombre = parts[0].split(":");
                String idMuestra = idNombre[0].trim();
                String nombreAnalisis = idNombre[1].trim();
                String fechaMuestra = parts[1].trim();
                String estado = parts[2].trim();

                analisisList.add(new Analisis(idMuestra, nombreAnalisis, fechaMuestra, estado));
            }
        }
        return analisisList;
    }

    public static class Analisis {
        private String idMuestra;
        private String nombreAnalisis;
        private String fechaMuestra;
        private String estado;

        public Analisis(String idMuestra, String nombreAnalisis, String fechaMuestra, String estado) {
            this.idMuestra = idMuestra;
            this.nombreAnalisis = nombreAnalisis;
            this.fechaMuestra = fechaMuestra;
            this.estado = estado;
        }

        public String getIdMuestra() {
            return idMuestra;
        }

        public String getNombreAnalisis() {
            return nombreAnalisis;
        }

        public String getFechaMuestra() {
            return fechaMuestra;
        }

        public String getEstado() {
            return estado;
        }
    }
}