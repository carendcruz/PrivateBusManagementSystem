<%-- 
    Document   : about
    Created on : 15 Jul, 2025, 10:41:21 PM
    Author     : CAREN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ridesync - About Us</title>
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

        /* Mission & Vision Cards */
        .mission-vision {
            display: flex;
            gap: 30px;
            justify-content: center;
            flex-wrap: wrap;
            margin: 60px 0;
        }
        .mv-card {
            background-color: #1e3a5f;
            color: #fff;
            border-radius: 10px;
            padding: 25px;
            max-width: 500px;
            text-align: center;
            transition: transform 0.3s;
        }
        .mv-card:hover {
            transform: translateY(-5px);
            background-color: #264273;
        }
        .mv-card h3 {
            color: #ffcc00;
        }
        .mv-card p {
            color: #ddd;
        }

        /* Stats Section */
        .stats {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 40px;
            margin: 60px 0;
        }
        .stat-item {
            text-align: center;
        }
        .stat-item h4 {
            font-size: 2rem;
            color: #ffcc00;
            margin-bottom: 5px;
        }
        .stat-item p {
            color: #ddd;
            font-weight: 500;
        }

        /* Features & Fleet Sections */
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

        /* Map */
        #map {
            width: 100%;
            height: 400px;
            border-radius: 10px;
            margin: 40px 0;
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
    </style>
</head>
<body>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB5pTk7dBrz4cEgQQPaLvItpvs9dVxy-KY&callback=initMap" async defer></script>
    <script>
        function initMap() {
            const location = { lat: 9.931354636131143,  lng: 76.2496709423283 };
            const map = new google.maps.Map(document.getElementById("map"), {
                zoom: 12,
                center: location,
            });
            const marker = new google.maps.Marker({
                position: location,
                map: map,
            });
        }
    </script>

    <!-- Header Section -->
    <header>
        <div class="container header-content">
            <div class="logo">
                <img src="images/logo.png" height="70">
                <h1>Ride<span>sync</span></h1>
            </div>
            <nav>
                <ul>
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="about.jsp" class="active">About</a></li>
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
                                </div>
                            </div>
                            <ul class="dropdown-menu">
                                <li><a href="profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a></li>
                                <li><a href="edit_profile.jsp"><i class="fas fa-edit"></i> Edit Profile</a></li>
                                <li><a href="change_password.jsp"><i class="fas fa-lock"></i> Change Password</a></li>
                                <li><a href="user_booings.jsp"><i class="fas fa-ticket-alt"></i> My Bookings</a></li>
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
        <!-- About Hero -->
        <div class="about-hero">
            <div class="container">
                <h2>About Ridesync</h2>
                <h4>Your trusted partner for premium bus travel experiences since 2025</h4>

                <!-- Mission & Vision -->
                <div class="mission-vision">
                    <div class="mv-card">
                        <h3>Our Mission</h3>
                        <p>To provide safe, comfortable, and reliable transportation to all our passengers while reducing our environmental impact through sustainable practices.</p>
                    </div>
                    <div class="mv-card">
                        <h3>Our Vision</h3>
                        <p>To become the most trusted and preferred bus service provider by continuously improving our services and customer experience.</p>
                    </div>
                </div>

                <!-- Stats -->
                <div class="stats">
                    <div class="stat-item">
                        <h4>250+</h4>
                        <p>Premium Buses</p>
                    </div>
                    <div class="stat-item">
                        <h4>500+</h4>
                        <p>Daily Trips</p>
                    </div>
                    <div class="stat-item">
                        <h4>120+</h4>
                        <p>Destinations</p>
                    </div>
                    <div class="stat-item">
                        <h4>1M+</h4>
                        <p>Happy Customers</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Features -->
        <div class="features">
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
                </div>

                <!-- Map -->
                <div id="map"></div>
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
        document.querySelectorAll('.profile-icon').forEach(function(icon){
            icon.addEventListener('click', function(e) {
                e.stopPropagation();
                const dropdown = icon.querySelector('.profile-dropdown');
                if(dropdown) dropdown.classList.toggle('active');
            });
        });

        // Close dropdown when clicking elsewhere
        document.addEventListener('click', function(e) {
            document.querySelectorAll('.profile-dropdown.active').forEach(function(dropdown){
                if(!e.target.closest('.profile-dropdown') && !e.target.closest('.profile-icon')){
                    dropdown.classList.remove('active');
                }
            });
        });
    </script>
</body>
</html>
