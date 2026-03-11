<%-- 
    Document   : search
    Created on : 17 Jul, 2025, 12:15:50 AM
    Author     : CAREN
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("user_email");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String from = request.getParameter("from_location");
    String to = request.getParameter("to_location");
    String departureDate = request.getParameter("departure_date");
    String passengers = request.getParameter("passengers");
    
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ridesync - Home</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* Header */
        header {
            background-color: #0a192f;
            padding: 15px 30px;
            border-bottom: 2px solid #ffcc00;
        }
        header .logo h1 {
            color: #fff;
        }
        header .logo h1 span {
            color: #ffcc00;
        }
        header nav ul li a {
            color: #fff;
        }
        header nav ul li a.active,
        header nav ul li a:hover {
            color: #ffcc00;
        }
        .auth-buttons .btn-outline {
            border: 2px solid #ffcc00;
            color: #ffcc00;
            background: transparent;
            padding: 6px 15px;
            border-radius: 5px;
            text-decoration: none;
        }
        .auth-buttons .btn-outline:hover {
            background: #ffcc00;
            color: #0a192f;
        }
        .auth-buttons .btn-gold {
            background: #ffcc00;
            color: #0a192f;
            padding: 6px 15px;
            border-radius: 5px;
            text-decoration: none;
        }
        .auth-buttons .btn-gold:hover {
            background: #ffaa00;
        }
        /* Hero Section */
        .about-hero {
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('images/bg2.png') center/cover no-repeat;
            color: #fff;
            text-align: center;
            padding: 120px 20px;
        }
        .about-hero h2 {
            color: #ffcc00;
            font-size: 48px;
        }
        .about-hero p {
            color: #fff;
            font-size: 18px;
            margin: 15px 0 30px;
        }
        /* Footer */
        footer {
            background-color: #0a192f;
            color: #fff;
            padding: 40px 0;
        }
        footer h3 {
            color: #ffcc00;
        }
        footer a {
            color: #ffcc00;
            text-decoration: none;
        }
        footer a:hover {
            text-decoration: underline;
        }
        .footer-column {
            margin-bottom: 20px;
        }
        .section-title {
            text-align: center;
            margin-bottom: 60px;
        }
        .bus-seats{
            background-color: #0a192f;
        }
        .btn-primary{
            background-color: #ffcc00;
            color: #0a192f;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="container header-content">
            <div class="logo">
                    <img src="images/logo.png"  height="70">
                <h1>Ride<span>sync</span></h1>
            </div>
            <nav>
                <ul>
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="about.jsp">About</a></li>
                    <li><a href="booking.jsp" class="active">Booking</a></li>
                    <li><a href="cancellation.jsp">Cancellation</a></li>
                    <li><a href="gallery.jsp">Gallery</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                </ul>
            </nav>
            <div class="header-right">
                <% if (session.getAttribute("user_email") != null) { %>
    <div class="profile-icon">
        <i class="fas fa-user"></i>
        <div class="profile-dropdown">
            <div class="profile-header">
                <div class="profile-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="profile-info">
                    <h3><%= session.getAttribute("user_name") %></h3>
                    <p><%= session.getAttribute("user_email") %></p>
                </div>
            </div>
            <ul class="dropdown-menu">
                <li><a href="profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a></li>
                <li><a href="edit_profile.jsp"><i class="fas fa-edit"></i> Edit Profile</a></li>
                <li><a href="change_password.jsp"><i class="fas fa-lock"></i> Change Password</a></li>
                <li><a href="user_bookings.jsp"><i class="fas fa-ticket-alt"></i> My Bookings</a></li>
                <li><a href="feedback.jsp"><i class="fas fa-edit"></i> Feedback </a></li>
                <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>
    </div>
<% } else { %>
    <!-- Show icon without dropdown -->
    <div class="profile-icon">
        <i class="fas fa-user"></i>
    </div>
<% } %>

                <div class="auth-buttons">
                    <a href="login.jsp" class="btn btn-outline">Login</a>
                    <a href="register.jsp" class="btn btn-gold">Register</a>
                </div>
            </div>
        </div>
    </header>

    <main class="page">
    <div class="container">
        <h2>Available Buses</h2>
        <p><strong>From:</strong> <%= from %> &nbsp; | &nbsp; <strong>To:</strong> <%= to %> &nbsp; | &nbsp; <strong>Date:</strong> <%= departureDate %> &nbsp; | &nbsp; <strong>Passengers:</strong> <%= passengers %></p>

        <div class="bus-list">
        <%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

    // Get current date and time
    java.util.Date now = new java.util.Date();
    java.sql.Date today = new java.sql.Date(now.getTime());
    java.sql.Time currentTime = new java.sql.Time(now.getTime());

    // Check if the selected departure date is today
    boolean isToday = departureDate.equals(today.toString());

    String sql;
    PreparedStatement ps;

    if (isToday) {
        // Only show buses with departure_time >= current time
        sql = "SELECT * FROM bus_details WHERE route_from = ? AND route_to = ? AND departure_time >= ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, from);
        ps.setString(2, to);
        ps.setTime(3, currentTime);
    } else {
        // Future date → show all buses
        sql = "SELECT * FROM bus_details WHERE route_from = ? AND route_to = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, from);
        ps.setString(2, to);
    }

    ResultSet rs = ps.executeQuery();
    boolean found = false;

    while (rs.next()) {
        found = true;
%>
<div class="bus-item">
    <div class="bus-icon">🚌</div>
    <div class="bus-info">
        <h3><%= rs.getString("bus_name") %> - <%= rs.getString("route_from") %> to <%= rs.getString("route_to") %></h3>
        <p>Bus: <%= rs.getString("bus_name") %></p>
        <p>Departure: <%= rs.getTime("departure_time") %> | Arrival: <%= rs.getTime("arrival_time") %></p>
    </div>
    <div class="bus-seats"><%= rs.getInt("available_seats") %> Seats Available</div>
    <div class="bus-price">₹<%= rs.getBigDecimal("price") %></div>

    <form action="bill.jsp" method="get">
        <input type="hidden" name="bus_id" value="<%= rs.getString("bus_id") %>">
        <input type="hidden" name="bus_name" value="<%= rs.getString("bus_name") %>">
        <input type="hidden" name="price" value="<%= rs.getString("price") %>">
        <input type="hidden" name="date" value="<%= departureDate %>">
        <input type="hidden" name="passengers" value="<%= passengers %>">
        <input type="hidden" name="departure" value="<%= from %>">
        <input type="hidden" name="destination" value="<%= to %>">
        <button type="submit" class="btn btn-primary">Book Now</button>
    </form>
</div>
<%
    } // end while

    if (!found) {
%>
<p>No buses available for this route and time. Please try a different route or time.</p>
<%
    }

    conn.close();
} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
}
%>

        </div>
    </div>
    
