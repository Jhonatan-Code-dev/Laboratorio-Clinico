package utp.demo.business.email;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import java.util.logging.Logger;

public class EnviarResultadosPaciente {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");

    public static void enviarNotificacion(String nombreCliente, String correoCliente, String nombreAnalisis, String rutaResultado) {
        String username = "unionlabclinico@gmail.com";
        String appPassword = "kwbi cder rivk nyqk";
        try {
            HtmlEmail email = new HtmlEmail();
            email.setHostName("smtp.gmail.com");
            email.setSmtpPort(587);
            email.setAuthenticator(new DefaultAuthenticator(username, appPassword));
            email.setSSLOnConnect(true);
            email.setFrom(username);
            email.setSubject("Resultado de tu análisis - UnionLab Clínico");
            String mensaje = "<html><body>"
                    + "<h3>Estimado/a " + nombreCliente + ",</h3>"
                    + "<p>Te informamos que el resultado de tu análisis <strong>" + nombreAnalisis + "</strong> ya está disponible.</p>"
                    + "<p>Para acceder al resultado, por favor haz clic en el siguiente enlace:</p>"
                    + "<p><a href=\"https://www.unionlab.online/archivos/" + rutaResultado + "\">Ver resultado del análisis</a></p>"
                    + "<p>Atentamente,<br>UnionLab Clínico</p>"
                    + "</body></html>";
            email.setMsg(mensaje);
            email.addTo(correoCliente);
            email.send();
        } catch (EmailException e) {
            logger.warning("ERROR EN LA CLASE BUSINESS-EnviarResultadosPaciente: " + e);
        }
    }
}