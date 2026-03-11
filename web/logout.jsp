<%-- 
    Document   : logout
    Created on : 18 Jul, 2025, 9:29:13 PM
    Author     : CAREN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Invalidate the session
    session.invalidate();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logging Out...</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Logged Out',
        text: 'You have successfully logged out!',
        showConfirmButton: false,
        timer: 2000
    }).then(() => {
        window.location.href = 'home.jsp';
    });
</script>
</body>
</html>


