<%-- 
    Document   : delete_bus
    Created on : 19 Jul, 2025, 9:10:14 PM
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

    String busId = request.getParameter("id");
    String message = "";

    if (busId != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

            String sql = "DELETE FROM bus_details WHERE bus_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(busId));

            int deleted = ps.executeUpdate();
            conn.close();

            if (deleted > 0) {
                // Redirect to bus list with success message
                response.sendRedirect("admin_buses.jsp?msg=deleted");
            } else {
                response.sendRedirect("admin_buses.jsp?msg=notfound");
            }

        } catch (Exception e) {
            response.sendRedirect("admin_buses.jsp?msg=error");
        }
    } else {
        response.sendRedirect("admin_buses.jsp?msg=invalid");
    }
%>
