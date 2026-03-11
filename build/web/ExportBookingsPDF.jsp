<%@ page import="java.sql.*, java.io.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*, com.itextpdf.text.pdf.draw.LineSeparator" %>
<%@ page import="com.itextpdf.text.Image" %>
<%@ page contentType="application/pdf" %>

<%
    // --- Get filter parameters ---
    String monthParam = request.getParameter("month"); 
    String dateParam = request.getParameter("date");   

    boolean hasMonth = (monthParam != null && !monthParam.isEmpty());
    boolean hasDate = (dateParam != null && !dateParam.isEmpty());

    int year = 0, month = 0;
    if(hasMonth && !hasDate){
        String[] parts = monthParam.split("-");
        year = Integer.parseInt(parts[0]);
        month = Integer.parseInt(parts[1]);
    }
%>

<%
    response.setHeader("Content-Disposition", "attachment; filename=Ridesync_Bookings_Report.pdf");

    Document document = new Document(PageSize.A4, 40, 40, 50, 30);
    PdfWriter.getInstance(document, response.getOutputStream());
    document.open();

    // --- Fonts ---
    Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20, BaseColor.DARK_GRAY);
    Font subtitleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, BaseColor.BLACK);
    Font regularFont = FontFactory.getFont(FontFactory.HELVETICA, 12);
    Font smallFont = FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 10, BaseColor.GRAY);

    // --- Logo ---
    try {
        String logoPath = application.getRealPath("/") + "images/logo.png";
        Image logo = Image.getInstance(logoPath);
        logo.scaleAbsolute(80, 80);
        logo.setAlignment(Image.ALIGN_CENTER);
        document.add(logo);
    } catch (Exception e) {
        document.add(new Paragraph("[Logo Missing]", smallFont));
    }

    // --- Title ---
    Paragraph title = new Paragraph("Ridesync - Bookings Report", titleFont);
    title.setAlignment(Element.ALIGN_CENTER);
    document.add(title);

    document.add(new Paragraph(" "));
    document.add(new LineSeparator());
    document.add(new Paragraph(" "));

    Connection conn = null;
    PreparedStatement psSummary = null, psBookings = null, psRefund = null;
    ResultSet rsSummary = null, rsBookings = null, rsRefund = null;

    int totalBookings = 0;
    double totalRevenue = 0.0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

        // --- Summary Query ---
        String summarySQL = "SELECT COUNT(*) AS total, IFNULL(SUM(total_amount),0) AS revenue FROM bookings WHERE 1=1";
        if(hasDate){
            summarySQL += " AND DATE(travel_date) = ?";
        } else if(hasMonth){
            summarySQL += " AND YEAR(travel_date) = ? AND MONTH(travel_date) = ?";
        }

        psSummary = conn.prepareStatement(summarySQL);
        if(hasDate){
            psSummary.setDate(1, java.sql.Date.valueOf(dateParam));
        } else if(hasMonth){
            psSummary.setInt(1, year);
            psSummary.setInt(2, month);
        }

        rsSummary = psSummary.executeQuery();
        if(rsSummary.next()){
            totalBookings = rsSummary.getInt("total");
            totalRevenue = rsSummary.getDouble("revenue");

            // --- filter
            String refundSQL = "SELECT IFNULL(SUM(r.refund_amount),0) AS refund_sum FROM refunds r JOIN bookings b ON r.booking_id=b.id WHERE 1=1";
            if(hasDate){
                refundSQL += " AND DATE(b.travel_date) = ?";
            } else if(hasMonth){
                refundSQL += " AND YEAR(b.travel_date) = ? AND MONTH(b.travel_date) = ?";
            }

            psRefund = conn.prepareStatement(refundSQL);
            if(hasDate){
                psRefund.setDate(1, java.sql.Date.valueOf(dateParam));
            } else if(hasMonth){
                psRefund.setInt(1, year);
                psRefund.setInt(2, month);
            }

            rsRefund = psRefund.executeQuery();
            if(rsRefund.next()){
                totalRevenue -= rsRefund.getDouble("refund_sum");
            }
        }

        // summary
        Paragraph summaryTitle = new Paragraph("Summary", subtitleFont);
        summaryTitle.setAlignment(Element.ALIGN_LEFT);
        document.add(summaryTitle);

        document.add(new Paragraph("Total Bookings: " + totalBookings, regularFont));
        document.add(new Paragraph("Total Revenue: ?" + String.format("%.2f", totalRevenue), regularFont));
        document.add(new Paragraph(" "));
        document.add(new LineSeparator());
        document.add(new Paragraph(" "));

        // --- Detailed Bookings Query ---
        String bookingSQL = "SELECT id, user_email, bus_name, travel_date, total_amount FROM bookings WHERE 1=1";
        if(hasDate){
            bookingSQL += " AND DATE(travel_date) = ?";
        } else if(hasMonth){
            bookingSQL += " AND YEAR(travel_date) = ? AND MONTH(travel_date) = ?";
        }
        bookingSQL += " ORDER BY created_at DESC";

        psBookings = conn.prepareStatement(bookingSQL);
        if(hasDate){
            psBookings.setDate(1, java.sql.Date.valueOf(dateParam));
        } else if(hasMonth){
            psBookings.setInt(1, year);
            psBookings.setInt(2, month);
        }

        rsBookings = psBookings.executeQuery();

        // --- PDF Table ---
        Paragraph listTitle = new Paragraph("Detailed Bookings", subtitleFont);
        listTitle.setAlignment(Element.ALIGN_LEFT);
        document.add(listTitle);

        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setWidths(new float[]{1f, 3f, 2f, 2f, 2f});

        String[] headers = {"ID", "User Email", "Bus Name", "Travel Date", "Total Amount"};
        for(String h : headers){
            PdfPCell cell = new PdfPCell(new Phrase(h, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12)));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
            cell.setPadding(6f);
            table.addCell(cell);
        }

        while(rsBookings.next()){
            table.addCell(new Phrase(String.valueOf(rsBookings.getInt("id")), regularFont));
            table.addCell(new Phrase(rsBookings.getString("user_email"), regularFont));
            table.addCell(new Phrase(rsBookings.getString("bus_name"), regularFont));
            table.addCell(new Phrase(rsBookings.getDate("travel_date").toString(), regularFont));
            table.addCell(new Phrase("?" + rsBookings.getDouble("total_amount"), regularFont));
        }

        document.add(table);

    } catch(Exception e){
        document.add(new Paragraph("Error generating report: " + e.getMessage(), smallFont));
    } finally {
        if(rsBookings != null) rsBookings.close();
        if(rsSummary != null) rsSummary.close();
        if(rsRefund != null) rsRefund.close();
        if(psBookings != null) psBookings.close();
        if(psSummary != null) psSummary.close();
        if(psRefund != null) psRefund.close();
        if(conn != null) conn.close();
    }

    // --- Footer ---
    document.add(new Paragraph(" "));
    document.add(new LineSeparator());
    document.add(new Paragraph(" "));
    Paragraph footer = new Paragraph("Ridesync Admin Report", smallFont);
    footer.setAlignment(Element.ALIGN_CENTER);
    document.add(footer);

    document.close();
%>
