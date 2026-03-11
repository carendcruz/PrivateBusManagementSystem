<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Ridesync - Cancel Booking</title>
    <link rel="stylesheet" href="style.css">
    <!-- SweetAlert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        html, body, main, footer {
            background-color: #0a192f;
            margin: 0;
            padding: 0;
            color: #fff;
            font-family: "Segoe UI", sans-serif;
        }

        header {
            background-color: #0a192f;
            padding: 15px 30px;
            border-bottom: 2px solid #ffcc00;
        }

        header .logo h1 {
            color: #fff;
        }
        header .logo h1 span { color: #ffcc00; }
        header nav ul li a { color: #fff; }
        header nav ul li a.active,
        header nav ul li a:hover { color: #ffcc00; }

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
        .auth-buttons .btn-gold:hover { background: #ffaa00; }

        main.page { padding: 60px 20px; }
        .section-title { text-align: center; margin-bottom: 60px; }
        .section-title h2 { color: #ffcc00; font-size: 32px; }
        .section-title p { color: #ffcc00; }

        .cancel-form-container {
            max-width: 500px;
    margin: 0 auto;
    background: #112240;   /* dark blue card background */
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.25);
    color: #fff; 
     border: 2px solid #ffffff; /* white border */
        }

        .cancel-form-container h2 {
            text-align: center;
            color: #ffcc00;
            margin-bottom: 25px;
        }

        .cancel-form-container .form-group { margin-bottom: 20px; }
        .cancel-form-container label { color: #ffcc00; font-weight: bold; }
        .cancel-form-container input {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            font-size: 15px;
            background-color: #1e293b;
            color: #fff;
            border: 1px solid #334155;
            transition: all 0.2s ease;
        }
        .cancel-form-container input:focus {
            background-color: #0f172a;
            border: 1px solid #facc15;
            outline: none;
        }

        .cancel-form-container .btn {
            width: 100%;
            padding: 12px;
            background-color: #ffcc00;
            color: #0a192f;
            font-weight: bold;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }
        .cancel-form-container .btn:hover { background-color: #ffaa00; }

        footer {
            background-color: #0a192f;
            color: #fff;
            padding: 40px 0;
        }
        footer h3 { color: #ffcc00; }
        footer a { color: #ffcc00; text-decoration: none; }
        footer a:hover { text-decoration: underline; }
        .footer-column { margin-bottom: 20px; }
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
                    <li><a href="cancellation.jsp" class="active">Cancellation</a></li>
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
                            <li><a href="user_bookings.jsp"><i class="fas fa-ticket-alt"></i> My Bookings</a></li>
                            <li><a href="feedback.jsp"><i class="fas fa-edit"></i> Feedback </a></li>
                            <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                        </ul>
                    </div>
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
                <h2>Cancel Your Booking</h2>
                <p>Enter your booking details to cancel</p>
            </div>

            <div class="cancel-form-container">
                <%
                    String script = "";
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        String bookingIdStr = request.getParameter("booking_id");
                        String email = request.getParameter("email");

                        try {
                            int bookingId = Integer.parseInt(bookingIdStr);

                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");

                            String fetchSQL = "SELECT total_amount FROM bookings WHERE id=? AND user_email=?";
                            PreparedStatement psFetch = conn.prepareStatement(fetchSQL);
                            psFetch.setInt(1, bookingId);
                            psFetch.setString(2, email);
                            ResultSet rs = psFetch.executeQuery();

                            if (rs.next()) {
                                double totalAmount = rs.getDouble("total_amount");
                                double ticketAmount = Math.round((totalAmount / 1.10) * 100.0) / 100.0;

                                String insertRefund = "INSERT INTO refunds (booking_id, user_email, refund_amount) VALUES (?, ?, ?)";
                                PreparedStatement psRefund = conn.prepareStatement(insertRefund);
                                psRefund.setInt(1, bookingId);
                                psRefund.setString(2, email);
                                psRefund.setDouble(3, ticketAmount);
                                psRefund.executeUpdate();

                                String sql = "DELETE FROM bookings WHERE id = ? AND user_email = ?";
                                PreparedStatement stmt = conn.prepareStatement(sql);
                                stmt.setInt(1, bookingId);
                                stmt.setString(2, email);
                                int rows = stmt.executeUpdate();

                                if (rows > 0) {
                                    script = "<script>Swal.fire({icon:'success',title:'Booking Cancelled',text:'₹" + ticketAmount + " refunded (ticket only).',confirmButtonColor:'#005ce6'}).then(()=>{window.location='home.jsp';});</script>";
                                } else {
                                    script = "<script>Swal.fire({icon:'warning',title:'Not Found',text:'No matching booking found.',confirmButtonColor:'#005ce6'});</script>";
                                }

                            } else {
                                script = "<script>Swal.fire({icon:'warning',title:'Not Found',text:'No matching booking found.',confirmButtonColor:'#005ce6'});</script>";
                            }

                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                            script = "<script>Swal.fire({icon:'error',title:'Error',text:'Something went wrong.',confirmButtonColor:'#005ce6'});</script>";
                        }
                    }
                %>

                <form method="post">
                    <div class="form-group">
                        <label for="booking_id">Booking ID</label>
                        <input type="text" id="booking_id" name="booking_id" placeholder="Enter Booking ID" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email used for booking</label>
                        <input type="email" id="email" name="email" placeholder="Enter your email" required>
                    </div>

                    <button type="submit" class="btn">Cancel Booking</button>
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
        document.querySelector('.profile-icon').addEventListener('click', function(e) {
            e.stopPropagation();
            const dropdown = document.querySelector('.profile-dropdown');
            dropdown.classList.toggle('active');
        });
        document.addEventListener('click', function(e) {
            const dropdown = document.querySelector('.profile-dropdown');
            if (dropdown.classList.contains('active') && 
                !e.target.closest('.profile-dropdown') && 
                !e.target.closest('.profile-icon')) {
                dropdown.classList.remove('active');
            }
        });
    </script>

    <% if (!script.isEmpty()) { %>
        <%= script %>
    <% } %>
</body>
</html>
