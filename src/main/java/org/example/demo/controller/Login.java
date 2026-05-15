package org.example.demo.controller;

import java.io.*;

import org.example.demo.model.User;
import org.example.demo.service.UserService;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;

@WebServlet(urlPatterns = { "/login" })
public class Login extends HttpServlet {
	private UserService userService = new UserService();	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		
		String email = req.getParameter("email");
		String pass = req.getParameter("password");

		User user = userService.getUserByCredentials(email, pass);
		
		if(user != null) {
			HttpSession session = req.getSession();
			session.setAttribute("user", user);
			res.sendRedirect("tasks");
		}else {
			res.sendRedirect("login");
		}
	}
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		req.getRequestDispatcher("index.jsp").forward(req, res);
	}
}