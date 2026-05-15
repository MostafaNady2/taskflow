package org.example.demo.controller;

import java.io.IOException;

import org.example.demo.model.User;
import org.example.demo.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/register")
public class Register extends HttpServlet {
	UserService userService = new UserService();

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		User user = new User();
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String confirmPassword = req.getParameter("confirmPassword");

		if (name == null || name.trim().isEmpty()
				|| email == null || email.trim().isEmpty()
				|| password == null || password.trim().isEmpty()) {
			res.sendRedirect("register");
			return;
		}

		if (!password.equals(confirmPassword)) {
			res.sendRedirect("register");
		}

		if (userService.getUserByEmail(email) != null) {
			res.sendRedirect("register");
			return;
		}

		user.setName(name);
		user.setEmail(email);
		user.setPassword(password);
		user.setId(userService.createUser(user));

		HttpSession session = req.getSession();
		session.setAttribute("user", user);
		res.sendRedirect("tasks");

	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.getRequestDispatcher("/register.jsp").forward(req, res);
	}
}
