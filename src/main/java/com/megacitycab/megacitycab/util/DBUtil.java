package com.megacitycab.megacitycab.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    private static final String URL = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";  // Update if your MySQL username is different
    private static final String PASSWORD = "1234"; // Update if your MySQL password is different

    public static Connection getConnection() throws SQLException {
        try {
            // Explicitly load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found! Add it to classpath.", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
