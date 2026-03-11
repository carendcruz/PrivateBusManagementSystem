<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("user_role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Manage Buses</title>
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
            max-width: 1200px;
            margin: 80px auto 40px;
            background: rgba(20, 25, 45, 0.8);
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
            font-size: 30px;
            font-weight: 700;
            margin: 0;
            color: #e3c77c;
        }

        .header p {
            color: #aaa;
            font-size: 15px;
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

        .btn {
            padding: 6px 12px;
            text-decoration: none;
            color: white;
            background: #007bff;
            border-radius: 6px;
            font-size: 13px;
        }

        .btn-danger {
            background: #dc3545;
        }

        .btn-add {
            display: inline-block;
            margin-top: 20px;
            background: linear-gradient(90deg, #2c3e50, #1a2738);
            color: #e3c77c;
            font-weight: 500;
            padding: 10px 20px;
            border-radius: 25px;
            text-decoration: none;
            letter-spacing: 0.5px;
            transition: 0.3s;
        }

        .btn-add:hover {
            background: linear-gradient(90deg, #1a2738, #111722);
            color: #fff;
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
        <h2><i class="fa-solid fa-bus"></i> Manage Buses</h2>
        
    </div>

    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Bus Name</th>
                    <th>From</th>
                    <th>To</th>
                    <th>Departure Time</th>
                    <th>Arrival Time</th>
                    <th>Total Seats</th>
                    <th>Available</th>
                    <th>Price</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM bus_details");

                    while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getInt("bus_id") %></td>
                    <td><%= rs.getString("bus_name") %></td>
                    <td><%= rs.getString("route_from") %></td>
                    <td><%= rs.getString("route_to") %></td>
                    <td><%= rs.getTime("departure_time") %></td>
                    <td><%= rs.getTime("arrival_time") %></td>
                    <td><%= rs.getInt("total_seats") %></td>
                    <td><%= rs.getInt("available_seats") %></td>
                    <td>₹<%= rs.getBigDecimal("price") %></td>
                    <td>
                        <a href="edit_bus.jsp?id=<%= rs.getInt("bus_id") %>" class="btn">Edit</a>
                        <a href="delete_bus.jsp?id=<%= rs.getInt("bus_id") %>" class="btn btn-danger">Delete</a>
                    </td>
                </tr>
            <%
                    }
                    con.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='10'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>

    <div style="text-align: center;">
        <a href="add_bus.jsp" class="btn-add">+ Add New Bus</a>
        <br>
        <a href="ExportBusesPDF.jsp" class="btn-add">
        <i class="fa-solid fa-file-pdf"></i> Download Buses Report
    </a>
        <br/>
        <a href="admin_dashboard.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
    </div>
</div>

<footer>
    © 2025 Ridesync Admin Panel. All Rights Reserved.
</footer>

</body>
</html>
