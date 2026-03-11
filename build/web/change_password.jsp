<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String email = (String) session.getAttribute("user_email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String alertType = "";
    String alertMessage = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String oldPassword = request.getParameter("old_password");
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");

        if (!newPassword.equals(confirmPassword)) {
            alertType = "error";
            alertMessage = "New passwords do not match!";
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

                PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM users WHERE email=? AND password=?");
                checkStmt.setString(1, email);
                checkStmt.setString(2, oldPassword);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    PreparedStatement updateStmt = conn.prepareStatement("UPDATE users SET password=? WHERE email=?");
                    updateStmt.setString(1, newPassword);
                    updateStmt.setString(2, email);
                    int updated = updateStmt.executeUpdate();
                    if (updated > 0) {
                        alertType = "success";
                        alertMessage = "Password updated successfully!";
                    } else {
                        alertType = "error";
                        alertMessage = "Failed to update password.";
                    }
                } else {
                    alertType = "error";
                    alertMessage = "Incorrect old password!";
                }

                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                alertType = "error";
                alertMessage = "Error: " + e.getMessage();
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
     <meta charset="UTF-8">
    <title>Change Password - RideSync</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        /* Body and Page Background */
        html, body,  footer {
    background-color: #0a192f; /* Dark background */
    margin: 0;
    padding: 0;
    color: #fff;
    font-family: "Segoe UI", sans-serif;
    min-height: 100vh; /* ensures full height */
}
/* Main Section */
main {
    margin: 0;              /* remove white gap */
    padding: 40px 0;        /* optional spacing inside main */
    background-color: #0a192f; /* match body background */
    min-height: calc(100vh - 160px); /* fill space between header and footer */
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
        /* Form Container */
.form-container {
    background: #1e293b; /* subtle transparent box */
    padding: 30px;
    max-width: 500px;
    margin: 60px auto;
    border-radius: 12px;
    border: 1px solid #ffcc00;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
    text-align: center;
}

/* Form Heading */
.form-container h2 {
    margin-bottom: 20px;
    color: #ffcc00;
    font-size: 1.8rem;
}

/* Form Fields */
.form-group {
    margin-bottom: 20px;
    text-align: left;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #fff;
}

.form-group input {
    width: 100%;
    padding: 10px 12px;
    border-radius: 6px;
    border: 1px solid #ccc;
    background-color: #0a192f;
    color: #fff;
    font-size: 1rem;
}

.form-group input:focus {
    background-color: #0f172a;
            border: 1px solid #facc15;
            outline: none;
}

/* Button */
.form-container .btn {
    background: #ffcc00;
    color: #0a192f;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    transition: 0.3s;
}

.form-container .btn:hover {
    background: #ffaa00;
}

/* Back Link */
.back-link {
    display: inline-block;
    margin-top: 20px;
    color: #ffcc00;
    text-decoration: none;
    font-size: 0.95rem;
}

.back-link:hover {
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
                    <li><a href="cancellation.jsp" class="active">Cancellation</a></li>
                    <li><a href="gallery.jsp">Gallery</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                </ul>
            </nav>
            <div class="header-right">
                <% if (session.getAttribute("user_email") != null) { %>
    <%
    String userEmail = (String) session.getAttribute("user_email");
    String userName = (String) session.getAttribute("user_name");
%>

<div class="profile-icon">
    <i class="fas fa-user"></i>

    <% if (userEmail != null && userName != null) { %>
        <div class="profile-dropdown">
            <div class="profile-header">
                <div class="profile-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="profile-info">
                    <h3><%= userName %></h3>
                    <p><%= userEmail %></p>
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
    <% } %>
</div>

<% } else { %>
    <!-- Show icon without dropdown -->
    <div class="profile-icon">
        <i class="fas fa-user"></i>
    </div>
<% } %>

                </div>
                <div class="auth-buttons">
                    <a href="login.jsp" class="btn btn-outline">Login</a>
                </div>
                    <div class="auth-buttons">
                    <a href="register.jsp" class="btn btn-gold">Register</a>
                </div>
            </div>
        </div>
    </header>
<main>
<div class="form-container">
    <h2>Change Password</h2>

    <form method="post">
        <div class="form-group">
            <label>Old Password</label>
            <input type="password" name="old_password" required>
        </div>
        <div class="form-group">
            <label>New Password</label>
            <input type="password" name="new_password" required>
        </div>
        <div class="form-group">
            <label>Confirm New Password</label>
            <input type="password" name="confirm_password" required>
        </div>
        <button type="submit" class="btn">Change Password</button>
    </form>

    <a href="profile.jsp" class="back-link">← Back to Profile</a>
</div>
    
<% if (!alertMessage.isEmpty()) { %>
<script>
    Swal.fire({
        icon: '<%= alertType %>',
        title: '<%= alertType.equals("success") ? "Success!" : "Oops!" %>',
        text: '<%= alertMessage %>',
        confirmButtonColor: '#005ce6'
    });
</script>
<% } %>
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
