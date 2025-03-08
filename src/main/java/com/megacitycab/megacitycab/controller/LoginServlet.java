package com.megacitycab.megacitycab.controller;

import com.megacitycab.megacitycab.model.AdminUser;
import com.megacitycab.megacitycab.service.AdminUserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AdminUserService adminUserService = new AdminUserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("Username: " + username);
        System.out.println("Password: " + password);

        // Authenticate the user
        AdminUser adminUser = adminUserService.authenticateUser(username, password);

        if (adminUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("adminUser", adminUser);
            System.out.println("User authenticated. Redirecting to dashboard...");
            response.sendRedirect("dashboard.jsp");
        } else {
            // Authentication failed, redirect to login page with error
            System.out.println("Invalid credentials. Redirecting to login page.");
            response.sendRedirect("login.jsp?error=1");
        }
    }
}