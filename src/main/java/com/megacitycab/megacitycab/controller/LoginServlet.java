package com.megacitycab.megacitycab.controller;

import com.megacitycab.megacitycab.model.AdminUser;
import com.megacitycab.megacitycab.service.AdminUserService;
import com.megacitycab.megacitycab.service.impl.AdminUserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AdminUserService adminUserService = new AdminUserServiceImpl();

    public LoginServlet() throws SQLException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminUser adminUser = adminUserService.authenticateUser(username, password);

        if (adminUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("adminUser", adminUser);
            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}