# TaskFlow

A full-stack Task Management System built using Java EE technologies following the MVC architectural pattern.

## Features

* User Authentication (Register / Login / Logout)
* Session Management & Protected Routes
* Task CRUD Operations
* Task Status Tracking
* Priority Levels
* Search & Sorting
* User Dashboard & Statistics
* Interactive Charts using Chart.js
* Secure JDBC Database Access
* MVC Layered Architecture

---

## Technologies Used

### Backend

* Java Servlets
* JSP (Java Server Pages)
* JDBC
* MySQL
* MVC Architecture

### Frontend

* HTML5
* CSS3
* JavaScript
* Chart.js

### Tools

* Maven
* Git & GitHub
* Apache Tomcat
* IntelliJ IDEA / VS Code

---

## Project Structure

```text
src/
 ├── controller/
 ├── dao/
 ├── model/
 ├── service/
 ├── utils/
 └── webapp/
```

---

## Screenshots

Add your screenshots here.

Example:

```md
![Login Page](screenshots/login.png)
```

---

## Database Configuration

Update your database credentials inside:

```text
src/main/java/org/example/demo/utils/DBUtil.java
```

Example:

```java
private static final String URL = "jdbc:mysql://localhost:3306/taskflow";
private static final String USER = "YOUR_DB_USER";
private static final String PASS = "YOUR_DB_PASSWORD";
```

---

## How to Run

### 1. Clone Repository

```bash
git clone https://github.com/MostafaNady2/taskflow.git
```

### 2. Open Project

Open the project using IntelliJ IDEA or VS Code.

### 3. Configure Database

* Create MySQL database
* Import SQL tables
* Update database credentials

### 4. Run Tomcat Server

Deploy the project on Apache Tomcat.

### 5. Open in Browser

```text
http://localhost:8080/
```

---

## Architecture

TaskFlow follows the MVC architecture:

* Model → Business Entities
* View → JSP Pages
* Controller → Servlets
* DAO Layer → Database Operations
* Service Layer → Business Logic

---

## Future Improvements

* Spring Boot Migration
* REST API Support
* JWT Authentication
* Docker Deployment
* Role-Based Authorization
* Real-Time Notifications
* Unit & Integration Testing

---

## Author

Moustafa Nady 
* LinkedIn: [https://www.linkedin.com/in/moustafa-nadi-500495379](https://www.linkedin.com/in/moustafa-nadi-500495379)
