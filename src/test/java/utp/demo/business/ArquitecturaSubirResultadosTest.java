package utp.demo.business;

import com.tngtech.archunit.core.domain.JavaClasses;
import com.tngtech.archunit.core.importer.ClassFileImporter;
import org.junit.jupiter.api.Test;
import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.noClasses;

public class ArquitecturaSubirResultadosTest {

    private JavaClasses clases = new ClassFileImporter().importPackages("utp.demo");

    @Test
    void claseSubirResultadosNoDebeDependerDePresentacion() {
        noClasses()
                .that().resideInAPackage("..business..")
                .should().dependOnClassesThat().resideInAPackage("..controller..")
                .check(clases);
    }

    @Test
    void lasClasesDeBusinessNoDebenDependenderDeUI() {
        noClasses()
                .that().resideInAPackage("..business..")
                .should().dependOnClassesThat().resideInAPackage("..webapp..")
                .check(clases);
    }
}