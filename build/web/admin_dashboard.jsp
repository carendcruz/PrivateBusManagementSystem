<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    // Check admin role
    String role = (String) session.getAttribute("user_role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    // JDBC Logic
    int totalBuses = 0;
    int totalBookings = 0;
    int totalUsers = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

        Statement stmt = conn.createStatement();

        ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM bus_details");
        if (rs1.next()) totalBuses = rs1.getInt(1);

        ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) FROM bookings");
        if (rs2.next()) totalBookings = rs2.getInt(1);

        ResultSet rs3 = stmt.executeQuery("SELECT COUNT(*) FROM users WHERE role = 'passenger'");
        if (rs3.next()) totalUsers = rs3.getInt(1);

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Ridesync</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            font-family: "Segoe UI", sans-serif;
            background: linear-gradient(135deg, #0a0f24, #1a2740);
            color: #f5f5f5;
        }

        header {
            background: rgba(20, 25, 45, 0.95);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.5);
        }

        .logo h1 {
            color: #e3c77c;
            font-size: 28px;
            margin: 0;
        }

        .nav-links a {
            color: #f5f5f5;
            text-decoration: none;
            margin-left: 20px;
            font-weight: 500;
            position: relative;
            transition: 0.3s;
        }

        .nav-links a:hover {
            color: #e3c77c;
        }

        .nav-links a:hover::after {
            content: "";
            position: absolute;
            bottom: -6px;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: #e3c77c;
        }

        .container {
            width: 92%;
            max-width: 1200px;
            margin: 60px auto 40px;
            background: rgba(20, 25, 45, 0.85);
            border-radius: 18px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.6);
            padding: 40px;
            backdrop-filter: blur(10px);
        }

        h2 {
            color: #e3c77c;
            font-size: 32px;
            margin-bottom: 2rem;
            text-align: center;
        }

        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 2rem;
        }

        .card {
            background: rgba(255,255,255,0.05);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.4);
            text-align: center;
            transition: transform 0.3s ease, background 0.3s ease;
        }

        .card:hover {
            transform: translateY(-6px);
            background: rgba(255,255,255,0.08);
        }

        .card i {
            font-size: 2.5rem;
            color: #d9b96a;
            margin-bottom: 1rem;
        }

        .card h3 {
            font-size: 20px;
            margin: 0.5rem 0;
            color: #eaeaea;
        }

        .card p {
            font-size: 22px;
            font-weight: bold;
            color: #e3c77c;
        }

        footer {
            background: rgba(20, 25, 45, 0.95);
            color: #777;
            text-align: center;
            padding: 1rem;
            font-size: 14px;
            margin-top: 40px;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <h1><i class="fas fa-bus"></i> Ridesync</h1>
        </div>
        <div class="nav-links">
            <a href="admin_dashboard.jsp">Dashboard</a>
            <a href="admin_buses.jsp">Manage Buses</a>
            <a href="admin_bookings.jsp">View Bookings</a>
            <a href="admin_messages.jsp">User Messages</a>
            <a href="admin_feedback.jsp">User Feedbacks</a>
            <a href="logout.jsp">Logout</a>
        </div>
    </header>

    <div class="container">
        <h2>Welcome, Admin</h2>
        <div class="dashboard-cards">
            <a href="admin_buses.jsp" style="text-decoration: none;">
                <div class="card">
                    <i class="fas fa-bus"></i>
                    <h3>Total Buses</h3>
                    <p><%= totalBuses %></p>
                </div>
            </a>
            <a href="admin_bookings.jsp" style="text-decoration: none;">
                <div class="card">
                    <i class="fas fa-ticket-alt"></i>
                    <h3>Total Bookings</h3>
                    <p><%= totalBookings %></p>
                </div>
            </a>
            <a href="admin_users.jsp" style="text-decoration: none;">
                <div class="card">
                    <i class="fas fa-users"></i>
                    <h3>Registered Users</h3>
                    <p><%= totalUsers %></p>
                </div>
            </a>
        </div>
    </div>

    <footer>
        &copy; 2025 Ridesync Admin Dashboard. Designed in Premium Style.
    </footer>
</body>
</html>
