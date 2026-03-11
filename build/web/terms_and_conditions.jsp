<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Terms & Conditions - Ridesync</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #0d1b2a;
            margin: 0;
            padding: 0;
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
        /* Navbar */
        header {
            background-color: #0d1b2a;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            margin: 0;
            font-size: 28px;
            color: #ffa200;
        }

        /* Container Card */
        .container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 40px;
            background-color: #1e293b;
            border-radius: 15px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
        }

        h2 {
            color: #ffa200;
            margin-bottom: 25px;
            font-size: 24px;
        }

        p {
            line-height: 1.8;
            margin-bottom: 18px;
            color: #fff;
        }

        ul {
            padding-left: 20px;
            margin-bottom: 25px;
            color: #fff;
        }

        li {
            margin-bottom: 12px;
        }

        /* Buttons */
        .btn-back {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 24px;
            background-color: #ffb703;
            color: #0d1b2a;
            text-decoration: none;
            font-weight: bold;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            background-color: #ffa200;
            color: #fff;
        }

        /* Footer */
        footer {
            background-color: #0d1b2a;
            color: #aaa;
            text-align: center;
            padding: 1rem;
            font-size: 14px;
            margin-top: 50px;
        }
    </style>
</head>
<body>

<!-- Header/Navbar -->
<header>
    <h1>Ridesync</h1>
</header>

<!-- Main Content -->
<div class="container">
    <h2>Terms & Conditions</h2>

    <p>By using the Ridesync platform, you agree to the following updated terms and conditions. Please read them carefully before registering or booking tickets.</p>

    <ul>
        <li><strong>Booking Policy:</strong> All bookings made through Ridesync are final once payment is completed. Please verify your journey details before confirming.</li>
        
        <li><strong>Cancellation & Refund Policy:</strong> 
            <ul>
                <li>Tickets can be cancelled online using the cancellation page before the journey date.</li>
                <li>Refunds are processed for the <strong>ticket price only</strong>. Taxes and service charges are non-refundable.</li>
                <li>Refunds will be credited to your original payment method within 3–7 working days.</li>
                <li>Bookings cannot be cancelled after the bus departure.</li>
            </ul>
        </li>

        <li><strong>User Responsibilities:</strong> 
            <ul>
                <li>You must provide accurate personal and contact details while registering and booking.</li>
                <li>Carrying a valid ID while traveling is mandatory.</li>
                <li>Users are responsible for being present at the boarding point on time.</li>
            </ul>
        </li>

        <li><strong>Service Changes:</strong> Ridesync reserves the right to modify bus timings, routes, or cancel services in case of unforeseen circumstances such as weather, strikes, or technical issues. Affected users will be notified and assisted with rebooking or refunds where applicable.</li>

        <li><strong>Prohibited Conduct:</strong> Any abusive behavior, fraudulent bookings, or misuse of the platform may result in account suspension without refund.</li>

        <li><strong>Privacy:</strong> Your personal information is protected and will only be used as per our Privacy Policy.</li>

        <li><strong>Jurisdiction:</strong> All disputes arising from bookings or cancellations shall be subject to the jurisdiction of the courts in Kerala, India.</li>
    </ul>

    <p>By continuing to use Ridesync, you acknowledge that you have read and agreed to these terms.</p>

    <a href="register.jsp" class="btn-back">⬅ Back to Register</a>
</div>

<!-- Footer -->
<footer>
    &copy; 2025 Ridesync. All rights reserved.
</footer>

</body>
</html>
