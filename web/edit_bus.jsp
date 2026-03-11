<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("user_role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    String message = "";
    String busId = request.getParameter("id");
    String busName = "", routeFrom = "", routeTo = "", depTime = "", arrTime = "";
    int totalSeats = 0;
    BigDecimal price = BigDecimal.ZERO;

    // 🔹 KEEP all your existing DB/logic code exactly as before
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Bus - Ridesync Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", sans-serif;
            background: linear-gradient(135deg, #0a0f24, #1a2740);
            color: #f5f5f5;
            overflow-x: hidden;
        }

        .admin-container {
            width: 92%;
            max-width: 800px;
            margin: 80px auto 40px;
            background: rgba(20, 25, 45, 0.85);
            border-radius: 18px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.6);
            padding: 30px;
            backdrop-filter: blur(10px);
            position: relative;
            z-index: 2;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h2 {
            font-size: 28px;
            font-weight: 700;
            margin: 0;
            color: #e3c77c;
        }

        .form-card {
            background: rgba(255,255,255,0.05);
            padding: 25px;
            border-radius: 15px;
        }

        label {
            display: block;
            margin-top: 1rem;
            font-weight: bold;
            color: #f5f5f5;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 6px;
            background: rgba(255,255,255,0.05);
            color: #fff;
        }

        input::placeholder {
            color: rgba(255,255,255,0.6);
        }

        button {
            display: block;
            margin: 25px auto 0 auto;
            padding: 12px 28px;
            background: linear-gradient(90deg, #2c3e50, #1a2738);
            color: #e3c77c;
            border: none;
            border-radius: 25px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: linear-gradient(90deg, #1a2738, #111722);
            color: #fff;
        }

        .message {
            margin-top: 15px;
            text-align: center;
            color: #a1e3a1;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 22px;
            background: linear-gradient(90deg, #2c3e50, #1a2738);
            color: #e3c77c;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 500;
            transition: 0.3s;
        }

        .back-link:hover {
            background: linear-gradient(90deg, #1a2738, #111722);
            color: #fff;
        }
    </style>
</head>
<body>

<div class="admin-container">
    <div class="header">
        <h2><i class="fa-solid fa-bus"></i> Edit Bus Details</h2>
    </div>

    <div class="form-card">
        <form method="post" action="edit_bus.jsp?id=<%= busId %>">
            <label>Bus Name:</label>
            <input type="text" name="bus_name" value="<%= busName %>" required>

            <label>From:</label>
            <input type="text" name="route_from" value="<%= routeFrom %>" required>

            <label>To:</label>
            <input type="text" name="route_to" value="<%= routeTo %>" required>

            <label>Departure Time:</label>
            <input type="time" name="departure_time"
                   value="<%= (depTime != null && depTime.length() >= 5) ? depTime.substring(0,5) : "" %>" required>

            <label>Arrival Time:</label>
            <input type="time" name="arrival_time"
                   value="<%= (arrTime != null && arrTime.length() >= 5) ? arrTime.substring(0,5) : "" %>" required>

            <label>Total Seats:</label>
            <input type="number" name="total_seats" value="<%= totalSeats %>" required>

            <label>Ticket Price:</label>
            <input type="text" name="price" value="<%= price %>" required>

            <button type="submit">Update Bus</button>

            <% if (!message.isEmpty()) { %>
                <p class="message"><%= message %></p>
            <% } %>
        </form>

        <div style="text-align: center;">
            <a href="admin_dashboard.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </div>
</div>

</body>
</html>
