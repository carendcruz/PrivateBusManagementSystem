<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Messages</title>
    <link rel="stylesheet" href="style.css">
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
            padding: 14px 18px;
            text-align: left;
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

        .message {
            max-width: 500px;
            word-wrap: break-word;
            font-size: 14px;
            color: #ccc;
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
            <h2><i class="fa-solid fa-envelope-open-text"></i> User Messages</h2>
            
        </div>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th><i class="fa-solid fa-user"></i> Full Name</th>
                        <th><i class="fa-solid fa-envelope"></i> Email</th>
                        <th><i class="fa-solid fa-phone"></i> Phone</th>
                        <th><i class="fa-solid fa-tag"></i> Subject</th>
                        <th><i class="fa-solid fa-message"></i> Message</th>
                        <th><i class="fa-solid fa-calendar"></i> Submitted At</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int count = 1;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM contact_messages ORDER BY submitted_at DESC");

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= count++ %></td>
                        <td><%= rs.getString("full_name") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("phone") %></td>
                        <td><%= rs.getString("subject") %></td>
                        <td class="message"><%= rs.getString("message") %></td>
                        <td><%= rs.getTimestamp("submitted_at") %></td>
                    </tr>
                    <%
                            }
                            conn.close();
                        } catch (Exception e) {
                    %>
                    <tr>
                        <td colspan="7">⚠ Error loading messages: <%= e.getMessage() %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
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
