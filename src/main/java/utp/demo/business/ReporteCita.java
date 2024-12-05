package utp.demo.business;

import utp.demo.model.Reporte;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

public class ReporteCita {
    private static final Logger logger = Logger.getLogger("utp.demo.formview");
   //METODO PARA GENERAR REPORTES EN EXEL
    public static void generarReporteExcel(List<Reporte> reportes, String filePath) throws IOException {
        try {
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Reporte de Citas");
            String[] header = {"DNI", "Nombre Completo", "Fecha Cita", "Estado", "Mes/Año"};
            Row headerRow = sheet.createRow(0);
            for (int i = 0; i < header.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(header[i]);
                CellStyle style = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBold(true);
                style.setFont(font);
                cell.setCellStyle(style);
            }
            int rowNum = 1;
            for (Reporte reporte : reportes) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(reporte.getDni());
                row.createCell(1).setCellValue(reporte.getNombreCompleto());
                row.createCell(2).setCellValue(reporte.getFechaCita());
                row.createCell(3).setCellValue(reporte.getEstado());
                row.createCell(4).setCellValue(reporte.getMesAnio());
            }
            for (int i = 0; i < header.length; i++) {
                sheet.autoSizeColumn(i);
            }
            try (FileOutputStream fileOut = new FileOutputStream(filePath)) {
                workbook.write(fileOut);
            }
            workbook.close();
        }catch (Exception e){
            logger.warning("ERROR EN LA CLASE BUSINESS-ReporteCita: " + e);
        }
    }

    //METODO PARA GENERAR REPORTES EN PDF
    public static void generarReportePdf(List<Reporte> reportes, String filePath) throws DocumentException, IOException {
        try {
            Document document = new Document();
            PdfWriter.getInstance(document, new FileOutputStream(filePath));
            document.open();
            document.add(new Paragraph("Reporte de Citas Aprobadas", new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.HELVETICA, 18, com.itextpdf.text.Font.BOLD)));
            document.add(new Paragraph(" "));
            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10f);
            float[] columnWidths = {1, 3, 2, 1, 2};
            table.setWidths(columnWidths);

            addTableHeader(table, "DNI");
            addTableHeader(table, "Nombre Completo");
            addTableHeader(table, "Fecha Cita");
            addTableHeader(table, "Estado");
            addTableHeader(table, "Mes/Año");

            for (Reporte reporte : reportes) {
                table.addCell(new PdfPCell(new Phrase(reporte.getDni())));
                table.addCell(new PdfPCell(new Phrase(reporte.getNombreCompleto())));
                table.addCell(new PdfPCell(new Phrase(reporte.getFechaCita())));
                table.addCell(new PdfPCell(new Phrase(reporte.getEstado())));
                table.addCell(new PdfPCell(new Phrase(reporte.getMesAnio())));
            }

            document.add(table);
            document.close();
        }catch (Exception e){
            logger.warning("ERROR EN LA CLASE BUSINESS-ReporteCita: " + e);
        }
    }

    private static void addTableHeader(PdfPTable table, String headerTitle) {
        PdfPCell header = new PdfPCell();
        header.setHorizontalAlignment(Element.ALIGN_CENTER);
        header.setPhrase(new Phrase(headerTitle));
        table.addCell(header);
    }
}