package utp.demo.model;

import nl.jqno.equalsverifier.EqualsVerifier;
public class ImportanteTest {

    @org.junit.Test
    public void testEqualsAndHashCode() {
        //clase analisis
        EqualsVerifier.simple().forClass(Analisis.class).verify();
    }
    @org.junit.Test
    public void testEqualsAndHashCode2() {
        //clase cliente
        EqualsVerifier.simple().forClass(Cliente.class).verify();
    }
    @org.junit.Test
    public void testEqualsAndHashCodeHistorialAnalisis() {
        //clase HistorialAnalisis
        EqualsVerifier.simple().forClass(HistoriaPaciente.class).verify();
    }
    @org.junit.Test
    public void testEqualsAndHashCodeReporte() {
        //clase HistorialAnalisis
        EqualsVerifier.simple().forClass(Reporte.class).verify();
    }
}