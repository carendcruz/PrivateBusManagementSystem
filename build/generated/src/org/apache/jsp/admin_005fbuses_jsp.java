package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class admin_005fbuses_jsp extends org.apache.jasper.runtime.HttpJspBase
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

    String role = (String) session.getAttribute("user_role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <title>Admin - Manage Buses</title>\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css\">\n");
      out.write("\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            margin: 0;\n");
      out.write("            padding: 0;\n");
      out.write("            font-family: \"Segoe UI\", sans-serif;\n");
      out.write("            background: linear-gradient(135deg, #0a0f24, #1a2740);\n");
      out.write("            color: #f5f5f5;\n");
      out.write("            overflow-x: hidden;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .admin-container {\n");
      out.write("            width: 92%;\n");
      out.write("            max-width: 1200px;\n");
      out.write("            margin: 80px auto 40px;\n");
      out.write("            background: rgba(20, 25, 45, 0.8);\n");
      out.write("            border-radius: 18px;\n");
      out.write("            box-shadow: 0 6px 20px rgba(0,0,0,0.6);\n");
      out.write("            padding: 30px;\n");
      out.write("            backdrop-filter: blur(10px);\n");
      out.write("            position: relative;\n");
      out.write("            z-index: 2;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .header {\n");
      out.write("            text-align: center;\n");
      out.write("            margin-bottom: 30px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .header h2 {\n");
      out.write("            font-size: 30px;\n");
      out.write("            font-weight: 700;\n");
      out.write("            margin: 0;\n");
      out.write("            color: #e3c77c;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .header p {\n");
      out.write("            color: #aaa;\n");
      out.write("            font-size: 15px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .table-card {\n");
      out.write("            overflow: hidden;\n");
      out.write("            border-radius: 15px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        table {\n");
      out.write("            width: 100%;\n");
      out.write("            border-collapse: collapse;\n");
      out.write("            background: rgba(255,255,255,0.05);\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        thead {\n");
      out.write("            background: linear-gradient(90deg, #2c3e50, #1a2738);\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        th, td {\n");
      out.write("            padding: 14px 16px;\n");
      out.write("            text-align: center;\n");
      out.write("            font-size: 14px;\n");
      out.write("            color: #eaeaea;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        th {\n");
      out.write("            font-weight: 600;\n");
      out.write("            color: #d9b96a;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        tbody tr {\n");
      out.write("            transition: background 0.3s ease-in-out;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        tbody tr:hover {\n");
      out.write("            background: rgba(255,255,255,0.08);\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        tbody td {\n");
      out.write("            border-top: 1px solid rgba(255,255,255,0.08);\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .btn {\n");
      out.write("            padding: 6px 12px;\n");
      out.write("            text-decoration: none;\n");
      out.write("            color: white;\n");
      out.write("            background: #007bff;\n");
      out.write("            border-radius: 6px;\n");
      out.write("            font-size: 13px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .btn-danger {\n");
      out.write("            background: #dc3545;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .btn-add {\n");
      out.write("            display: inline-block;\n");
      out.write("            margin-top: 20px;\n");
      out.write("            background: linear-gradient(90deg, #2c3e50, #1a2738);\n");
      out.write("            color: #e3c77c;\n");
      out.write("            font-weight: 500;\n");
      out.write("            padding: 10px 20px;\n");
      out.write("            border-radius: 25px;\n");
      out.write("            text-decoration: none;\n");
      out.write("            letter-spacing: 0.5px;\n");
      out.write("            transition: 0.3s;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .btn-add:hover {\n");
      out.write("            background: linear-gradient(90deg, #1a2738, #111722);\n");
      out.write("            color: #fff;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .back-link {\n");
      out.write("            display: inline-block;\n");
      out.write("            margin-top: 25px;\n");
      out.write("            padding: 10px 22px;\n");
      out.write("            background: linear-gradient(90deg, #2c3e50, #1a2738);\n");
      out.write("            color: #e3c77c;\n");
      out.write("            border-radius: 25px;\n");
      out.write("            text-decoration: none;\n");
      out.write("            font-weight: 500;\n");
      out.write("            letter-spacing: 0.5px;\n");
      out.write("            transition: 0.3s;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .back-link:hover {\n");
      out.write("            background: linear-gradient(90deg, #1a2738, #111722);\n");
      out.write("            color: #fff;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        footer {\n");
      out.write("            text-align: center;\n");
      out.write("            color: #777;\n");
      out.write("            padding: 15px 0;\n");
      out.write("            font-size: 13px;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("<div class=\"admin-container\">\n");
      out.write("    <div class=\"header\">\n");
      out.write("        <h2><i class=\"fa-solid fa-bus\"></i> Manage Buses</h2>\n");
      out.write("        \n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <div class=\"table-card\">\n");
      out.write("        <table>\n");
      out.write("            <thead>\n");
      out.write("                <tr>\n");
      out.write("                    <th>ID</th>\n");
      out.write("                    <th>Bus Name</th>\n");
      out.write("                    <th>From</th>\n");
      out.write("                    <th>To</th>\n");
      out.write("                    <th>Departure Time</th>\n");
      out.write("                    <th>Arrival Time</th>\n");
      out.write("                    <th>Total Seats</th>\n");
      out.write("                    <th>Available</th>\n");
      out.write("                    <th>Price</th>\n");
      out.write("                    <th>Actions</th>\n");
      out.write("                </tr>\n");
      out.write("            </thead>\n");
      out.write("            <tbody>\n");
      out.write("            ");

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM bus_details");

                    while (rs.next()) {
            
      out.write("\n");
      out.write("                <tr>\n");
      out.write("                    <td>");
      out.print( rs.getInt("bus_id") );
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( rs.getString("bus_name") );
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( rs.getString("route_from") );
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( rs.getString("route_to") );
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( rs.getTime("departure_time") );
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( rs.getTime("arrival_time") );
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( rs.getInt("total_seats") );
      out.write("</td>\n");
      out.write("                    <td>");
      out.print( rs.getInt("available_seats") );
      out.write("</td>\n");
      out.write("                    <td>₹");
      out.print( rs.getBigDecimal("price") );
      out.write("</td>\n");
      out.write("                    <td>\n");
      out.write("                        <a href=\"edit_bus.jsp?id=");
      out.print( rs.getInt("bus_id") );
      out.write("\" class=\"btn\">Edit</a>\n");
      out.write("                        <a href=\"delete_bus.jsp?id=");
      out.print( rs.getInt("bus_id") );
      out.write("\" class=\"btn btn-danger\">Delete</a>\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("            ");

                    }
                    con.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='10'>Error: " + e.getMessage() + "</td></tr>");
                }
            
      out.write("\n");
      out.write("            </tbody>\n");
      out.write("        </table>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <div style=\"text-align: center;\">\n");
      out.write("        <a href=\"add_bus.jsp\" class=\"btn-add\">+ Add New Bus</a>\n");
      out.write("        <br>\n");
      out.write("        <a href=\"ExportBusesPDF.jsp\" class=\"btn-add\">\n");
      out.write("        <i class=\"fa-solid fa-file-pdf\"></i> Download Buses Report\n");
      out.write("    </a>\n");
      out.write("        <br/>\n");
      out.write("        <a href=\"admin_dashboard.jsp\" class=\"back-link\"><i class=\"fa-solid fa-arrow-left\"></i> Back to Dashboard</a>\n");
      out.write("    </div>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<footer>\n");
      out.write("    © 2025 Ridesync Admin Panel. All Rights Reserved.\n");
      out.write("</footer>\n");
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
