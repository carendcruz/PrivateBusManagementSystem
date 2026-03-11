<%-- 
    Document   : book
    Created on : 18 Jul, 2025, 11:44:49 PM
    Author     : CAREN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ridesync | Bus Booking</title>
    <link rel="stylesheet" href="style.css">
    
</head>

<body>
    
    <header>
        <div class="container header-content">
            <div class="logo">
                <i class="fas fa-bus"></i>
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
                <li><a href="#"><i class="fas fa-edit"></i> Edit Profile</a></li>
                <li><a href="#"><i class="fas fa-lock"></i> Change Password</a></li>
                <li><a href="user_bookings.jsp"><i class="fas fa-ticket-alt"></i> My Bookings</a></li>
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
                <p>Find the perfect bus for your next trip</p>
            </div>

            <div class="booking-form-container">
                <form class="booking-form">
                    

                    

                    <div class="form-group">
                        <label for="departure">Departure Date</label>
                        <input type="date" id="departure" required>
                    </div>

                    <div class="form-group">
                        <label for="return">Return Date (Optional)</label>
                        <input type="date" id="return">
                    </div>

                    <div class="form-group">
                        <label for="passengers">Passengers</label>
                        <select id="passengers" required>
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

            <!-- <div class="map-container">
                <div class="map-bg"></div>
                <div class="map-placeholder">
                    <i class="fas fa-map-marked-alt"></i>
                    <h3>Interactive Route Map</h3>
                    <p>View your route and stops on our interactive map</p>
                </div>
            </div> -->
            <div id="map"></div>


            <div class="driver-info">
                <div class="driver-photo">
                    <i class="fas fa-user"></i>
                </div>
                <div class="driver-details">
                    <h3>Driver Information</h3>
                    <p><strong>Name:</strong> Robert Johnson</p>
                    <p><strong>Experience:</strong> 12 years</p>
                    <p><strong>Rating:</strong> ★★★★★ (4.9/5)</p>
                    <p><strong>Contact:</strong> +1 (555) 123-4567</p>
                    <p><strong>License:</strong> CDL-789456123</p>
                </div>
            </div>

            <div class="booking-summary">
                <h3>Booking Summary</h3>
                <div class="summary-item">
                    <span>Fort-kochi to Aluva</span>
                    <span>Rs.40.00</span>
                </div>
                <div class="summary-item">
                    <span>Premium Bus Service</span>
                    <span>Rs.15.00</span>
                </div>
                <div class="summary-item">
                    <span>Taxes & Fees</span>
                    <span>Rs.7.50</span>
                </div>
                <div class="summary-item summary-total">
                    <span>Total</span>
                    <span>Rs.62.50</span>
                </div>
                <div class="form-submit" style="margin-top: 20px;">
                    <button class="btn btn-success btn-lg">Confirm Booking</button>
                </div>
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
                        <li><a href="main.html">Home</a></li>
                        <li><a href="about.html">About Us</a></li>
                        <li><a href="booking.html">Book Tickets</a></li>
                        <li><a href="cancellation.html">Cancel Tickets</a></li>
                        <li><a href="gallery.html">Gallery</a></li>
                        <li><a href="contact.html">Contact</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h3>Popular Routes</h3>
                    <ul>
                        <li><a href="booking.html">New York to Boston</a></li>
                        <li><a href="booking.html">Los Angeles to Las Vegas</a></li>
                        <li><a href="booking.html">Chicago to Detroit</a></li>
                        <li><a href="booking.html">Miami to Orlando</a></li>
                        <li><a href="booking.html">Seattle to Portland</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h3>Contact Us</h3>
                    <ul>
                        <li><i class="fas fa-map-marker-alt"></i> Abc street, Kochi, Kerala</li>
                        <li><i class="fas fa-phone"></i> +91 134567891</li>
                        <li><i class="fas fa-envelope"></i> info@ridesync.com</li>
                        <li><i class="fas fa-clock"></i> 24/7 Customer Support</li>
                    </ul>
                </div>
            </div>
            <div class="copyright">
                <p>&copy; 2025 Ridesync. All rights reserved. | Designed with <i class="fas fa-heart"
                        style="color: var(--accent);"></i> for Bus Travelers</p>
            </div>
        </div>
    </footer>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

    <script>
        // Toggle profile dropdown
        document.querySelector('.profile-icon').addEventListener('click', function (e) {
            e.stopPropagation();
            const dropdown = document.querySelector('.profile-dropdown');
            dropdown.classList.toggle('active');
        });

        // Close dropdown when clicking elsewhere
        document.addEventListener('click', function (e) {
            const dropdown = document.querySelector('.profile-dropdown');
            if (dropdown.classList.contains('active') &&
                !e.target.closest('.profile-dropdown') &&
                !e.target.closest('.profile-icon')) {
                dropdown.classList.remove('active');
            }
        });

        // Set minimum date for departure to today
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('departure').min = today;

        // Update return date min based on departure date
        document.getElementById('departure').addEventListener('change', function () {
            document.getElementById('return').min = this.value;
        });
    </script>
</body>

</html>
