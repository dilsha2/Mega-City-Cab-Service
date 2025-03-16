package com.megacitycab.megacitycab.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    private static final String URL = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "1234";

    private static Connection connection;

    private DBUtil() {
    }

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            synchronized (DBUtil.class) { // Thread safety
                if (connection == null || connection.isClosed()) {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connection = DriverManager.getConnection(URL, USER, PASSWORD);
                    } catch (ClassNotFoundException e) {
                        throw new SQLException("MySQL JDBC Driver not found! Add it to classpath.", e);
                    }
                }
            }
        }
        return connection;
    }
}

