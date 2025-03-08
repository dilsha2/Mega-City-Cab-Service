package com.megacitycab.megacitycab.repo.impl;

import com.megacitycab.megacitycab.model.AdminUser;
import com.megacitycab.megacitycab.repo.AdminUserRepository;
import com.megacitycab.megacitycab.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminUserRepositoryImpl implements AdminUserRepository {

    private final Connection connection;

    public AdminUserRepositoryImpl() throws SQLException {
        this.connection = DBUtil.getConnection();
    }

    @Override
    public AdminUser findByUsernameAndPassword(String username, String password) throws SQLException {
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
                }
            }
        }
        return null;
    }
}
