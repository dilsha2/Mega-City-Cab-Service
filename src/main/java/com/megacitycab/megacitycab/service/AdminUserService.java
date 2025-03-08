package com.megacitycab.megacitycab.service;

import com.megacitycab.megacitycab.dao.AdminUserDAO;
import com.megacitycab.megacitycab.model.AdminUser;
import com.megacitycab.megacitycab.util.DBUtil;

import java.sql.Connection;
import java.sql.SQLException;

public class AdminUserService {

    private final AdminUserDAO adminUserDAO;

    public AdminUserService() {
        try {
            Connection connection = DBUtil.getConnection();
            this.adminUserDAO = new AdminUserDAO(connection);
        } catch (SQLException e) {
            throw new RuntimeException("Database connection error", e);
        }
    }

    public AdminUser authenticateUser(String username, String password) {
        try {
            return adminUserDAO.getAdminUser(username, password);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
