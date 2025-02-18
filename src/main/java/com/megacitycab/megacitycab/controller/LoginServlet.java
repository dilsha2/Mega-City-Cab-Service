package com.megacitycab.megacitycab.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final String VALID_USERNAME = "admin";
    private static final String VALID_PASSWORD = "admin123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println(username);
        System.out.println(password);
        // Validate credentials (dummy check for demonstration)
        if (VALID_USERNAME.equals(username) && VALID_PASSWORD.equals(password)) {
            // Redirect to the dashboard or home page
            System.out.println("dashboard");
            response.sendRedirect("dashboard.jsp");
        } else {
            System.out.println("error");
            // Redirect back to the login page with an error message
            response.sendRedirect("login.jsp?error=1");
        }
    }
}