</main>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-column">
                    <h3>Ridesync</h3>
                    <p>Your trusted partner for safe, comfortable, and reliable bus travel across the country.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="footer-column">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="home.jsp">Home</a></li>
                        <li><a href="about.jsp">About Us</a></li>
                        <li><a href="booking.jsp">Book Tickets</a></li>
                        <li><a href="cancellation.jsp">Cancel Tickets</a></li>
                        <li><a href="gallery.jsp">Gallery</a></li>
                        <li><a href="contact.jsp">Contact</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h3>Popular Routes</h3>
                    <ul>
                        <li><a href="booking.jsp">Fort Kochi to Aluva</a></li>
                        <li><a href="booking.jsp">Thoppumpady to Kakkanad</a></li>
                        <li><a href="booking.jsp">mattanchery to Chitoor</a></li>
                        <li><a href="booking.jsp">Chellanam to Kakkanad</a></li>
                        <li><a href="booking.jsp">Aluva to Angamaly</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h3>Contact Us</h3>
                    <ul>
                        <li><i class="fas fa-map-marker-alt"></i> ABC street, Kochi, Kerala</li>
                        <li><i class="fas fa-phone"></i> +91 1234567891</li>
                        <li><i class="fas fa-envelope"></i> info@ridesync.com</li>
                        <li><i class="fas fa-clock"></i> 24/7 Customer Support</li>
                    </ul>
                </div>
            </div>
            <div class="copyright">
                <p>&copy; 2025 Ridesync. All rights reserved. | Designed with <i class="fas fa-heart" style="color: var(--accent);"></i> for Bus Travelers</p>
            </div>
        </div>
    </footer>



    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

    <script>
        // Toggle profile dropdown
        document.querySelector('.profile-icon').addEventListener('click', function(e) {
            e.stopPropagation();
            const dropdown = document.querySelector('.profile-dropdown');
            dropdown.classList.toggle('active');
        });
        
        // Close dropdown when clicking elsewhere
        document.addEventListener('click', function(e) {
            const dropdown = document.querySelector('.profile-dropdown');
            if (dropdown.classList.contains('active') && 
                !e.target.closest('.profile-dropdown') && 
                !e.target.closest('.profile-icon')) {
                dropdown.classList.remove('active');
            }
        });
    </script>
</body>
</html>
