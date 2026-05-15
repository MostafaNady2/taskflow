package org.example.demo.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/logout")
public class Logout extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
		// redirect to the login page : Get request
        res.sendRedirect("login");
    }
}