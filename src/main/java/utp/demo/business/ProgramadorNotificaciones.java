package utp.demo.business;

import utp.demo.DAO.NOTIFICACION.NotifiacionResultadosDAO;
import utp.demo.DAO.NOTIFICACION.NotificacionDAO;
import utp.demo.util.Monitoreo;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

@WebListener
public class ProgramadorNotificaciones implements ServletContextListener {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.scheduleAtFixedRate(() -> {
            try {
                NotificacionDAO.notificarCitasAprobadas();
                NotifiacionResultadosDAO.obtenerResultadosYRegistrarEnvio();
                Monitoreo.verificarCargaCPU();
                Monitoreo.verificarEspacioDisco();
            } catch (Exception e) {
                logger.warning("ERROR EN LA CLASE BUSINESS-ProgramadorNotificaciones: " + e);
            }
        }, 0, 1, TimeUnit.MINUTES);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null) {
            scheduler.shutdown();
        }
    }
}