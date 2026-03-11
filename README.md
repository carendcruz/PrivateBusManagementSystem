# 🚍 RideSync – Premium Bus Booking System

RideSync is a complete online bus booking system developed using **JSP**, **Java (JDBC)**, and **MySQL**. It includes full-stack features for **passengers**, **drivers**, and **admins**, with real-time booking, PDF receipts, and dashboards.

---

## ✨ Key Features

### 👤 User Features
- User registration & login
- Bus search based on departure & destination
- Seat selection and real-time availability
- Payment gateway simulation with PDF receipt
- View & cancel bookings
- Feedback & contact forms

### 🛠 Admin Panel
- Manage users, drivers, buses, and bookings
- View customer feedback
- Add/edit/delete buses and drivers
- Monitor system data


### 📄 Extras
- PDF ticket generation with QR code & logo
- SweetAlert2 popups for user feedback
- Clean responsive UI

---

## ⚙️ Tech Stack

| Layer        | Technology              |
|--------------|--------------------------|
| Frontend     | HTML, CSS, JavaScript, SweetAlert2 |
| Backend      | JSP (JavaServer Pages), Servlet logic |
| Database     | MySQL with JDBC |
| PDF & QR Code| iText PDF library & ZXing |
| Server       | Apache Tomcat (v8+ recommended) |

---

## 🖥 Screenshots

> You can add screenshots in a folder like `/images` and link them below:

- ✅ Booking Page  
  ![Booking](images/booking.png)

- ✅ Admin Dashboard  
  ![Admin](images/admin_dashboard.png)

- ✅ PDF Receipt  
  ![PDF](images/receipt.png)

---

## 🚀 Getting Started

### Prerequisites
- Java JDK 8+
- Apache Tomcat 8/9
- MySQL 5.7+
- IDE like NetBeans or Eclipse

### Setup Instructions
1. Clone or download this project folder.
2. Create a MySQL database named `bus`.
3. Import the provided SQL dump (tables: `users`, `bus_details`, `bookings`, `feedback`, etc.).
4. Update your DB credentials in `dbconfig.jsp`.
5. Deploy the project to your Tomcat server.
6. Visit `http://localhost:8080/RideSync/`.

---

## 👤 Demo Credentials

| Role     | Email                 | Password     |
|----------|-----------------------|--------------|
| Admin    | admin@ridesync.com    | admin123     |
| Driver   | driver@ridesync.com   | driver123    |
| Passenger| Register your account | —            |

---

## 📬 Contact

Built with ❤️ by **Caren J**  
For feedback or queries, email: `admin@ridesync.com`

---

## 📄 License

This is an academic project for learning and demonstration purposes.  
Not intended for commercial deployment.

