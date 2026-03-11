<%-- 
    Document   : delete_user
    Created on : 19 Jul, 2025, 8:39:45 PM
    Author     : CAREN
--%>

<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("user_role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = Integer.parseInt(request.getParameter("id"));
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

        PreparedStatement ps = con.prepareStatement("DELETE FROM users WHERE id = ?");
        ps.setInt(1, userId);
        ps.executeUpdate();

        con.close();

        response.sendRedirect("admin_users.jsp?deleted=true");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>

