<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    String monthParam = request.getParameter("month");
    String dateParam = request.getParameter("date"); 
    String role = (String) session.getAttribute("user_role");

    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    int totalBookings = 0;
    double totalRevenue = 0.0;

    Connection conn = null;
    PreparedStatement ps1 = null, ps2 = null, ps3 = null;
    ResultSet rs1 = null, rs2 = null, rsBookings = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

        ps1 = conn.prepareStatement("SELECT COUNT(*) FROM bookings");
        rs1 = ps1.executeQuery();
        if (rs1.next()) totalBookings = rs1.getInt(1);

   
        ps2 = conn.prepareStatement(
            "SELECT IFNULL((SELECT SUM(total_amount) FROM bookings),0) - " +
            "IFNULL((SELECT SUM(refund_amount) FROM refunds),0)"
        );
        rs2 = ps2.executeQuery();
        if (rs2.next()) totalRevenue = rs2.getDouble(1);

        // --- Filter
StringBuilder sql = new StringBuilder(
    "SELECT b.id, b.user_email, b.bus_name, b.travel_date, b.total_amount, " +
    "IFNULL(r.refund_amount,0) AS refund_amount " +
    "FROM bookings b LEFT JOIN refunds r ON b.id = r.booking_id WHERE 1=1 "
);

boolean hasMonth = (monthParam != null && !monthParam.isEmpty());
boolean hasDate  = (dateParam != null && !dateParam.isEmpty());

if (hasMonth) {
    sql.append(" AND YEAR(b.travel_date)=? AND MONTH(b.travel_date)=?");
}
if (hasDate) {
    sql.append(" AND DATE(b.travel_date)=?");
}

sql.append(" ORDER BY b.created_at DESC");
ps3 = conn.prepareStatement(sql.toString());

// --- parameters
int paramIndex = 1;
if (hasMonth) {
    String[] parts = monthParam.split("-");
    int year = Integer.parseInt(parts[0]);
    int month = Integer.parseInt(parts[1]);
    ps3.setInt(paramIndex++, year);
    ps3.setInt(paramIndex++, month);
}
if (hasDate) {
    ps3.setDate(paramIndex++, java.sql.Date.valueOf(dateParam));
}

rsBookings = ps3.executeQuery();

