<%@ page import="java.sql.*, java.io.*, java.text.SimpleDateFormat, java.util.Date, com.itextpdf.text.*, com.itextpdf.text.pdf.*" %>
<%
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", "attachment; filename=BusesReport.pdf");

    Document document = new Document(PageSize.A4, 40, 40, 50, 50);
    PdfWriter.getInstance(document, response.getOutputStream());
    document.open();

    // ========== Add Logo ==========
    try {
        String logoPath = application.getRealPath("/") + "images/logo.png"; // adjust path if needed
        Image logo = Image.getInstance(logoPath);
        logo.scaleAbsolute(80, 80);
        logo.setAlignment(Image.ALIGN_CENTER);
        document.add(logo);
    } catch (Exception e) {
        Paragraph missingLogo = new Paragraph("[Logo Missing]",
                FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 10, BaseColor.GRAY));
        missingLogo.setAlignment(Element.ALIGN_CENTER);
        document.add(missingLogo);
    }

    // ========== Title ==========
    Paragraph title = new Paragraph("Ridesync - Bus Report\n\n",
            FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.BLACK));
    title.setAlignment(Element.ALIGN_CENTER);
    document.add(title);

    Paragraph subtitle = new Paragraph("Detailed list of all buses\n\n",
            FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.DARK_GRAY));
    subtitle.setAlignment(Element.ALIGN_CENTER);
    document.add(subtitle);

    // Timestamp
    String dateStr = new SimpleDateFormat("dd MMM yyyy, hh:mm a").format(new Date());
    Paragraph date = new Paragraph("Generated on: " + dateStr + "\n\n",
            FontFactory.getFont(FontFactory.HELVETICA, 10, BaseColor.GRAY));
    date.setAlignment(Element.ALIGN_RIGHT);
    document.add(date);

    // ====== Fetch Data ======
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM bus_details");

        int count = 0;
        int totalSeats = 0;
        int totalAvailable = 0;

        while (rs.next()) {
            count++;
            totalSeats += rs.getInt("total_seats");
            totalAvailable += rs.getInt("available_seats");

            // Create a bordered card for each bus
            PdfPTable busTable = new PdfPTable(2);
            busTable.setWidthPercentage(100);
            busTable.setSpacingBefore(10f);
            busTable.setSpacingAfter(10f);
            busTable.getDefaultCell().setBorder(Rectangle.NO_BORDER);

            PdfPCell headerCell = new PdfPCell(
                new Phrase("Bus #" + rs.getInt("bus_id") + " - " + rs.getString("bus_name"),
                FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE))
            );
            headerCell.setColspan(2);
            headerCell.setBackgroundColor(BaseColor.GRAY); // changed to grey
            headerCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            headerCell.setPadding(6);
            busTable.addCell(headerCell);

            busTable.addCell("Route From:");
            busTable.addCell(rs.getString("route_from"));

            busTable.addCell("Route To:");
            busTable.addCell(rs.getString("route_to"));

            busTable.addCell("Departure:");
            busTable.addCell(rs.getTime("departure_time").toString());

            busTable.addCell("Arrival:");
            busTable.addCell(rs.getTime("arrival_time").toString());

            busTable.addCell("Total Seats:");
            busTable.addCell(String.valueOf(rs.getInt("total_seats")));

            busTable.addCell("Available Seats:");
            busTable.addCell(String.valueOf(rs.getInt("available_seats")));

            busTable.addCell("Ticket Price:");
            busTable.addCell("?" + rs.getBigDecimal("price"));

            document.add(busTable);
        }

        // ===== Summary at bottom =====
        Paragraph summary = new Paragraph("\nSummary\n",
                FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, BaseColor.BLACK));
        summary.setAlignment(Element.ALIGN_CENTER);
        document.add(summary);

        PdfPTable summaryTable = new PdfPTable(2);
        summaryTable.setWidthPercentage(60);
        summaryTable.setHorizontalAlignment(Element.ALIGN_CENTER);
        summaryTable.setSpacingBefore(10f);

        summaryTable.addCell("Total Buses:");
        summaryTable.addCell(String.valueOf(count));

        summaryTable.addCell("Total Seats:");
        summaryTable.addCell(String.valueOf(totalSeats));

        summaryTable.addCell("Total Available Seats:");
        summaryTable.addCell(String.valueOf(totalAvailable));

        document.add(summaryTable);

        // Footer
        Paragraph footer = new Paragraph("\nThis is a system-generated report from Ridesync.",
                FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 9, BaseColor.GRAY));
        footer.setAlignment(Element.ALIGN_CENTER);
        document.add(footer);

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }

    document.close();
%>
