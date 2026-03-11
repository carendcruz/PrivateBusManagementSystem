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
    <title>Registered Users - Ridesync Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
            font-size: 30px;
            font-weight: 700;
            margin: 0;
            color: #e3c77c; /* muted gold */
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
            padding: 14px 18px;
            text-align: left;
            font-size: 14px;
            color: #eaeaea;
        }

        th {
            font-weight: 600;
            color: #d9b96a; /* soft gold */
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

        .btn-danger {
            background: linear-gradient(90deg, #a71d2a, #dc3545);
            color: #fff;
            padding: 6px 14px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
            transition: 0.3s;
        }

        .btn-danger:hover {
            background: linear-gradient(90deg, #dc3545, #a71d2a);
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
        <h2><i class="fa-solid fa-users"></i> Registered Users</h2>
        <p>Complete list of Ridesync registered passengers</p>
    </div>
    
    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th><i class="fa-solid fa-user"></i> Name</th>
                    <th><i class="fa-solid fa-envelope"></i> Email</th>
                    <th><i class="fa-solid fa-phone"></i> Phone</th>
                    <th><i class="fa-solid fa-venus-mars"></i> Gender</th>
                    <th><i class="fa-solid fa-city"></i> City</th>
                    <th><i class="fa-solid fa-calendar"></i> Registered On</th>
                    <th><i class="fa-solid fa-trash"></i> Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM users");

                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("first_name") + " " + rs.getString("last_name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("phone") %></td>
                    <td><%= rs.getString("gender") %></td>
                    <td><%= rs.getString("city") %></td>
                    <td><%= rs.getTimestamp("created_at") %></td>
                    <td>
                        <a href="delete_user.jsp?id=<%= rs.getInt("id") %>" class="btn-danger" onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                    </td>
                </tr>
                <%
                        }
                        con.close();
                    } catch (Exception e) {
                        out.println("<tr><td colspan='8'>⚠ Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

    <div style="text-align: center;">
        <a href="admin_dashboard.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
    </div>
</div>

<% if (request.getParameter("deleted") != null && request.getParameter("deleted").equals("true")) { %>
<script>
    Swal.fire({
        title: 'User Deleted!',
        text: 'The user was deleted successfully.',
        icon: 'success',
        confirmButtonColor: '#1a2738'
    });
</script>
<% } %>

<footer>
    © 2025 Ridesync Admin Panel. All Rights Reserved.
</footer>

</body>
</html>
