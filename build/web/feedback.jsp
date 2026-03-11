<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback - RideSync</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    background-color: #0a192f; /* dark background */
}

main {
    min-height: 100vh; /* full viewport height */
    background-color: #0a192f; /* dark background */
    display: flex;
    align-items: center;  /* vertically center the form */
    justify-content: center; /* horizontally center */
}


        .feedback-container {
            max-width: 600px;
            margin: 60px auto;
            padding: 30px;
            background: #112240; /* dark card background */
            border: 2px solid #ffcc00; /* gold border */
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.5);
        }

        h2 {
            text-align: center;
            color: #ffcc00;
            margin-bottom: 25px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 6px;
            color: #ffcc00;
        }

        input, textarea, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 18px;
            border: 1px solid #ffcc00;
            border-radius: 5px;
            background-color: #0a192f;
            color: #fff;
            outline: none;
        }

        input::placeholder,
        textarea::placeholder {
            color: #ccc;
        }

        input:focus,
        textarea:focus,
        select:focus {
            border-color: #ffaa00;
        }

        button {
            width: 100%;
            background-color: #ffcc00;
            color: #0a192f;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background-color: #ffaa00;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #ffcc00;
            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <main>
<div class="feedback-container">
    <h2>We value your feedback!</h2>
    <form method="post" action="feedback.jsp">
        <label>Name:</label>
        <input type="text" name="name" placeholder="Enter your name" required>

        <label>Email:</label>
        <input type="email" name="email" placeholder="Enter your email" required>

        <label>Rating:</label>
        <select name="rating" required>
            <option value="">--Select--</option>
            <option value="5">Excellent ⭐⭐⭐⭐⭐</option>
            <option value="4">Very Good ⭐⭐⭐⭐</option>
            <option value="3">Good ⭐⭐⭐</option>
            <option value="2">Fair ⭐⭐</option>
            <option value="1">Poor ⭐</option>
        </select>

        <label>Comments:</label>
        <textarea name="comments" rows="5" placeholder="Write your comments here..." required></textarea>

        <button type="submit">Submit Feedback</button>
    </form>

    <a href="profile.jsp" class="back-link">← Back to Profile</a>

    <%-- SweetAlert --%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String rating = request.getParameter("rating");
            String comments = request.getParameter("comments");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus", "root", "windows");
                PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO feedback (name, email, rating, comments) VALUES (?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setInt(3, Integer.parseInt(rating));
                ps.setString(4, comments);
                int rows = ps.executeUpdate();
                if (rows > 0) {
    %>
        <script>
            Swal.fire({
                icon: 'success',
                title: 'Thank you!',
                text: 'Your feedback has been submitted successfully.',
                confirmButtonColor: '#ffcc00'
            });
        </script>
    <%
                }
                conn.close();
            } catch (Exception e) {
    %>
        <script>
            Swal.fire({
                icon: 'error',
                title: 'Oops!',
                text: 'Something went wrong. Please try again.',
                confirmButtonColor: '#d33'
            });
        </script>
    <%
            }
        }
    %>
</div>
    </main>
</body>
</html>
