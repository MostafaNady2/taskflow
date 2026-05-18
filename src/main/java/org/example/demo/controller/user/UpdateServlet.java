package org.example.demo.controller.user;

import java.io.IOException;

import org.example.demo.model.User;
import org.example.demo.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/user/update")
public class UpdateServlet extends HttpServlet {

	private UserService userService = new UserService();
	
	public void doPost( HttpServletRequest req, HttpServletResponse res ) throws IOException, ServletException {
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String confirmPassword = req.getParameter("confirmPassword");

		if (name == null || name.trim().isEmpty()
				|| email == null || email.trim().isEmpty()
				|| password == null || password.trim().isEmpty()) {
			req.setAttribute("errorMessage", "Name and email are required" );
			req.getRequestDispatcher("/views/user/update.jsp").forward(req, res);
			return;
		}

		if (!password.equals(confirmPassword)) {
			req.setAttribute("errorMessage", "Password and confirm password do not match" );
			req.getRequestDispatcher("/views/user/update.jsp").forward(req, res);
			return;
		}

		User user = (User) req.getSession(false).getAttribute("user");
		user.setName(name);
		user.setEmail(email);
		user.setPassword(password);
		userService.updateUser(user);

		req.getSession().setAttribute("user", user);

		res.sendRedirect(req.getContextPath() + "/profile");
	}

	public void doGet( HttpServletRequest req, HttpServletResponse res ) throws IOException, ServletException {
		req.getRequestDispatcher("/views/user/update.jsp").forward(req, res);
	}
}
