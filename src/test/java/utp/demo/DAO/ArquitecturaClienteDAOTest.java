package utp.demo.DAO;

import com.tngtech.archunit.core.domain.JavaClasses;
import com.tngtech.archunit.core.importer.ClassFileImporter;
import org.junit.jupiter.api.Test;
import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.classes;
import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.noClasses;

public class ArquitecturaClienteDAOTest {

    private JavaClasses clases = new ClassFileImporter().importPackages("utp.demo.DAO.CLIENTE");

    @Test
    void todasLasClasesDebenSerPublicasEnClienteDAO() {
        classes()
                .that().resideInAPackage("..DAO.CLIENTE..")
                .should().bePublic()
                .check(clases);
        System.out.println("Regla 1 verificada: Todas las clases en 'CLIENTE DAO' son públicas.");
    }

    @Test
    void lasClasesDeClienteDAONoDebenDependerDePresentacion() {
        noClasses()
                .that().resideInAPackage("..DAO.CLIENTE..")
                .should().dependOnClassesThat().resideInAPackage("..webapp..")
                .check(clases);
        System.out.println("Regla 2 verificada: No hay dependencias entre 'CLIENTE DAO' y la capa de presentación.");
    }

    @Test
    void lasClasesDeClienteDAONoDebenDependerDeUI() {
        noClasses()
                .that().resideInAPackage("..DAO.CLIENTE..")
                .should().dependOnClassesThat().resideInAPackage("..controller..")
                .check(clases);
        System.out.println("Regla 3 verificada: No hay dependencias entre 'CLIENTE DAO' y la capa UI.");
    }

    @Test
    void lasClasesDeClienteDAONoDebenDependerDeNegocio() {
        noClasses()
                .that().resideInAPackage("..DAO.CLIENTE..")
                .should().dependOnClassesThat().resideInAPackage("..business..")
                .check(clases);
        System.out.println("Regla 4 verificada: No hay dependencias entre 'CLIENTE DAO' y la capa de negocio.");
    }
}