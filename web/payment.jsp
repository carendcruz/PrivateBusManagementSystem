<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String busId = request.getParameter("bus_id");
    String busName = request.getParameter("bus_name");
    String date = request.getParameter("date");
    String passengers = request.getParameter("passengers");
    String price = request.getParameter("price");

    double total = 0.0;
    double tax = 0.0;

    try {
        total = Double.parseDouble(request.getParameter("total"));
        tax = Double.parseDouble(request.getParameter("tax"));
    } catch (Exception e) {
        total = 0.0;
        tax = 0.0;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment - RideSync</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #0d1b2a; /* dark navy */
            color: #fff;
        }

        .payment-container {
            max-width: 550px;
            margin: 60px auto;
            background: #1b263b;
            padding: 35px;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.5);
        }

        .payment-container h2 {
            margin-bottom: 8px;
            color: #ffcc00;
            text-align: center;
        }

        .payment-container p {
            font-size: 14px;
            color: #ddd;
            margin-bottom: 20px;
            text-align: center;
        }

        .card-box {
            border: 2px solid #33415c;
            border-radius: 12px;
            padding: 20px;
            background: #24344d;
        }

        .card-label {
            font-weight: bold;
            margin-top: 12px;
            display: block;
            color: #ffcc00;
        }

        .card-input {
            width: 100%;
            padding: 12px;
            margin-top: 6px;
            border: 1px solid #3a506b;
            border-radius: 10px;
            font-size: 18px;
            background: #0d1b2a;
            color: #fff;
        }

        .card-input:focus {
            border-color: #ffcc00;
            outline: none;
            background: #1b263b;
        }

        .card-row {
            display: flex;
            gap: 15px;
            justify-content: space-between;
        }

        .card-row > div {
    flex: 1;   /* make both expiry and cvv equal width */
}

.card-row .card-input {
    width: 100%;  /* input takes full width of its div */
}

        .card-icons {
            margin-top: 15px;
            text-align: right;
        }

        .card-icons img {
            height: 32px;
            margin-left: 8px;
            filter: drop-shadow(0 0 2px #000);
        }

        .btn-pay {
            width: 100%;
            padding: 15px;
            margin-top: 25px;
            font-size: 16px;
            font-weight: bold;
            background-color: #ffcc00;
            color: #0d1b2a;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-pay:hover {
            background-color: #e6b800;
        }

        .summary {
            background: #141e30;
            padding: 15px;
            border-radius: 12px;
            margin-top: 25px;
        }

        .summary p {
            margin: 6px 0;
            color: #eee;
        }

        .summary strong {
            color: #ffcc00;
        }
    </style>
</head>
<body>

<div class="payment-container">
    <h2>Payment Method</h2>
    <p>You may be redirected to your bank's secure 3D process for authentication.</p>

    <form action="payment_success.jsp" method="post">
        <input type="hidden" name="bus_id" value="<%= busId %>">
        <input type="hidden" name="date" value="<%= date %>">
        <input type="hidden" name="passengers" value="<%= passengers %>">
        <input type="hidden" name="departure" value="<%= request.getParameter("departure") %>">
        <input type="hidden" name="destination" value="<%= request.getParameter("destination") %>">

        <input type="hidden" name="price" value="<%= price %>">
        <input type="hidden" name="tax" value="<%= tax %>">
        <input type="hidden" name="total" value="<%= total %>">

        <div class="card-box">
            <label class="card-label">Card Number</label>
            <input type="text" name="card_number" class="card-input" placeholder="1234 5678 9012 3456" maxlength="16" required>

            <div class="card-row">
                <div>
                    <label class="card-label">Expiry Date</label>
                    <input type="month" name="expiry_date" class="card-input" required>
                </div>
                <br/>
                <div>
                    <label class="card-label">CVV</label>
                    <input type="text" name="cvv" class="card-input" maxlength="3" required>
                </div>
            </div>

            <label class="card-label">Name on Card</label>
            <input type="text" name="card_name" class="card-input" placeholder="John Doe" required>

            <div class="card-icons">
                <img src="images/visa.png" alt="Visa">
                <img src="images/mastercard-logo.png" alt="MasterCard">
                <img src="images/amex.png" alt="Amex">
            </div>
        </div>

        <div class="summary">
            <p><strong>Bus:</strong> <%= busName %></p>
            <p><strong>Date:</strong> <%= date %></p>
            <p><strong>Passengers:</strong> <%= passengers %></p>
            <p><strong>Tax:</strong> ₹<%= String.format("%.2f", tax) %></p>
            <p><strong>Total:</strong> ₹<%= String.format("%.2f", total) %></p>
        </div>

        <button class="btn-pay" type="submit">Pay ₹<%= String.format("%.2f", total) %> Now</button>
    </form>
</div>

</body>
</html>
