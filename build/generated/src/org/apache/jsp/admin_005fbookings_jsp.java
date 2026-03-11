package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class admin_005fbookings_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

    // Role check
    String role = (String) session.getAttribute("user_role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    int totalBookings = 0;
    double totalRevenue = 0.0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

        Statement stmt = conn.createStatement();

        // Count total bookings
        ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM bookings");
        if (rs1.next()) {
            totalBookings = rs1.getInt(1);
        }

        // Calculate total revenue (bookings - refunds)
ResultSet rs2 = stmt.executeQuery(
    "SELECT IFNULL((SELECT SUM(total_amount) FROM bookings),0) - " +
    "IFNULL((SELECT SUM(refund_amount) FROM refunds),0) AS net_revenue"
);

if (rs2.next()) {
    totalRevenue = rs2.getDouble(1);
}


        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <title>Admin Booking Summary - Ridesync</title>\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css\">\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: 'Segoe UI', sans-serif;\n");
      out.write("            background-color: #f9f9f9;\n");
      out.write("            margin: 0;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        header {\n");
      out.write("            background-color: #1e2a38;\n");
      out.write("            color: white;\n");
      out.write("            padding: 1rem 2rem;\n");
      out.write("            display: flex;\n");
      out.write("            justify-content: space-between;\n");
      out.write("            align-items: center;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .header-title {\n");
      out.write("            font-size: 24px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .summary-container {\n");
      out.write("            max-width: 800px;\n");
      out.write("            margin: 50px auto;\n");
      out.write("            background: white;\n");
      out.write("            padding: 30px;\n");
      out.write("            border-radius: 12px;\n");
      out.write("            box-shadow: 0 8px 20px rgba(0,0,0,0.1);\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .summary-container h2 {\n");
      out.write("            text-align: center;\n");
      out.write("            margin-bottom: 30px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .summary-box {\n");
      out.write("            display: flex;\n");
      out.write("            justify-content: space-around;\n");
      out.write("            text-align: center;\n");
      out.write("            padding: 20px 0;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .summary-card {\n");
      out.write("            background-color: #f0f4f8;\n");
      out.write("            padding: 20px;\n");
      out.write("            border-radius: 10px;\n");
      out.write("            width: 40%;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .summary-card h3 {\n");
      out.write("            margin: 0;\n");
      out.write("            font-size: 20px;\n");
      out.write("            color: #333;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .summary-card p {\n");
      out.write("            font-size: 24px;\n");
      out.write("            color: #005ce6;\n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .btn-back {\n");
      out.write("            display: block;\n");
      out.write("            width: 200px;\n");
      out.write("            margin: 30px auto 0;\n");
      out.write("            background-color: #005ce6;\n");
      out.write("            color: white;\n");
      out.write("            padding: 12px;\n");
      out.write("            text-align: center;\n");
      out.write("            border-radius: 8px;\n");
      out.write("            text-decoration: none;\n");
      out.write("            font-size: 16px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .btn-back:hover {\n");
      out.write("            background-color: #0047b3;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("<header>\n");
      out.write("    <div class=\"header-title\"><i class=\"fas fa-ticket-alt\"></i> Booking Summary</div>\n");
      out.write("    <div><a href=\"admin_dashboard.jsp\" style=\"color: white; text-decoration: none;\">Dashboard</a></div>\n");
      out.write("</header>\n");
      out.write("\n");
      out.write("<div class=\"summary-container\">\n");
      out.write("    <h2>Bookings Overview</h2>\n");
      out.write("\n");
      out.write("    <div class=\"summary-box\">\n");
      out.write("        <div class=\"summary-card\">\n");
      out.write("            <h3>Total Bookings</h3>\n");
      out.write("            <p>");
      out.print( totalBookings );
      out.write("</p>\n");
      out.write("        </div>\n");
      out.write("        <div class=\"summary-card\">\n");
      out.write("            <h3>Total Revenue</h3>\n");
      out.write("            <p>₹ ");
      out.print( String.format("%.2f", totalRevenue) );
      out.write("</p>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <a href=\"admin_dashboard.jsp\" class=\"btn-back\">← Back to Dashboard</a>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
