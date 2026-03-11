<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<%
    String userEmail = (String) session.getAttribute("user_email");

    String cardName = request.getParameter("card_name");
    String totalPrice = request.getParameter("total");
    String tax = request.getParameter("tax");
    String date = request.getParameter("date");
    int passengers = Integer.parseInt(request.getParameter("passengers"));
    String busId = request.getParameter("bus_id");
    String busName = request.getParameter("bus_name");
    String departure = request.getParameter("departure");
    String destination = request.getParameter("destination");

    boolean saved = false;
    boolean notEnoughSeats = false;
    String errorMessage = "";
    int availableSeats = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

        if (busName == null || busName.trim().equals("")) {
            PreparedStatement ps1 = conn.prepareStatement("SELECT bus_name FROM bus_details WHERE bus_id = ?");
            ps1.setString(1, busId);
            ResultSet rs = ps1.executeQuery();
            if (rs.next()) {
                busName = rs.getString("bus_name");
            }
        }

        PreparedStatement checkSeats = conn.prepareStatement("SELECT available_seats FROM bus_details WHERE bus_id = ?");
        checkSeats.setString(1, busId);
        ResultSet seatResult = checkSeats.executeQuery();
        if (seatResult.next()) {
            availableSeats = seatResult.getInt("available_seats");
        }

        if (availableSeats >= passengers) {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO bookings (user_email, bus_id, bus_name, travel_date, passengers, total_amount, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, userEmail);
            ps.setString(2, busId);
            ps.setString(3, busName);
            ps.setString(4, date);
            ps.setInt(5, passengers);
            ps.setDouble(6, Double.parseDouble(totalPrice));
            ps.setString(7, "Paid");

            int result = ps.executeUpdate();
            if (result > 0) {
                saved = true;

                PreparedStatement ps2 = conn.prepareStatement(
                    "UPDATE bus_details SET available_seats = available_seats - ? WHERE bus_id = ?");
                ps2.setInt(1, passengers);
                ps2.setString(2, busId);
                ps2.executeUpdate();
                ps2.close();
            }
        } else {
            notEnoughSeats = true;
        }

        conn.close();
    } catch (Exception e) {
        errorMessage = e.getMessage();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Successful</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #0a192f; /* dark background */
            color: #f1f5f9;
            margin: 0;
            padding: 0;
        }
        .receipt-container {
            max-width: 650px;
            margin: 40px auto;
            padding: 30px;
            background: #112240; /* card background */
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.5);
        }
        .receipt-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #facc15; /* golden yellow */
        }
        .receipt {
            font-size: 16px;
            line-height: 1.8;
        }
        .receipt strong {
            color: #facc15;
        }
        .receipt-footer {
            margin-top: 20px;
            text-align: center;
        }
        .btn-back {
            padding: 10px 20px;
            background: #2563eb; /* blue button */
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background 0.3s;
        }
        .btn-back:hover {
            background: #1d4ed8;
        }
        .error {
            color: #f87171; /* red error */
            text-align: center;
            font-weight: bold;
        }
        button.btn-back {
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div style="text-align: center; margin-top: 30px;">
    <img src="images/logo.png" alt="RideSync Logo" style="height: 80px;">
</div>

<div class="receipt-container">
    <h2>Payment Result</h2>

<% if (notEnoughSeats) { %>
    <p class="error">⚠️ Booking failed: Only <%= availableSeats %> seat(s) left. You tried to book <%= passengers %>.</p>
<% } else if (saved) { %>
    <div class="receipt">
        <p><strong>Passenger:</strong> <%= userEmail %></p>
        <p><strong>Cardholder:</strong> <%= cardName %></p>
        <p><strong>Bus:</strong> <%= busName %> (ID: <%= busId %>)</p>
        <p><strong>Departure:</strong> <%= departure %></p>
        <p><strong>Destination:</strong> <%= destination %></p>
        <p><strong>Travel Date:</strong> <%= date %></p>
        <p><strong>Passengers:</strong> <%= passengers %></p>
        <p><strong>Tax:</strong> ₹<%= tax %></p>
        <p><strong>Total Paid:</strong> ₹<%= totalPrice %></p>
        <p><strong>Transaction ID:</strong> #TRX<%= System.currentTimeMillis() %></p>
    </div>
    <form action="generate_pdf.jsp" method="post" target="_blank">
        <input type="hidden" name="user_email" value="<%= userEmail %>">
        <input type="hidden" name="card_name" value="<%= cardName %>">
        <input type="hidden" name="bus_id" value="<%= busId %>">
        <input type="hidden" name="bus_name" value="<%= busName %>">
        <input type="hidden" name="departure" value="<%= departure %>">
        <input type="hidden" name="destination" value="<%= destination %>">
        <input type="hidden" name="travel_date" value="<%= date %>">
        <input type="hidden" name="passengers" value="<%= passengers %>">
        <input type="hidden" name="tax" value="<%= tax %>">
        <input type="hidden" name="total" value="<%= totalPrice %>">
        <input type="hidden" name="transaction_id" value="TRX<%= System.currentTimeMillis() %>">

        <button type="submit" class="btn-back" style="margin-top: 15px;">Download Bill PDF</button>
    </form>
<% } else { %>
    <p class="error">⚠️ Booking failed: <%= errorMessage %></p>
<% } %>

    <div class="receipt-footer">
        <a href="home.jsp" class="btn-back">Back to Home</a>
    </div>
</div>
</body>
</html>
