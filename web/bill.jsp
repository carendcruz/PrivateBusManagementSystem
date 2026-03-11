<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String busId = request.getParameter("bus_id");
    String busName = request.getParameter("bus_name");
    String priceStr = request.getParameter("price");
    String date = request.getParameter("date");
    String passengersStr = request.getParameter("passengers");

    int price = priceStr != null ? (int) Double.parseDouble(priceStr) : 0;
    int passengers = passengersStr != null ? Integer.parseInt(passengersStr) : 1;
%>
<!DOCTYPE html>
<html>
<head>
    <title>RideSync - Bill</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #0a192f; /* dark page background */
            color: #f1f5f9; /* light text */
            margin: 0;
            padding: 0;
        }
        .bill-container {
            max-width: 500px;
            margin: 40px auto;
            background: #112240; /* dark card background */
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.4);
        }
        .bill-container h2 {
            color: #ffcc00; /* gold heading */
            margin-bottom: 20px;
            border-bottom: 1px solid #334155;
            padding-bottom: 10px;
            text-align: center;
        }
        .bill-row {
            margin: 12px 0;
            font-size: 16px;
        }
        .bill-row span {
            display: inline-block;
            width: 50%;
        }
        .bill-row strong {
            color: #ffcc00; /* gold highlight for total */
        }
        select {
            background-color: #1e293b; /* dark dropdown */
            color: #f1f5f9;
            border: 1px solid #ffcc00;
            padding: 6px;
            border-radius: 6px;
            font-size: 15px;
        }
        select:focus {
            background-color: #0f172a;
            outline: none;
            border: 1px solid #facc15;
        }
        .btn-pay {
            margin-top: 25px;
            background: #ffcc00;
            color: #0a192f;
            padding: 12px 20px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            transition: background 0.3s;
        }
        .btn-pay:hover {
            background: #ffaa00;
        }
    </style>
</head>
<body>
<div class="bill-container">
    <h2>Bill Summary</h2>
    <div class="bill-row"><span>Bus:</span> <span><%= busName %></span></div>
    <div class="bill-row"><span>Date:</span> <span><%= date %></span></div>

    <div class="bill-row">
        <span>Passengers:</span>
        <span>
            <select id="passengers" name="passengers" onchange="calculateBill()">
                <% for (int i = 1; i <= 5; i++) { %>
                    <option value="<%= i %>" <%= (i == passengers) ? "selected" : "" %>><%= i %></option>
                <% } %>
            </select>
        </span>
    </div>

    <div class="bill-row"><span>Price per Ticket:</span> <span>₹<span id="price"><%= price %></span></span></div>
    <div class="bill-row"><span>Subtotal:</span> <span>₹<span id="subtotal">0</span></span></div>
    <div class="bill-row"><span>Tax (18% GST):</span> <span>₹<span id="tax">0</span></span></div>
    <div class="bill-row"><strong>Total:</strong> <strong>₹<span id="total">0</span></strong></div>

    <form action="payment.jsp" method="get">
        <input type="hidden" name="bus_id" value="<%= busId %>">
        <input type="hidden" name="bus_name" value="<%= busName %>">
        <input type="hidden" name="price" id="form_price" value="<%= price %>">
        <input type="hidden" name="date" value="<%= date %>">
        <input type="hidden" id="form_passengers" name="passengers" value="<%= passengers %>">
        <input type="hidden" id="form_tax" name="tax" value="">
        <input type="hidden" id="form_total" name="total" value="">
        <input type="hidden" name="departure" value="<%= request.getParameter("departure") %>">
        <input type="hidden" name="destination" value="<%= request.getParameter("destination") %>">

        <button class="btn-pay" type="submit" id="submitBtn">Proceed to Payment</button>
    </form>
</div>

<script>
    function calculateBill() {
        const passengers = parseInt(document.getElementById("passengers").value);
        const price = parseInt(document.getElementById("price").innerText);

        const subtotal = passengers * price;
        const tax = subtotal * 0.18;
        const total = subtotal + tax;

        // Update visible summary values
        document.getElementById("subtotal").innerText = subtotal.toFixed(2);
        document.getElementById("tax").innerText = tax.toFixed(2);
        document.getElementById("total").innerText = total.toFixed(2);

        // Update hidden fields before form submit
        document.getElementById("form_passengers").value = passengers;
        document.getElementById("form_tax").value = tax.toFixed(2);
        document.getElementById("form_total").value = total.toFixed(2);
    }

    // Initial calculation on page load
    window.onload = calculateBill;
</script>
</body>
</html>
