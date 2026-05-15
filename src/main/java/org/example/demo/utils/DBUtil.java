package org.example.demo.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    private static final String URL  = "jdbc:mysql://localhost:3306/jdbc_tutorial?useSSL=false&serverTimezone=UTC";
    private static final String USER = "YOUR_DB_USER";
    private static final String PASS = "YOUR_DB_PASSWORD";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(URL, USER, PASS);
    }
}