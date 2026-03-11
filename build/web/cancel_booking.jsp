<%@ page import="java.sql.*" %>
<%
    String bookingId = request.getParameter("booking_id");
    String email = request.getParameter("email");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

        String sql = "UPDATE bookings SET payment_status='Cancelled' WHERE booking_id=? AND user_email=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(bookingId));
        ps.setString(2, email);

        int rows = ps.executeUpdate();
        conn.close();

        if (rows > 0) {
            response.sendRedirect("cancellation.jsp?msg=success");
        } else {
            response.sendRedirect("cancellation.jsp?msg=notfound");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("cancellation.jsp?msg=error");
    }
%>
