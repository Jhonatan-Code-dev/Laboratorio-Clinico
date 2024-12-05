package utp.demo.model;

import com.google.common.base.Joiner;
import com.google.common.base.Preconditions;

public class Cita {
    private final int id;
    private final int idCliente;
    private final String fecHora;
    private final String estado;

    public Cita(int id, int idCliente, String fecHora, String estado) {
        Preconditions.checkArgument(id > 0, "El id debe ser mayor que 0");
        Preconditions.checkArgument(idCliente > 0, "El idCliente debe ser mayor que 0");
        Preconditions.checkArgument(fecHora != null && !fecHora.trim().isEmpty(), "La fecha y hora no puede ser nula o vacía");

        this.id = id;
        this.idCliente = idCliente;
        this.fecHora = fecHora;
        this.estado = estado;
    }

    public int getId() {
        return id;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public String getFecHora() {
        return fecHora;
    }

    public String getEstado() {
        return estado;
    }

    @Override
    public String toString() {
        return "Cita{" +
                Joiner.on(", ").join(
                        "id=" + id,
                        "idCliente=" + idCliente,
                        "fecHora='" + fecHora + '\'' +
                                ", estado=" + (estado != null ? estado : "No proporcionado")
                ) +
                '}';
    }
}