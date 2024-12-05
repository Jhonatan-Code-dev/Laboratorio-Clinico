package utp.demo.model;

import com.google.common.base.Joiner;
import com.google.common.collect.ImmutableMap;
import java.util.Objects;

public class Analisis {
    private int id;
    private String nombre;
    private String descripcion;
    private String disponible;
    private String duracion;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getDisponible() {
        return disponible;
    }

    public void setDisponible(String disponible) {
        this.disponible = disponible;
    }

    public String getDuracion() {
        return duracion;
    }

    public void setDuracion(String duracion) {
        this.duracion = duracion;
    }

    @Override
    public String toString() {
        return "Analisis{" +
                "id=" + id +
                ", " + Joiner.on(", ").withKeyValueSeparator("='").join(
                ImmutableMap.of(
                        "nombre", nombre,
                        "descripcion", descripcion,
                        "disponible", disponible,
                        "duracion", duracion
                )
        ) + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Analisis analisis = (Analisis) o;
        return id == analisis.id &&
                Objects.equals(nombre, analisis.nombre) &&
                Objects.equals(descripcion, analisis.descripcion) &&
                Objects.equals(disponible, analisis.disponible) &&
                Objects.equals(duracion, analisis.duracion);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, nombre, descripcion, disponible, duracion);
    }
}