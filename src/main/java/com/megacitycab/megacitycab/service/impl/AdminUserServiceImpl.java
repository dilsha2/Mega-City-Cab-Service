package com.megacitycab.megacitycab.service.impl;

import com.megacitycab.megacitycab.model.AdminUser;
import com.megacitycab.megacitycab.repo.AdminUserRepository;
import com.megacitycab.megacitycab.repo.impl.AdminUserRepositoryImpl;
import com.megacitycab.megacitycab.service.AdminUserService;

import java.sql.SQLException;

public class AdminUserServiceImpl implements AdminUserService {

    private final AdminUserRepository adminUserRepository;

    public AdminUserServiceImpl() throws SQLException {
        this.adminUserRepository = new AdminUserRepositoryImpl();
    }

    @Override
    public AdminUser authenticateUser(String username, String password) {
        try {
            return adminUserRepository.findByUsernameAndPassword(username, password);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
