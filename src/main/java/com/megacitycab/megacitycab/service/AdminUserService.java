package com.megacitycab.megacitycab.service;

import com.megacitycab.megacitycab.dao.AdminUserDAO;
import com.megacitycab.megacitycab.model.AdminUser;
import com.megacitycab.megacitycab.util.DBUtil;

import java.sql.Connection;
import java.sql.SQLException;

public interface AdminUserService {

    AdminUser authenticateUser(String username, String password);
}
