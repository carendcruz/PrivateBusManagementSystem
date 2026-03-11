package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class booking_jsp extends org.apache.jasper.runtime.HttpJspBase
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

    String user = (String) session.getAttribute("user_email");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <title>Ridesync - Booking</title>\n");
      out.write("    <link rel=\"stylesheet\" href=\"style.css\">\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    \n");
      out.write("\n");
      out.write("    \n");
      out.write("    <!-- Header -->\n");
      out.write("    <header>\n");
      out.write("        <div class=\"container header-content\">\n");
      out.write("            <div class=\"logo\">\n");
      out.write("                    <img src=\"images/logo.png\"  height=\"70\">\n");
      out.write("                \n");
      out.write("                <h1>Ride<span>sync</span></h1>\n");
      out.write("            </div>\n");
      out.write("            <nav>\n");
      out.write("                <ul>\n");
      out.write("                    <li><a href=\"home.jsp\">Home</a></li>\n");
      out.write("                    <li><a href=\"about.jsp\">About</a></li>\n");
      out.write("                    <li><a href=\"booking.jsp\" class=\"active\">Booking</a></li>\n");
      out.write("                    <li><a href=\"cancellation.jsp\">Cancellation</a></li>\n");
      out.write("                    <li><a href=\"gallery.jsp\">Gallery</a></li>\n");
      out.write("                    <li><a href=\"contact.jsp\">Contact</a></li>\n");
      out.write("                </ul>\n");
      out.write("            </nav>\n");
      out.write("            <div class=\"header-right\">\n");
      out.write("                ");
 if (session.getAttribute("user_email") != null) { 
      out.write("\n");
      out.write("    <div class=\"profile-icon\">\n");
      out.write("        <i class=\"fas fa-user\"></i>\n");
      out.write("        <div class=\"profile-dropdown\">\n");
      out.write("            <div class=\"profile-header\">\n");
      out.write("                <div class=\"profile-avatar\">\n");
      out.write("                    <i class=\"fas fa-user\"></i>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"profile-info\">\n");
      out.write("                    <h3>");
      out.print( session.getAttribute("user_name") );
      out.write("</h3>\n");
      out.write("                    <p>");
      out.print( session.getAttribute("user_email") );
      out.write("</p>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("            <ul class=\"dropdown-menu\">\n");
      out.write("                <li><a href=\"profile.jsp\"><i class=\"fas fa-user-circle\"></i> My Profile</a></li>\n");
      out.write("                <li><a href=\"edit_profile.jsp\"><i class=\"fas fa-edit\"></i> Edit Profile</a></li>\n");
      out.write("                <li><a href=\"change_password.jsp\"><i class=\"fas fa-lock\"></i> Change Password</a></li>\n");
      out.write("                <li><a href=\"user_bookings.jsp\"><i class=\"fas fa-ticket-alt\"></i> My Bookings</a></li>\n");
      out.write("                <li><a href=\"feedback.jsp\"><i class=\"fas fa-edit\"></i> Feedback </a></li>\n");
      out.write("                <li><a href=\"logout.jsp\"><i class=\"fas fa-sign-out-alt\"></i> Logout</a></li>\n");
      out.write("            </ul>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
 } else { 
      out.write("\n");
      out.write("    <!-- Show icon without dropdown -->\n");
      out.write("    <div class=\"profile-icon\">\n");
      out.write("        <i class=\"fas fa-user\"></i>\n");
      out.write("    </div>\n");
 } 
      out.write("\n");
      out.write("\n");
      out.write("                <div class=\"auth-buttons\">\n");
      out.write("                    <a href=\"login.jsp\" class=\"btn btn-outline\">Login</a>\n");
      out.write("                    <a href=\"register.jsp\" class=\"btn btn-gold\">Register</a>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </header>\n");
      out.write("\n");
      out.write("    <main class=\"page\">\n");
      out.write("    <div class=\"container\">\n");
      out.write("        <div class=\"section-title\">\n");
      out.write("            <h2>Book Your Journey</h2>\n");
      out.write("            <p>Select your route and search available buses</p>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <!-- Booking Form -->\n");
      out.write("        <div class=\"booking-form-container\">\n");
      out.write("            <form class=\"booking-form\" method=\"get\" action=\"search_buses.jsp\">\n");
      out.write("                <div class=\"form-group\">\n");
      out.write("                    <label for=\"from_location\">From</label>\n");
      out.write("                    <select name=\"from_location\" id=\"from_location\" required>\n");
      out.write("                        <option value=\"\" disabled selected>Select departure</option>\n");
      out.write("                        <option value=\"FortKochi\">FortKochi</option>\n");
      out.write("                        <option value=\"Aluva\">Aluva</option>\n");
      out.write("                        <option value=\"Kakkanad\">Kakkanad</option>\n");
      out.write("                        <option value=\"Thoppumpady\">Thoppumpady</option>\n");
      out.write("                        <option value=\"Angamaly\">Angamaly</option>\n");
      out.write("                        <option value=\"Chellanam\">Chellanam</option>\n");
      out.write("                    </select>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"form-group\">\n");
      out.write("                    <label for=\"to_location\">To</label>\n");
      out.write("                    <select name=\"to_location\" id=\"to_location\" required>\n");
      out.write("                        <option value=\"\" disabled selected>Select destination</option>\n");
      out.write("                        <option value=\"FortKochi\">Fort Kochi</option>\n");
      out.write("                        <option value=\"Aluva\">Aluva</option>\n");
      out.write("                        <option value=\"Kakkanad\">Kakkanad</option>\n");
      out.write("                        <option value=\"Thoppumpady\">Thoppumpady</option>\n");
      out.write("                        <option value=\"Angamaly\">Angamaly</option>\n");
      out.write("                        <option value=\"Chellanam\">Chellanam</option>\n");
      out.write("                    </select>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"form-group\">\n");
      out.write("                    <label for=\"departure_date\">Departure Date</label>\n");
      out.write("                    <input type=\"date\" name=\"departure_date\" id=\"departure_date\" required>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"form-group\">\n");
      out.write("                    <label for=\"passengers\">Passengers</label>\n");
      out.write("                    <select name=\"passengers\" id=\"passengers\" required>\n");
      out.write("                        <option value=\"1\">1 Passenger</option>\n");
      out.write("                        <option value=\"2\">2 Passengers</option>\n");
      out.write("                        <option value=\"3\">3 Passengers</option>\n");
      out.write("                        <option value=\"4\">4 Passengers</option>\n");
      out.write("                        <option value=\"5\">5 Passengers</option>\n");
      out.write("                    </select>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"form-submit\">\n");
      out.write("                    <button type=\"submit\" class=\"btn btn-primary btn-lg\">Search Buses</button>\n");
      out.write("                </div>\n");
      out.write("            </form>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("</main>\n");
      out.write("\n");
      out.write("    <footer>\n");
      out.write("        <div class=\"container\">\n");
      out.write("            <div class=\"footer-content\">\n");
      out.write("                <div class=\"footer-column\">\n");
      out.write("                    <h3>Ridesync</h3>\n");
      out.write("                    <p>Your trusted partner for safe, comfortable, and reliable bus travel across the country.</p>\n");
      out.write("                    <div class=\"social-links\">\n");
      out.write("                        <a href=\"#\"><i class=\"fab fa-facebook-f\"></i></a>\n");
      out.write("                        <a href=\"#\"><i class=\"fab fa-twitter\"></i></a>\n");
      out.write("                        <a href=\"#\"><i class=\"fab fa-instagram\"></i></a>\n");
      out.write("                        <a href=\"#\"><i class=\"fab fa-linkedin-in\"></i></a>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"footer-column\">\n");
      out.write("                    <h3>Quick Links</h3>\n");
      out.write("                    <ul>\n");
      out.write("                        <li><a href=\"home.jsp\">Home</a></li>\n");
      out.write("                        <li><a href=\"about.jsp\">About Us</a></li>\n");
      out.write("                        <li><a href=\"booking.jsp\">Book Tickets</a></li>\n");
      out.write("                        <li><a href=\"cancellation.jsp\">Cancel Tickets</a></li>\n");
      out.write("                        <li><a href=\"gallery.jsp\">Gallery</a></li>\n");
      out.write("                        <li><a href=\"contact.jsp\">Contact</a></li>\n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"footer-column\">\n");
      out.write("                    <h3>Popular Routes</h3>\n");
      out.write("                    <ul>\n");
      out.write("                        <li><a href=\"booking.jsp\">Fort Kochi to Aluva</a></li>\n");
      out.write("                        <li><a href=\"booking.jsp\">Thoppumpady to Kakkanad</a></li>\n");
      out.write("                        <li><a href=\"booking.jsp\">mattanchery to Chitoor</a></li>\n");
      out.write("                        <li><a href=\"booking.jsp\">Chellanam to Kakkanad</a></li>\n");
      out.write("                        <li><a href=\"booking.jsp\">Aluva to Angamaly</a></li>\n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"footer-column\">\n");
      out.write("                    <h3>Contact Us</h3>\n");
      out.write("                    <ul>\n");
      out.write("                        <li><i class=\"fas fa-map-marker-alt\"></i> ABC street, Kochi, Kerala</li>\n");
      out.write("                        <li><i class=\"fas fa-phone\"></i> +91 1234567891</li>\n");
      out.write("                        <li><i class=\"fas fa-envelope\"></i> info@ridesync.com</li>\n");
      out.write("                        <li><i class=\"fas fa-clock\"></i> 24/7 Customer Support</li>\n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"copyright\">\n");
      out.write("                <p>&copy; 2025 Ridesync. All rights reserved. | Designed with <i class=\"fas fa-heart\" style=\"color: var(--accent);\"></i> for Bus Travelers</p>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </footer>\n");
      out.write("\n");
      out.write("    <script src=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js\"></script>\n");
      out.write("\n");
      out.write("    <script>\n");
      out.write("        // Toggle profile dropdown\n");
      out.write("        document.querySelector('.profile-icon').addEventListener('click', function(e) {\n");
      out.write("            e.stopPropagation();\n");
      out.write("            const dropdown = document.querySelector('.profile-dropdown');\n");
      out.write("            dropdown.classList.toggle('active');\n");
      out.write("        });\n");
      out.write("        \n");
      out.write("        // Close dropdown when clicking elsewhere\n");
      out.write("        document.addEventListener('click', function(e) {\n");
      out.write("            const dropdown = document.querySelector('.profile-dropdown');\n");
      out.write("            if (dropdown.classList.contains('active') && \n");
      out.write("                !e.target.closest('.profile-dropdown') && \n");
      out.write("                !e.target.closest('.profile-icon')) {\n");
      out.write("                dropdown.classList.remove('active');\n");
      out.write("            }\n");
      out.write("        });\n");
      out.write("    </script> \n");
      out.write("    <!-- Include Bootstrap JS -->\n");
      out.write("    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\n");
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