%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Booking Summary - Ridesync</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", sans-serif;
            background: linear-gradient(135deg, #0a0f24, #1a2740);
            color: #f5f5f5;
        }

        .admin-container {
            width: 92%;
            max-width: 1200px;
            margin: 80px auto 40px;
            background: rgba(20, 25, 45, 0.8);
            border-radius: 18px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.6);
            padding: 30px;
            backdrop-filter: blur(10px);
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h2 {
            font-size: 30px;
            font-weight: 700;
            margin: 0;
            color: #e3c77c; /* muted gold */
        }

        .header p {
            color: #aaa;
            font-size: 15px;
        }
                /* Filter form container */
        .filter-form {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 12px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        /* Month input styling */
        .filter-form input[type="month"] {
            padding: 8px 12px;
            border-radius: 8px;
            border: none;
            background: rgba(255,255,255,0.1);
            color: #fff;
            font-size: 14px;
            transition: background 0.3s, box-shadow 0.3s;
        }

        .filter-form input[type="month"]:focus {
            outline: none;
            background: rgba(255,255,255,0.15);
            box-shadow: 0 0 5px rgba(227,199,124,0.7);
        }

        /* Buttons styling */
        .filter-form button,
        .filter-form a {
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 14px;
            text-decoration: none;
            cursor: pointer;
        }

        /* Filter button */
        .filter-form button {
            background: linear-gradient(90deg, #2c3e50, #1a2738);
            color: #e3c77c;
            border: none;
            transition: 0.3s;
        }

        .filter-form button:hover {
            background: linear-gradient(90deg, #1a2738, #111722);
            color: #fff;
        }

        /* Reset link */
        .filter-form a {
            background: rgba(255,255,255,0.05);
            color: #e3c77c;
            transition: 0.3s;
        }

        .filter-form a:hover {
            background: rgba(255,255,255,0.12);
            color: #fff;
        }

        .summary-box {
            display: flex;
            justify-content: space-around;
            text-align: center;
            margin: 30px 0;
        }

        .summary-card {
            background: rgba(255,255,255,0.05);
            padding: 20px;
            border-radius: 12px;
            width: 40%;
            box-shadow: inset 0 0 8px rgba(255,255,255,0.05);
        }

        .summary-card h3 {
            margin: 0;
            font-size: 18px;
            color: #d9b96a;
        }

        .summary-card p {
            font-size: 24px;
            color: #fff;
            font-weight: bold;
            margin-top: 8px;
        }

        .table-card {
            overflow: hidden;
            border-radius: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255,255,255,0.05);
        }

        thead {
            background: linear-gradient(90deg, #2c3e50, #1a2738);
        }

        th, td {
            padding: 14px 16px;
            text-align: center;
            font-size: 14px;
            color: #eaeaea;
        }

        th {
            font-weight: 600;
            color: #d9b96a;
        }

        tbody tr {
            transition: background 0.3s ease-in-out;
        }

        tbody tr:hover {
            background: rgba(255,255,255,0.08);
        }

        tbody td {
            border-top: 1px solid rgba(255,255,255,0.08);
        }

        .back-link {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 22px;
            background: linear-gradient(90deg, #2c3e50, #1a2738);
            color: #e3c77c;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 500;
            letter-spacing: 0.5px;
            transition: 0.3s;
        }

        .back-link:hover {
            background: linear-gradient(90deg, #1a2738, #111722);
            color: #fff;
        }

        footer {
            text-align: center;
            color: #777;
            padding: 15px 0;
            font-size: 13px;
        }
    </style>
</head>
<body>

<div class="admin-container">
    <div class="header">
        <h2><i class="fas fa-ticket-alt"></i> Booking Summary</h2>
        
    </div>

    <div class="summary-box">
        <div class="summary-card">
            <h3>Total Bookings</h3>
            <p><%= totalBookings %></p>
        </div>
        <div class="summary-card">
            <h3>Total Revenue</h3>
            <p>₹ <%= String.format("%.2f", totalRevenue) %></p>
        </div>
    </div>
        <div class="filter-form">
    <form method="get" action="admin_bookings.jsp">
        <label for="month">Select Month:</label>
        <input type="month" id="month" name="month"
               value="<%= request.getParameter("month") != null ? request.getParameter("month") : "" %>">

        <label for="date">Select Date:</label>
        <input type="date" id="date" name="date"
               value="<%= request.getParameter("date") != null ? request.getParameter("date") : "" %>">

        <button type="submit">Filter</button>
        <a href="admin_bookings.jsp">Reset</a>
    </form>
</div>


    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>User Email</th>
                    <th>Bus Name</th>
                    <th>Travel Date</th>
                    <th>Total Amount</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while(rsBookings.next()) {
                %>
                <tr>
                    <td><%= rsBookings.getInt("id") %></td>
                    <td><%= rsBookings.getString("user_email") %></td>
                    <td><%= rsBookings.getString("bus_name") %></td>
                    <td><%= rsBookings.getDate("travel_date") %></td>
                    <td>₹ <%= rsBookings.getDouble("total_amount") %></td>
                </tr>
                <%
                    } // while end
                } catch(Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rsBookings != null) rsBookings.close();
                    if (rs2 != null) rs2.close();
                    if (rs1 != null) rs1.close();
                    if (ps3 != null) ps3.close();
                    if (ps2 != null) ps2.close();
                    if (ps1 != null) ps1.close();
                    if (conn != null) conn.close();
                }
                %>
            </tbody>
        </table>
    </div>
            <div style="text-align: center; margin-bottom: 20px;">
    <form action="ExportBookingsPDF.jsp" method="post">
    <input type="hidden" name="month" value="<%= request.getParameter("month") != null ? request.getParameter("month") : "" %>">
    <input type="hidden" name="date" value="<%= request.getParameter("date") != null ? request.getParameter("date") : "" %>">
    <button type="submit" class="back-link" style="margin-bottom: 10px;">
        <i class="fa-solid fa-file-pdf"></i> Download Bookings PDF
    </button>
</form>

</div>

    <div style="text-align: center;">
        <a href="admin_dashboard.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
    </div>
</div>

<footer>
    © 2025 Ridesync Admin Panel. All Rights Reserved.
</footer>

</body>
</html>
