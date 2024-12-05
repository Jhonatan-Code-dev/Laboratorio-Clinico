package utp.demo.business.email;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import utp.demo.DAO.NOTIFICACION.NotificacionDAO;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Logger;

public class EnviarGmailCita {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    public static void enviarNotificacionCita(String fechaHoraCita, String correoCliente, int idCita) {
        try {
            SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date fechaActual = new Date();
            Date fechaCita = formatoFecha.parse(fechaHoraCita);
            long diferenciaMillis = fechaCita.getTime() - fechaActual.getTime();
            long diferenciaHoras = diferenciaMillis / (1000 * 60 * 60);
            if (diferenciaHoras <= 2) {
                enviarCorreo(correoCliente);
                NotificacionDAO.notificarCita(idCita);
            }
        } catch (ParseException e) {
            logger.warning("ERROR EN LA CLASE BUSINESS-EnviarGmailCita: " + e);
        }
    }

    private static void enviarCorreo(String correoCliente) {
        String username = "unionlabclinico@gmail.com";
        String appPassword = "kwbi cder rivk nyqk";
        try {
            HtmlEmail email = new HtmlEmail();
            email.setHostName("smtp.gmail.com");
            email.setSmtpPort(587);
            email.setAuthenticator(new DefaultAuthenticator(username, appPassword));
            email.setSSLOnConnect(true);
            email.setFrom(username);
            email.setSubject("Recordatorio de Cita - UnionLab Clinico");
            email.setMsg("Estimado cliente, su cita está programada en menos de 2 horas. Por favor, recuerde asistir a su cita.");
            email.addTo(correoCliente);
            email.send();
        } catch (EmailException e) {
            logger.warning("ERROR EN LA CLASE BUSINESS-EnviarGmailCita: " + e);
        }
    }
}