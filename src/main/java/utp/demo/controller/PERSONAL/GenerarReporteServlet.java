package utp.demo.controller.PERSONAL;

import utp.demo.business.ReporteCita;
import utp.demo.DAO.PERSONAL.GenerarReporteDAO;
import utp.demo.model.Reporte;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import com.itextpdf.text.DocumentException;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/GenerarReporte")
public class GenerarReporteServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
    //SERVLET PARA GENERAR REPORTE
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Reporte> reportes = GenerarReporteDAO.generarReporteCitasAprobadas();
            request.setAttribute("reportes", reportes);
            request.getRequestDispatcher("/PERSONAL/generar-reportes.jsp").forward(request, response);
        }catch (Exception e){
            logger.warning("ERROR EN LA CLASE PERSONAL-GenerarReporteServlet: " + e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        try {
            String action = request.getParameter("action");
            List<Reporte> reportes = GenerarReporteDAO.generarReporteCitasAprobadas();
            String baseDir = getServletContext().getRealPath("/") + "descarga/";
            File dir = new File(baseDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            if ("export_excel".equals(action)) {
                String filePath = baseDir + "reporte.xlsx";
                try {
                    ReporteCita.generarReporteExcel(reportes, filePath);
                    enviarArchivo(response, filePath, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "reporte.xlsx");
                } catch (IOException e) {

                }
            } else if ("export_pdf".equals(action)) {
                String filePath = baseDir + "reporte.pdf";
                try {
                    ReporteCita.generarReportePdf(reportes, filePath);
                    enviarArchivo(response, filePath, "application/pdf", "reporte.pdf");
                } catch (DocumentException | IOException e) {
                    logger.warning("ERROR EN LA CLASE PERSONAL-GenerarReporteServlet-EXPORT: " + e);
                }
            } else {
                doGet(request, response);
            }
        }catch (Exception e){
            logger.warning("ERROR EN LA CLASE PERSONAL-GenerarReporteServlet: " + e);
        }
    }

    private void enviarArchivo(HttpServletResponse response, String filePath, String mimeType, String fileName) throws IOException {
        try {
            File file = new File(filePath);
            try (FileInputStream fileInputStream = new FileInputStream(file);
                 OutputStream outputStream = response.getOutputStream()) {
                response.setContentType(mimeType);
                response.setContentLength((int) file.length());
                response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = fileInputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            }
        }catch (Exception e){
            logger.warning("ERROR EN LA CLASE PERSONAL-GenerarReporteServlet-ENVIAR-ARCHIVO: " + e);
        }
    }
}