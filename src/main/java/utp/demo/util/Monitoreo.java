package utp.demo.util;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.logging.Logger;

public class Monitoreo {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");


    public static void verificarUsoRAM() {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(Runtime.getRuntime().exec("free -m").getInputStream()))) {
            reader.readLine();
            String[] ramInfo = reader.readLine().split("\\s+");
            double totalRAM = Double.parseDouble(ramInfo[1]);
            double usedRAM = Double.parseDouble(ramInfo[2]);
            double availableRAM = Double.parseDouble(ramInfo[6]);
            double usedPercentage = ((totalRAM - availableRAM) / totalRAM) * 100;
            if (usedPercentage > 90) {
                String mensaje = "ALERTA: Uso de RAM supera el 90% (" + usedPercentage + "%). Usada: " + usedRAM + "MB, Disponible: " + availableRAM + "MB.";
                logger.severe(mensaje);
                enviarCorreo("Alerta de Uso de RAM", mensaje);
            }
        } catch (Exception e) {
            logger.warning("Error al verificar el uso de RAM: " + e.getMessage());
        }
    }

    public static void verificarServicioNginx() {
        try {
            Process proceso = Runtime.getRuntime().exec("systemctl is-active nginx");
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(proceso.getInputStream()))) {
                String estado = reader.readLine().trim();
                if (!"active".equalsIgnoreCase(estado)) {
                    String mensaje = "No responde. Estado actual: " + estado;
                    enviarCorreo("ALERTA: Servicio Nginx", mensaje);
                }
            }
        } catch (Exception e) {
            logger.warning("Error al verificar el servicio Nginx: " + e.getMessage());
        }
    }


    public static void verificarCargaCPU() {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(Runtime.getRuntime().exec("uptime").getInputStream()))) {
            double cargaPromedio = Double.parseDouble(reader.readLine().split("load average:")[1].split(",")[0]);
            double umbralCarga = Runtime.getRuntime().availableProcessors() * 0.5;
            if (cargaPromedio > umbralCarga) {
                String mensaje = "ALERTA: Carga de CPU (" + cargaPromedio + ") supera el umbral (" + umbralCarga + ")";
                logger.severe(mensaje);
                enviarCorreo("Alerta de Carga de CPU", mensaje);
            }
        } catch (Exception e) {
            logger.warning("Error al verificar la carga de CPU: " + e);
        }
    }

    public static void verificarEspacioDisco() {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(Runtime.getRuntime().exec("df -h /").getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.startsWith("/")) {
                    String[] diskInfo = line.split("\\s+");
                    double usedPercentage = Double.parseDouble(diskInfo[4].replace("%", ""));
                    if (usedPercentage > 90) {
                        String mensaje = "ALERTA: Menos del 10% de espacio libre en disco. Espacio usado: " + usedPercentage + "%";
                        logger.severe(mensaje);
                        enviarCorreo("Alerta de Espacio en Disco", mensaje);
                    }
                }
            }
        } catch (Exception e) {
            logger.warning("Error al verificar el espacio en disco: " + e);
        }
    }

    private static void enviarCorreo(String subject, String mensaje) {
        String username = "unionlabclinico@gmail.com";
        String appPassword = "kwbi cder rivk nyqk";
        try {
            HtmlEmail email = new HtmlEmail();
            email.setHostName("smtp.gmail.com");
            email.setSmtpPort(587);
            email.setAuthenticator(new DefaultAuthenticator(username, appPassword));
            email.setSSLOnConnect(true);
            email.setFrom(username);
            email.setSubject(subject);
            email.setMsg(mensaje);
            email.addTo("jhonatanhernandezperez4f@gmail.com");
            email.send();
        } catch (EmailException e) {
            logger.warning("Error al enviar el correo: " + e.getMessage());
        }
    }
}