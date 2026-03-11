package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class admin_005fdashboard_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <title>Admin Dashboard - Ridesync</title>\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css\">\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            margin: 0;\n");
      out.write("            font-family: \"Segoe UI\", sans-serif;\n");
      out.write("            background: linear-gradient(135deg, #0a0f24, #1a2740);\n");
      out.write("            color: #f5f5f5;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        header {\n");
      out.write("            background: rgba(20, 25, 45, 0.95);\n");
      out.write("            padding: 1rem 2rem;\n");
      out.write("            display: flex;\n");
      out.write("            justify-content: space-between;\n");
      out.write("            align-items: center;\n");
      out.write("            box-shadow: 0 4px 12px rgba(0,0,0,0.5);\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .logo h1 {\n");
      out.write("            color: #e3c77c;\n");
      out.write("            font-size: 28px;\n");
      out.write("            margin: 0;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .nav-links a {\n");
      out.write("            color: #f5f5f5;\n");
      out.write("            text-decoration: none;\n");
      out.write("            margin-left: 20px;\n");
      out.write("            font-weight: 500;\n");
      out.write("            position: relative;\n");
      out.write("            transition: 0.3s;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .nav-links a:hover {\n");
      out.write("            color: #e3c77c;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .nav-links a:hover::after {\n");
      out.write("            content: \"\";\n");
      out.write("            position: absolute;\n");
      out.write("            bottom: -6px;\n");
      out.write("            left: 0;\n");
      out.write("            width: 100%;\n");
      out.write("            height: 2px;\n");
      out.write("            background-color: #e3c77c;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .container {\n");
      out.write("            width: 92%;\n");
      out.write("            max-width: 1200px;\n");
      out.write("            margin: 60px auto 40px;\n");
      out.write("            background: rgba(20, 25, 45, 0.85);\n");
      out.write("            border-radius: 18px;\n");
      out.write("            box-shadow: 0 6px 20px rgba(0,0,0,0.6);\n");
      out.write("            padding: 40px;\n");
      out.write("            backdrop-filter: blur(10px);\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        h2 {\n");
      out.write("            color: #e3c77c;\n");
      out.write("            font-size: 32px;\n");
      out.write("            margin-bottom: 2rem;\n");
      out.write("            text-align: center;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .dashboard-cards {\n");
      out.write("            display: grid;\n");
      out.write("            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));\n");
      out.write("            gap: 2rem;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .card {\n");
      out.write("            background: rgba(255,255,255,0.05);\n");
      out.write("            padding: 2rem;\n");
      out.write("            border-radius: 15px;\n");
      out.write("            box-shadow: 0 4px 15px rgba(0,0,0,0.4);\n");
      out.write("            text-align: center;\n");
      out.write("            transition: transform 0.3s ease, background 0.3s ease;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .card:hover {\n");
      out.write("            transform: translateY(-6px);\n");
      out.write("            background: rgba(255,255,255,0.08);\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .card i {\n");
      out.write("            font-size: 2.5rem;\n");
      out.write("            color: #d9b96a;\n");
      out.write("            margin-bottom: 1rem;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .card h3 {\n");
      out.write("            font-size: 20px;\n");
      out.write("            margin: 0.5rem 0;\n");
      out.write("            color: #eaeaea;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .card p {\n");
      out.write("            font-size: 22px;\n");
      out.write("            font-weight: bold;\n");
      out.write("            color: #e3c77c;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        footer {\n");
      out.write("            background: rgba(20, 25, 45, 0.95);\n");
      out.write("            color: #777;\n");
      out.write("            text-align: center;\n");
      out.write("            padding: 1rem;\n");
      out.write("            font-size: 14px;\n");
      out.write("            margin-top: 40px;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    <header>\n");
      out.write("        <div class=\"logo\">\n");
      out.write("            <h1><i class=\"fas fa-bus\"></i> Ridesync</h1>\n");
      out.write("        </div>\n");
      out.write("        <div class=\"nav-links\">\n");
      out.write("            <a href=\"admin_dashboard.jsp\">Dashboard</a>\n");
      out.write("            <a href=\"admin_buses.jsp\">Manage Buses</a>\n");
      out.write("            <a href=\"admin_bookings.jsp\">View Bookings</a>\n");
      out.write("            <a href=\"admin_messages.jsp\">User Messages</a>\n");
      out.write("            <a href=\"admin_feedback.jsp\">User Feedbacks</a>\n");
      out.write("            <a href=\"logout.jsp\">Logout</a>\n");
      out.write("        </div>\n");
      out.write("    </header>\n");
      out.write("\n");
      out.write("    <div class=\"container\">\n");
      out.write("        <h2>Welcome, Admin</h2>\n");
      out.write("        <div class=\"dashboard-cards\">\n");
      out.write("            <a href=\"admin_buses.jsp\" style=\"text-decoration: none;\">\n");
      out.write("                <div class=\"card\">\n");
      out.write("                    <i class=\"fas fa-bus\"></i>\n");
      out.write("                    <h3>Total Buses</h3>\n");
      out.write("                    <p>");
      out.print( totalBuses );
      out.write("</p>\n");
      out.write("                </div>\n");
      out.write("            </a>\n");
      out.write("            <a href=\"admin_bookings.jsp\" style=\"text-decoration: none;\">\n");
      out.write("                <div class=\"card\">\n");
      out.write("                    <i class=\"fas fa-ticket-alt\"></i>\n");
      out.write("                    <h3>Total Bookings</h3>\n");
      out.write("                    <p>");
      out.print( totalBookings );
      out.write("</p>\n");
      out.write("                </div>\n");
      out.write("            </a>\n");
      out.write("            <a href=\"admin_users.jsp\" style=\"text-decoration: none;\">\n");
      out.write("                <div class=\"card\">\n");
      out.write("                    <i class=\"fas fa-users\"></i>\n");
      out.write("                    <h3>Registered Users</h3>\n");
      out.write("                    <p>");
      out.print( totalUsers );
      out.write("</p>\n");
      out.write("                </div>\n");
      out.write("            </a>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <footer>\n");
      out.write("        &copy; 2025 Ridesync Admin Dashboard. Designed in Premium Style.\n");
      out.write("    </footer>\n");
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
