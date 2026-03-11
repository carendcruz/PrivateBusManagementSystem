<%-- 
    Document   : booking
    Created on : 16 Jul, 2025, 11:58:04 PM
    Author     : CAREN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String user = (String) session.getAttribute("user_email");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ridesync - Booking</title>
    <link rel="stylesheet" href="style.css">
    <style>
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
        /* Booking Section (match dashboard) */
    main.page {
        padding: 60px 20px;
    }
    .section-title h2 {
        font-size: 32px;
        color: #ffcc00;
        margin-bottom: 10px;
    }
    .section-title p { color: #ffcc00; }
    /* Inputs, selects, textarea (normal state) */
.booking-form input,
.booking-form select,
.booking-form textarea {
    width: 100%;
    padding: 10px;
    border-radius: 6px;
    font-size: 15px;
    background-color: #1e293b; /* dark background */
    color: #f1f5f9;            /* light text */
    border: 1px solid #334155;
    transition: all 0.2s ease;
}

/* On focus (when selected) */
.booking-form input:focus,
.booking-form select:focus,
.booking-form textarea:focus {
    background-color: #0f172a; /* even darker background */
    outline: none;             /* remove default browser outline */
    border: 1px solid #facc15; /* golden yellow border */
    color: #f1f5f9;
}

    .booking-form-container {
    max-width: 700px;
    margin: 0 auto;
    background: #112240;   /* dark blue card background */
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.25);
    color: #fff;   /* text stays white */
   
}
    .booking-form .form-group {
        margin-bottom: 20px;
    }
    .booking-form label {
    color: #ffcc00;  /* yellow labels */
}
    .booking-form select,
.booking-form input,.booking-form option
{
    width: 100%;
    padding: 10px;
    border-radius: 6px;
    font-size: 15px;
    background: #112240;
    color: #fff;
    border: 1px solid #ffcc00;/* dark inputs */
    color: #fff;
}
    .form-submit {
        text-align: center;
        margin-top: 20px;
    }
    .form-submit button {
        background: #ffcc00;
        color: #0a192f;
        border: none;
        padding: 12px 30px;
        border-radius: 8px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: background 0.3s;
    }
    .form-submit button:hover {
        background: #ffaa00;
    }
    textarea,
input {
  background-color: #1e293b; /* dark background */
  color: #f1f5f9;           /* light text */
  border: 1px solid #334155;
  border-radius: 8px;
  padding: 10px;
  transition: all 0.2s ease;
}

textarea:focus,
input:focus {
  background-color: #0f172a; /* even darker when selected */
  outline: none;             /* remove browser default outline */
  border: 1px solid #facc15; /* highlight with yellow border */
  color: #f1f5f9;
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
        <div class="section-title">
            <h2>Book Your Journey</h2>
            <p>Select your route and search available buses</p>
        </div>

        <!-- Booking Form -->
        <div class="booking-form-container">
            <form class="booking-form" method="get" action="search_buses.jsp">
                <div class="form-group">
                    <label for="from_location">From</label>
                    <select name="from_location" id="from_location" required>
                        <option value="" disabled selected>Select departure</option>
                        <option value="FortKochi">FortKochi</option>
                        <option value="Aluva">Aluva</option>
                        <option value="Kakkanad">Kakkanad</option>
                        <option value="Thoppumpady">Thoppumpady</option>
                        <option value="Angamaly">Angamaly</option>
                        <option value="Chellanam">Chellanam</option>
                        <option value="Kaloor">Kaloor</option>
                        <option value="Edapally">Edapally</option>
                        <option value="High Court">High Court</option>
                        <option value="Stadium">Stadium</option>
                        <option value="Palluruthy">Palluruthy</option>
                        <option value="Thevara">Thevara</option>
                        <option value="Mattanchery">Mattanchery</option>
                        <option value="Chitoor">Chitoor</option>
                        <option value="Pachalam">Pachalam</option>
                        <option value="Vytila">Vytila</option>
                        <option value="Menaka">Menaka</option>
                        <option value="MG Road">MG Road</option>
                        <option value="Muttom">Muttom</option>
                        <option value="Kalamassery">Kalamassery Town</option>
                        <option value="Pathadipalam">Pathadipalam</option>
                        <option value="Changampuzha">Changampuzha Park</option>
                        <option value="Panchayath">Panchayath</option>
                        
                    </select>
                </div>

                <div class="form-group">
                    <label for="to_location">To</label>
                    <select name="to_location" id="to_location" required>
                        <option value="" disabled selected>Select destination</option>
                        <option value="FortKochi">Fort Kochi</option>
                        <option value="Aluva">Aluva</option>
                        <option value="Kakkanad">Kakkanad</option>
                        <option value="Thoppumpady">Thoppumpady</option>
                        <option value="Angamaly">Angamaly</option>
                        <option value="Chellanam">Chellanam</option>
                        <option value="Kaloor">Kaloor</option>
                        <option value="Edapally">Edapally</option>
                        <option value="High Court">High Court</option>
                        <option value="Stadium">Stadium</option>
                        <option value="Palluruthy">Palluruthy</option>
                        <option value="Thevara">Thevara</option>
                        <option value="Mattanchery">Mattanchery</option>
                        <option value="Chitoor">Chitoor</option>
                        <option value="Pachalam">Pachalam</option>
                        <option value="Vytila">Vytila</option>
                        <option value="Menaka">Menaka</option>
                        <option value="MG Road">MG Road</option>
                        <option value="Muttom">Muttom</option>
                        <option value="Kalamassery">Kalamassery Town</option>
                        <option value="Pathadipalam">Pathadipalam</option>
                        <option value="Changampuzha">Changampuzha Park</option>
                        <option value="Panchayath">Panchayath</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="departure_date">Departure Date</label>
                    <input type="date" name="departure_date" id="departure_date" required min="" required>
                </div>

                <div class="form-group">
                    <label for="passengers">Passengers</label>
                    <select name="passengers" id="passengers" required>
                        <option value="1">1 Passenger</option>
                        <option value="2">2 Passengers</option>
                        <option value="3">3 Passengers</option>
                        <option value="4">4 Passengers</option>
                        <option value="5">5 Passengers</option>
                    </select>
                </div>

                <div class="form-submit">
                    <button type="submit" class="btn btn-primary btn-lg">Search Buses</button>
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
         // Prevent booking on past dates
    const dateInput = document.getElementById("departure_date");
    const today = new Date().toISOString().split("T")[0];
    dateInput.setAttribute("min", today);
    </script> 
    <!-- Include Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
