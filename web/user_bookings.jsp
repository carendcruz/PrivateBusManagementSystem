<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<%
    String userEmail = (String) session.getAttribute("user_email");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Bookings - RideSync</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* General Theme */
       html, body,  footer {
    background-color: #0a192f; /* Dark background */
    margin: 0;
    padding: 0;
    color: #fff;
    font-family: "Segoe UI", sans-serif;
    min-height: 100vh; /* ensures full height */
}
body {
    display: flex;
    flex-direction: column;
}
/* Main Section */
main {
    margin: 0;              /* remove white gap */
    padding: 40px 0;        /* optional spacing inside main */
    background-color: #0a192f; /* match body background */
    min-height: calc(100vh - 160px); /* fill space between header and footer */
   
    flex: 1; /* takes remaining space between header and footer */
    

}

        .container {
            background-color: transparent;
        }

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

        /* Bookings Table */
        .booking-table-container {
            max-width: 1000px;
            margin: 50px auto;
            background: #112240;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.6);
        }
        .booking-table-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #ffcc00;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: #0a192f;
            border-radius: 8px;
            overflow: hidden;
        }
        table th, table td {
            padding: 15px;
            text-align: center;
        }
        table th {
            background: #ffcc00;
            color: #0a192f;
        }
        table tr:nth-child(even) {
            background: #112240;
        }
        table tr:nth-child(odd) {
            background: #0d1b3d;
        }
        table td {
            color: #fff;
        }

        .no-bookings {
            text-align: center;
            padding: 30px;
            color: #ffcc00;
            font-size: 18px;
        }

        .btn-back {
            display: inline-block;
            margin: 20px auto;
            padding: 10px 18px;
            background: #ffcc00;
            color: #0a192f;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
        }
        .btn-back:hover {
            background: #ffaa00;
        }

        /* Footer */
        footer {
            background-color: #0a192f;
            color: #fff;
            padding: 40px 0;
            margin-top: 0;
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
    </style>
</head>
<body>

<header>
    <div class="container header-content">
        <div class="logo">
            <img src="images/logo.png" height="70">
            <h1>Ride<span>sync</span></h1>
        </div>
        <nav>
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="about.jsp">About</a></li>
                <li><a href="booking.jsp">Booking</a></li>
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
                        <div class="profile-avatar"><i class="fas fa-user"></i></div>
                        <div class="profile-info">
                            <h3><%= session.getAttribute("user_name") %></h3>
                            <p><%= session.getAttribute("user_email") %></p>
                        </div>
                    </div>
                    <ul class="dropdown-menu">
                        <li><a href="profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a></li>
                        <li><a href="edit_profile.jsp"><i class="fas fa-edit"></i> Edit Profile</a></li>
                        <li><a href="change_password.jsp"><i class="fas fa-lock"></i> Change Password</a></li>
                        <li><a href="user_bookings.jsp" class="active"><i class="fas fa-ticket-alt"></i> My Bookings</a></li>
                        <li><a href="feedback.jsp"><i class="fas fa-edit"></i> Feedback </a></li>
                        <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </div>
            </div>
            <% } else { %>
            <div class="profile-icon"><i class="fas fa-user"></i></div>
            <% } %>
            <div class="auth-buttons">
                <a href="login.jsp" class="btn btn-outline">Login</a>
                <a href="register.jsp" class="btn btn-gold">Register</a>
            </div>
        </div>
    </div>
</header>
            <main>
<div class="booking-table-container">
    <h2>My Bookings</h2>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

            String sql = "SELECT * FROM bookings WHERE user_email = ? ORDER BY travel_date DESC";
            ps = conn.prepareStatement(sql);
            ps.setString(1, userEmail);
            rs = ps.executeQuery();

            if (!rs.isBeforeFirst()) {
    %>
        <div class="no-bookings">You have no bookings yet.</div>
    <%
            } else {
    %>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Bus Name</th>
                    <th>Date</th>
                    <th>Passengers</th>
                    <th>Total Paid</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
    <%
                while (rs.next()) {
    %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("bus_name") %></td>
                    <td><%= rs.getString("travel_date") %></td>
                    <td><%= rs.getInt("passengers") %></td>
                    <td>₹<%= rs.getDouble("total_amount") %></td>
                    <td><%= rs.getString("payment_status") %></td>
                </tr>
    <%
                }
    %>
            </tbody>
        </table>
    <%
            }
        } catch (Exception e) {
    %>
        <p style="color:red; text-align:center;">Error fetching bookings: <%= e.getMessage() %></p>
    <%
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    %>
</div>
<div style="text-align: center;">
    <a href="home.jsp" class="btn-back">⬅ Back to Home</a>
</div>
            </main>
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
                    <li><a href="booking.jsp">Mattanchery to Chitoor</a></li>
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
