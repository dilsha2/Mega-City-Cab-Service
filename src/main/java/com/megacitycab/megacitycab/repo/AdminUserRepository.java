package com.megacitycab.megacitycab.repo;

import com.megacitycab.megacitycab.model.AdminUser;
import java.sql.SQLException;

public interface AdminUserRepository {
    AdminUser findByUsernameAndPassword(String username, String password) throws SQLException;
}
