<%-- 
    Document   : login
    Created on : 16 Jul, 2025, 11:44:39 PM
    Author     : CAREN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ridesync - Login</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        /* Body and Page Background */
        html, body, main, footer {
            background-color: #0a192f;
            margin: 0;
            padding: 0;
            color: #fff;
            font-family: "Segoe UI", sans-serif;
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

        /* Login Form */
        

        .login-form-container {
            max-width: 450px;
            margin: 40px auto;
            padding: 30px 25px;
            background-color: #112240; /* dark card */
            border: 2px solid #ffcc00; /* gold border */
            border-radius: 12px;
            color: #fff;
            font-family: 'Segoe UI', sans-serif;
            box-shadow: 0 0 0 3px white, 0 8px 20px rgba(0,0,0,0.4); /* white outline + shadow */
        }

        .login-form-container h2 {
            color: #ffcc00;
            text-align: center;
            margin-bottom: 20px;
        }

        .login-form-container .form-group {
            margin-bottom: 20px;
        }

        .login-form-container label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #ffcc00;
        }
        .login-form-container input,
        .login-form-container select {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            font-size: 15px;
            background-color: #1e293b;
            color: #fff;
            border: 1px solid #334155;
            transition: all 0.2s ease;
        }

        .login-form-container input::placeholder {
            color: #ccc;
        }

        .login-form-container input:focus,
        .login-form-container select:focus {
            background-color: #0f172a;
            border: 1px solid #facc15;
            outline: none;
        }

        .login-form-container .btn {
            width: 100%;
            padding: 12px;
            background-color: #ffcc00;
            color: #0a192f;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.3s;
        }

        .login-form-container .btn:hover {
            background-color: #ffaa00;
        }

        .login-form-container p a {
            color: #ffcc00;
            font-weight: bold;
            text-decoration: none;
        }

        .login-form-container p a:hover {
            text-decoration: underline;
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
        .section-title h2{
            color: #ffcc00;
        }
        .section-title p {
            color: #ffcc00;
        }
    </style>
</head>
<body>
    <!-- Header Section -->
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
                            <div class="profile-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="profile-info">
                                <h3><%= session.getAttribute("user_name") %></h3>
                                <p><%= session.getAttribute("user_email") %></p>
                                <p><%= session.getAttribute("user_role") %></p>
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
            <div class="section-title">
                <h2>Login to Your Account</h2>
                <p>Access your bookings and manage your account</p>
            </div>
            
            <div class="login-form-container">
                <form class="login-form" method="post" action="">
                    <div class="form-group">
                        <label for="login-username">Username or Email</label>
                        <input type="text" id="login-username" name="email" placeholder="Enter your email" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="login-password">Password</label>
                        <input type="password" id="login-password" name="password" placeholder="Enter your password" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="login-role">Login As</label>
                        <select id="login-role" name="role" required>
                            <option value="passenger">Passenger</option>
                            <option value="admin">Administrator</option>
                        </select>
                    </div>
                    
                    <div class="form-submit">
                        <button type="submit" class="btn">Login</button>
                    </div>
                    
                    <div style="text-align: center; margin-top: 20px;">
                        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
                    </div>
                </form>
            </div>
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

    <!-- Font Awesome Icons -->
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
            if (dropdown && dropdown.classList.contains('active') && 
                !e.target.closest('.profile-dropdown') && 
                !e.target.closest('.profile-icon')) {
                dropdown.classList.remove('active');
            }
        });
    </script>
    
    <%
    String loginMessage = "";

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

            String sql = "SELECT * FROM users WHERE email=? AND password=? AND role=?";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.setString(3, role);
            rs = stmt.executeQuery();

            if (rs.next()) {
                loginMessage = "success";

                // Fetch first and last name
                String first = rs.getString("first_name");
                String last = rs.getString("last_name");
                String fullName = first + " " + last;

                // Set session attributes
                session.setAttribute("user_email", email);
                session.setAttribute("user_name", fullName);
                session.setAttribute("user_role", rs.getString("role"));
            }
            else {
                loginMessage = "failed";
            }

        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
%>
<%
    if ("success".equals(loginMessage)) {
        String role = (String) session.getAttribute("user_role");
        String redirectPage = "booking.jsp"; // default
        if ("admin".equals(role)) {
            redirectPage = "admin_dashboard.jsp";
        }
%>
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Login Successful',
            text: 'Welcome back!',
            timer: 2000,
            showConfirmButton: false
        }).then(() => {
            window.location.href = '<%= redirectPage %>'
        });
    </script>
<%
    } else if ("failed".equals(loginMessage)) {
%>
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Login Failed',
            text: 'Invalid email or password',
        });
    </script>
<%
    }
%>
</body>
</html>
