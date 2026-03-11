<%-- 
    Document   : contact
    Created on : 17 Jul, 2025, 12:18:06 AM
    Author     : CAREN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String status = "";  // Add this declaration

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("full_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

            PreparedStatement stmt = conn.prepareStatement("INSERT INTO contact_messages(full_name, email, phone, subject, message) VALUES (?, ?, ?, ?, ?)");
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, subject);
            stmt.setString(5, message);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                status = "Message sent successfully!";
            } else {
                status = "Failed to send message.";
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            status = "Error occurred: " + e.getMessage();
        }
    }
%>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ridesync - Home</title>
    <link rel="stylesheet" href="style.css">
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
    background-color: #0a192f;
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
.features {
    margin-bottom: 0;
    padding-bottom: 0;
}

.booking-form-container {
    margin-top: 0;
    background-color: #0a192f;
}


/* Section Titles */
.section-title h2 {
    color: #0a192f;
    font-size: 36px;
    text-align: center;
    margin-bottom: 15px;
}
.section-title p {
    color: #0a192f;
    text-align: center;
    margin-bottom: 40px;
}

/* Contact Form Styling (theme similar to cancel form) */
.contact-form {
    max-width: 650px;
    margin: 40px auto;
    padding: 30px 25px;
    background-color: #112240; /* dark blue background */
    border: 2px solid #ffcc00; /* gold border */
    border-radius: 10px;
    color: #fff;
    font-family: 'Segoe UI', sans-serif;
    box-shadow: 0 8px 20px rgba(0,0,0,0.4);
}

.contact-form h2 {
    color: #ffcc00;
    text-align: center;
    margin-bottom: 30px;
    font-size: 28px;
    
}

.contact-form .form-group {
    margin-bottom: 20px;
}

.contact-form label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
    color: #ffcc00;
}

.contact-form input,
.contact-form textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ffcc00;
    border-radius: 5px;
    background-color: #0a192f;
    color: #ffcc00; /* gold text for visibility */
    font-family: 'Segoe UI', sans-serif;
    font-size: 16px;
    outline: none;
    caret-color: #ffcc00;
}

.contact-form input::placeholder,
.contact-form textarea::placeholder {
    color: #ccc;
}

.contact-form input:focus,
.contact-form textarea:focus {
    border-color: #ffaa00;
    box-shadow: 0 0 5px #ffaa00;
}

.contact-form .btn {
    width: 100%;
    padding: 12px;
    background-color: #ffcc00;
    color: #0a192f;
    font-weight: bold;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: 0.3s;
}

.contact-form .btn:hover {
    background-color: #ffaa00;
}
.features {
            background-color: #0d1b2a;
            padding: 60px 0;
        }
        .section-title h2 {
            color: #ffcc00;
            text-align: center;
        }
        .section-title p {
            color: #ddd;
            text-align: center;
            
        }
        .features-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .feature-card {
            background-color: #1e3a5f;
            color: #fff;
            border-radius: 10px;
            padding: 25px;
            width: 280px;
            text-align: center;
            transition: transform 0.3s;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            background-color: #264273;
        }
        .feature-card h3 {
            color: #ffcc00;
        }
        .feature-card p, .feature-card ul li {
            color: #ddd;
        }
        .feature-icon i {
            font-size: 40px;
            margin-bottom: 15px;
            color: #ffcc00;
        }
        .feature-card ul {
            text-align: left;
            padding-left: 15px;
            margin-top: 10px;
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
                    <li><a href="booking.jsp">Booking</a></li>
                    <li><a href="cancellation.jsp">Cancellation</a></li>
                    <li><a href="gallery.jsp">Gallery</a></li>
                    <li><a href="contact.jsp" class="active">Contact</a></li>
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
            <div class="section-title">
                <h2>Contact Us</h2>
                <p>We're here to help with any questions</p>
            </div>
            
            
            
            <div class="features" style="margin-top: 60px;">
                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <h3>Our Location</h3>
                        <p>ABC Street<br>Kochi, Kerala <br>India</p>
                    </div>
                    
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-phone-alt"></i>
                        </div>
                        <h3>Call Us</h3>
                        <p>+91 1234567891<br>+91 1122344567</p>
                        <p>Monday-Friday: 8am-8pm<br>Saturday-Sunday: 9am-5pm</p>
                    </div>
                    
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <h3>Email Us</h3>
                        <p>info@ridesync.com<br>support@ridesync.com<br>bookings@ridesync.com</p>
                    </div>
                </div>
            </div>
            <div class="booking-form-container">
                <form class="contact-form" method="post">
    <% if (!status.isEmpty()) { %>
        <p style="color: green; text-align: center;"><%= status %></p>
    <% } %>
<!--     form fields remain unchanged -->

                    <div class="form-group">
                        <label for="contact-name">Full Name</label>
                        <input type="text" id="contact-name" name="full_name" placeholder="Enter your full name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="contact-email">Email Address</label>
                        <input type="email" id="contact-email" name="email" placeholder="Enter your email" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="contact-phone">Phone Number</label>
                        <input type="tel" id="contact-phone" name="phone" placeholder="Enter your phone number" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="contact-subject">Subject</label>
                        <input type="text" id="contact-subject" name="subject" placeholder="Enter subject" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="contact-message">Message</label>
                        <textarea id="contact-message" rows="5" name="message" placeholder="Enter your message" required></textarea>
                    </div>
                    
                    <div class="form-submit">
                        <button type="submit" class="btn btn-primary btn-lg">Send Message</button>
                    </div>
                </form>
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
    <!-- SweetAlert2 CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<% if (!status.isEmpty()) { %>
<script>
    Swal.fire({
        icon: '<%= status.equals("Message sent successfully!") ? "success" : "error" %>',
        title: '<%= status %>',
        showConfirmButton: true,
        confirmButtonText: 'OK'
    }).then(() => {
        // Redirect to home only on success
        <% if (status.equals("Message sent successfully!")) { %>
            window.location.href = "home.jsp";
        <% } %>
    });
</script>
<% } %>


</body>
</html>
