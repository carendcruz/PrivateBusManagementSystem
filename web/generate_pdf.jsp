<%@ page import="java.io.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*, com.itextpdf.text.pdf.draw.LineSeparator" %>
<%@ page import="com.itextpdf.text.Image" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="application/pdf" %>

<%
    String userEmail = request.getParameter("user_email");
    String cardName = request.getParameter("card_name");
    String busId = request.getParameter("bus_id");
    String busName = request.getParameter("bus_name");
    String departure = request.getParameter("departure");
    String destination = request.getParameter("destination");
    String date = request.getParameter("travel_date");
    String passengers = request.getParameter("passengers");
    String tax = request.getParameter("tax");
    String total = request.getParameter("total");
    String transactionId = request.getParameter("transaction_id");

    response.setHeader("Content-Disposition", "attachment; filename=Ridesync_Bill.pdf");

    Document document = new Document(PageSize.A5, 40, 40, 50, 30);
    PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
    document.open();

    // Fonts
    Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20, BaseColor.DARK_GRAY);
    Font subtitleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, BaseColor.BLACK);
    Font regularFont = FontFactory.getFont(FontFactory.HELVETICA, 12);
    Font smallFont = FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 10, BaseColor.GRAY);

    // ---------- Add Logo ----------
    try {
        String logoPath = application.getRealPath("/") + "images/logo.png"; // ensure path is correct
        Image logo = Image.getInstance(logoPath);
        logo.scaleAbsolute(80, 80);
        logo.setAlignment(Image.ALIGN_CENTER);
        document.add(logo);
    } catch (Exception e) {
        document.add(new Paragraph("[Logo Missing]", smallFont));
    }

    // ---------- Title ----------
    Paragraph title = new Paragraph("Ridesync Booking Receipt", titleFont);
    title.setAlignment(Element.ALIGN_CENTER);
    document.add(title);

    document.add(new Paragraph(" "));
    document.add(new LineSeparator());
    document.add(new Paragraph(" "));

    // ---------- Transaction ID ----------
    Paragraph trx = new Paragraph("Transaction ID: " + transactionId, subtitleFont);
    trx.setAlignment(Element.ALIGN_CENTER);
    document.add(trx);

    document.add(new Paragraph(" "));

    // ---------- Ticket Info ----------
    document.add(new Paragraph("Passenger Email: " + userEmail, regularFont));
    document.add(new Paragraph("Cardholder: " + cardName, regularFont));
    document.add(new Paragraph("Bus: " + busName + " (ID: " + busId + ")", regularFont));
    document.add(new Paragraph("Departure: " + departure, regularFont));
    document.add(new Paragraph("Destination: " + destination, regularFont));
    document.add(new Paragraph("Travel Date: " + date, regularFont));
    document.add(new Paragraph("Passengers: " + passengers, regularFont));
    document.add(new Paragraph("Tax: ?" + tax, regularFont));
    document.add(new Paragraph("Total Paid: ?" + total, regularFont));

    document.add(new Paragraph(" "));
    document.add(new LineSeparator());
    document.add(new Paragraph(" "));

    // ---------- QR Code ----------
    try {
        String qrText = "Transaction ID: " + transactionId + "\n" +
                        "Passenger: " + userEmail + "\n" +
                        "Bus: " + busName + "\n" +
                        "Date: " + date;

        BarcodeQRCode qrCode = new BarcodeQRCode(qrText, 100, 100, null);
        Image qrImage = qrCode.getImage();
        qrImage.setAlignment(Image.ALIGN_CENTER);
        document.add(qrImage);
    } catch (Exception e) {
        document.add(new Paragraph("[QR Code Failed to Load]", smallFont));
    }

    // ---------- Thank You ----------
    document.add(new Paragraph(" "));
    Paragraph thankYou = new Paragraph("Thank you for choosing Ridesync!", subtitleFont);
    thankYou.setAlignment(Element.ALIGN_CENTER);
    document.add(thankYou);

    Paragraph tagline = new Paragraph("Safe | Comfortable | On Time", smallFont);
    tagline.setAlignment(Element.ALIGN_CENTER);
    document.add(tagline);

    document.close();
%>
