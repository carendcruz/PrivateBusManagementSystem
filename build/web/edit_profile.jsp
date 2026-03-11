<%-- 
    Document   : gallery
    Created on : 17 Jul, 2025, 12:20:43 AM
    Author     : CAREN
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String email = (String) session.getAttribute("user_email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Variables to hold form data
    String firstName = "", lastName = "", phone = "", dob = "", gender = "", address = "", city = "";
    String message = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Get updated values from form
            firstName = request.getParameter("first_name");
            lastName = request.getParameter("last_name");
            phone = request.getParameter("phone");
            dob = request.getParameter("dob");
            gender = request.getParameter("gender");
            address = request.getParameter("address");
            city = request.getParameter("city");

            PreparedStatement updateStmt = conn.prepareStatement(
                "UPDATE users SET first_name=?, last_name=?, phone=?, date_of_birth=?, gender=?, address=?, city=? WHERE email=?"
            );
            updateStmt.setString(1, firstName);
            updateStmt.setString(2, lastName);
            updateStmt.setString(3, phone);
            updateStmt.setString(4, dob);
            updateStmt.setString(5, gender);
            updateStmt.setString(6, address);
            updateStmt.setString(7, city);
            updateStmt.setString(8, email);

            int updated = updateStmt.executeUpdate();
            if (updated > 0) {
                message = "Profile updated successfully!";
                session.setAttribute("user_name", firstName + " " + lastName);
            } else {
                message = "Update failed. Please try again.";
            }
        }

        // Load user data for display
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE email=?");
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            firstName = rs.getString("first_name");
            lastName = rs.getString("last_name");
            phone = rs.getString("phone");
            dob = rs.getString("date_of_birth");
            gender = rs.getString("gender");
            address = rs.getString("address");
            city = rs.getString("city");
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        message = "Error: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ridesync - Gallery</title>
    <link rel="stylesheet" href="style.css">
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
    max-width: 600px;
    margin: 40px auto;
    background: #112240;  /* instead of transparent */
    padding: 30px;
    border-radius: 12px;
    border: 2px solid #ffcc00;
    color: #fff;
    text-align: left;
    box-shadow: 0 8px 20px rgba(0,0,0,0.4);
}

/* Heading */
.form-container h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #ffcc00;
}

/* Form Groups */
.form-group {
    margin-bottom: 15px;
}
.form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: 600;
    color: #ffcc00;
}

/* Input fields */
.form-group input,
.form-group select,
.form-group textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ffcc00;
    border-radius: 6px;
    background: #0a192f;
    color: #fff;
    font-size: 15px;
}
.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
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
    font-weight: bold;
    font-size: 16px;
    border-radius: 6px;
    cursor: pointer;
    width: 100%;
    transition: 0.3s;
}
.form-container .btn:hover {
    background: #ffaa00;
}

/* Back Link */
.back-link {
    display: block;
    text-align: center;
    margin-top: 15px;
    color: #ffcc00;
    text-decoration: none;
    font-weight: 500;
}
.back-link:hover {
    text-decoration: underline;
}

/* Success / Error Message */
.message {
    text-align: center;
    margin-bottom: 15px;
    padding: 10px;
    border-radius: 6px;
    background: #1e293b;
    border: 1px solid #ffcc00;
    color: #ffcc00;
    font-weight: 500;
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
                <i class="fas fa-bus"></i>
                <h1>Ride<span>sync</span></h1>
            </div>
            <nav>
                <ul>
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="about.jsp">About</a></li>
                    <li><a href="booking.jsp">Booking</a></li>
                    <li><a href="cancellation.jsp">Cancellation</a></li>
                    <li><a href="gallery.jsp" class="active">Gallery</a></li>
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
<main>
    <div class="form-container">
    <h2>Edit Profile</h2>

    <% if (!message.isEmpty()) { %>
        <div class="message"><%= message %></div>
    <% } %>

    <form method="post">
        <div class="form-group">
            <label>First Name</label>
            <input type="text" name="first_name" value="<%= firstName %>" required>
        </div>
        <div class="form-group">
            <label>Last Name</label>
            <input type="text" name="last_name" value="<%= lastName %>" required>
        </div>
        <div class="form-group">
            <label>Email (Not Editable)</label>
            <input type="email" value="<%= email %>" readonly>
        </div>
        <div class="form-group">
            <label>Phone</label>
            <input type="text" name="phone" value="<%= phone %>" required>
        </div>
        <div class="form-group">
            <label>Date of Birth</label>
            <input type="date" name="dob" value="<%= dob %>">
        </div>
        <div class="form-group">
            <label>Gender</label>
            <select name="gender">
                <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
                <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female</option>
                <option value="Other" <%= "Other".equals(gender) ? "selected" : "" %>>Other</option>
            </select>
        </div>
        <div class="form-group">
            <label>Address</label>
            <textarea name="address"><%= address %></textarea>
        </div>
        <div class="form-group">
            <label>City</label>
            <input type="text" name="city" value="<%= city %>">
        </div>
        <button type="submit" class="btn">Update Profile</button>
    </form>

    <a href="profile.jsp" class="back-link">← Back to Profile</a>
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
    </script>
</body>
</html>
