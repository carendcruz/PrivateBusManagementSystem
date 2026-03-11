<%-- 
    Document   : home
    Created on : 15 Jul, 2025, 10:36:43 PM
    Author     : CAREN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ridesync - Home</title>
    <link rel="stylesheet" href="style.css">
    <style>
    /* Body and Page Background */
    html, body, footer {
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

    /* Hero Section */
    .hero {
        background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('images/bg2.png') center/cover no-repeat;
        color: #fff;
        text-align: center;
        padding: 120px 20px;
    }
    .hero h2 {
        color: #ffcc00;
        font-size: 48px;
    }
    .hero p {
        color: #fff;
        font-size: 18px;
        margin: 15px 0 30px;
    }
    .hero .btn-primary {
        background-color: #ffcc00;
        color: #0a192f;
        padding: 10px 25px;
        border-radius: 5px;
        text-decoration: none;
    }
    .hero .btn-primary:hover {
        background-color: #ffaa00;
    }
    .hero .btn-accent {
        background-color: #1e3a8a;
        color: #fff;
        padding: 10px 25px;
        border-radius: 5px;
        text-decoration: none;
    }
    .hero .btn-accent:hover {
        background-color: #3b5998;
    }

    /* Features Section */
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
    .feature-card p {
        color: #ddd;
    }
    .feature-icon i {
        font-size: 40px;
        margin-bottom: 15px;
        color: #ffcc00;
    }

    /* Bus Fleet Gallery */
    .gallery {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: center;
        margin-top: 40px;
    }
    .gallery-item {
        position: relative;
        width: 300px;
        overflow: hidden;
        border-radius: 10px;
    }
    .gallery-item img {
        width: 100%;
        display: block;
        transition: transform 0.3s;
    }
    .gallery-item:hover img {
        transform: scale(1.1);
    }
    .gallery-item .overlay {
        position: absolute;
        bottom: 0;
        width: 100%;
        padding: 15px;
        background: rgba(13, 27, 42, 0.9);
        color: #ffcc00;
        text-align: center;
        font-weight: bold;
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
    .features[style] {
    background-color: #0d1b2a !important;
    padding: 60px 0 !important;
}
/* Bus Fleet Gallery Section */
.features.gallery-section {
    background-color: #0d1b2a; /* same dark color */
    padding: 80px 0;
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
                    <li><a href="home.jsp" class="active">Home</a></li>
                    <li><a href="about.jsp">About</a></li>
                    <li><a href="booking.jsp">Booking</a></li>
                    <li><a href="cancellation.jsp">Cancellation</a></li>
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
                    <a href="register.jsp" class="btn btn-gold">Register</a>
                </div>
            </div>
        </div>
    </header>

    <!-- Home Page -->
<main class="page">
    <!-- Hero Section -->
    <div class="hero">
        <div class="container hero-content">
            <h2>Premium Bus Travel Experience</h2>
            <p>Travel in comfort and style with our luxury bus fleet. Book your journey today!</p>
            <div class="cta-buttons">
                <a href="booking.jsp" class="btn btn-primary btn-lg">Book Ticket</a>
                <a href="about.jsp" class="btn btn-accent btn-lg">Learn More</a>
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div class="features" style="background-color: #0d1b2a; padding: 60px 0;">
        <div class="container">
            <div class="section-title">
                <h2>Why Choose Ridesync?</h2>
                <p>We provide premium bus services with a commitment to safety, comfort, and reliability.</p>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon"><i class="fas fa-shield-alt"></i></div>
                    <h3>Safety First</h3>
                    <p>Our buses are equipped with modern safety features and regularly maintained by certified technicians.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon"><i class="fas fa-couch"></i></div>
                    <h3>Comfortable Seats</h3>
                    <p>Experience luxury travel with our premium recliner seats and ample legroom for a relaxing journey.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon"><i class="fas fa-wifi"></i></div>
                    <h3>Free Wi-Fi</h3>
                    <p>Stay connected throughout your journey with our complimentary high-speed internet service.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon"><i class="fas fa-ticket-alt"></i></div>
                    <h3>Easy Booking</h3>
                    <p>Book, modify, or cancel your tickets in just a few clicks with our user-friendly platform.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon"><i class="fas fa-headset"></i></div>
                    <h3>24/7 Support</h3>
                    <p>Our dedicated customer service team is available around the clock to assist you.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Bus Fleet Gallery Section -->
    <div class="features gallery-section">
    <div class="container">
        <div class="section-title">
            <h2>Our Bus Fleet</h2>
            <p>Modern, comfortable buses for your travel needs</p>
        </div>
        <div class="gallery">
            <div class="gallery-item">
                <img src="images/bus4.png" alt="Luxury Bus">
                <div class="overlay">Different Routes</div>
            </div>
            <div class="gallery-item">
                <img src="images/bus7.png" alt="Bus Interior">
                <div class="overlay">Interior</div>
            </div>
            <div class="gallery-item">
                <img src="images/bus6.png" alt="Bus Seats">
                <div class="overlay">Comfortable</div>
            </div>
        </div>
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
            if (dropdown.classList.contains('active') && 
                !e.target.closest('.profile-dropdown') && 
                !e.target.closest('.profile-icon')) {
                dropdown.classList.remove('active');
            }
        });
    </script>

    
</body>
</html>
