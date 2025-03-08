package com.megacitycab.megacitycab.dao;

import com.megacitycab.megacitycab.model.AdminUser;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminUserDAO {

    private final Connection connection;

    public AdminUserDAO(Connection connection) {
        this.connection = connection;
    }

    public AdminUser getAdminUser(String username, String password) throws SQLException {
        String sql = "SELECT * FROM admin_user WHERE username = ? AND password = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, username);
            statement.setString(2, password);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    AdminUser adminUser = new AdminUser();
                    adminUser.setUsername(resultSet.getString("username"));
                    adminUser.setPassword(resultSet.getString("password"));
                    return adminUser;
                } else {
                    return null;
                }
            }
        }
    }
}
