package utp.demo.util;

import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;

public class ContadorUsuariosActivos {
    private static final AtomicInteger usuariosActivos = new AtomicInteger(0);
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    public static void incrementar() {
        int totalUsuarios = usuariosActivos.incrementAndGet();
        if (totalUsuarios >= 90) {
            logger.info("ALERTA: El número de usuarios activos alcanzó o superó los 90. Total actual: " + totalUsuarios);
        }
    }

    public static void decrementar() {
        usuariosActivos.decrementAndGet();
    }
}