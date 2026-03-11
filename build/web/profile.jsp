<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String userEmail = (String) session.getAttribute("user_email");
    String name = "", phone = "", createdAt = "";

    if (userEmail != null) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

            String sql = "SELECT first_name, last_name, phone, created_at FROM users WHERE email=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userEmail);
            rs = stmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("first_name") + " " + rs.getString("last_name");
                phone = rs.getString("phone");
                createdAt = rs.getString("created_at");
            }

        } catch (Exception e) {
            out.println("Error fetching profile data: " + e.getMessage());
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    } else {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ridesync - Profile</title>
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
        /* Profile Card */
.profile-card {
    background: rgba(255, 255, 255, 0.05); /* semi-transparent dark */
    border: 2px solid #ffcc00;
    border-radius: 12px;
    padding: 30px;
    max-width: 700px;
    margin: 0 auto 60px auto;
    text-align: center;
    box-shadow: 0 8px 20px rgba(0,0,0,0.4);
}

/* Profile Header */
.profile-card .profile-header {
    margin-bottom: 20px;
    align-items: center;
}
.profile-card .profile-avatar {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    background: #ffcc00;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 15px;
    font-size: 40px;
    color: #0a192f;
    box-shadow: 0 4px 12px rgba(0,0,0,0.4);
}
.profile-card h2 {
    margin: 10px 0 5px;
    color: #ffcc00;
    align-items: center;
}
.profile-card p {
    margin: 5px 0;
    color: #fff;
    align-items: center;
}

/* Profile Details */
.profile-details {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-top: 30px;
    text-align: left;
}
.profile-details h4 {
    color: #0a192f;
    margin-bottom: 10px;
}
.profile-details p {
    margin: 6px 0;
    color: #0a192f;
}
.profile-details strong {
    color: #0a192f;
}

/* Buttons */
.profile-card .btn {
    padding: 10px 20px;
    border-radius: 6px;
    font-weight: 600;
    text-decoration: none;
    margin: 0 10px;
    transition: all 0.3s ease;
}
.profile-card .btn-primary {
    background: #ffcc00;
    color: #0a192f;
}
.profile-card .btn-primary:hover {
    background: #ffaa00;
}
.profile-card .btn-outline {
    border: 2px solid #ffcc00;
    color: #ffcc00;
    background: transparent;
}
.profile-card .btn-outline:hover {
    background: #ffcc00;
    color: #0a192f;
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
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </nav>
        <div class="header-right">
    <%-- Show profile dropdown if user is logged in --%>
    <% if (userEmail != null) { %>
        <div class="profile-icon">
            <i class="fas fa-user"></i>
            <div class="profile-dropdown">
                <div class="profile-header">
                    <div class="profile-avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="profile-info">
                        <h3><%= name %></h3>
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
        </div>
    <% } %>

    <%-- Always show login/register buttons --%>
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
            <h2>Your Profile</h2>
            <p>Manage your account and preferences</p>
        </div>
        
        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <h2><%= name %></h2>
                <p><%= userEmail %></p>
            </div>
            
            <div class="profile-details">
                <div class="detail-item">
                    <h4>Personal Information</h4>
                    <p><strong>Name:</strong> <%= name %></p>
                    <p><strong>Email:</strong> <%= userEmail %></p>
                    <p><strong>Phone:</strong> <%= phone %></p>
                    <p><strong>Member Since:</strong> <%= createdAt %></p>
                </div>
                
                <div class="detail-item">
                    <h4>Account Details</h4>
                    <p><strong>Status:</strong> Active</p>
                    <p><strong>Membership:</strong> Basic</p>
                    <p><strong>Last Login:</strong> <%= createdAt %></p>
                </div>

                
            </div>
            
            <div class="form-submit" style="margin-top: 30px;">
                <a href="edit_profile.jsp" class="btn btn-primary">Edit Profile</a>
                <a href="change_password.jsp" class="btn btn-outline">Change Password</a>
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
