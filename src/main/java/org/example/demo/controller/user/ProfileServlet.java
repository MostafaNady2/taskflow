package org.example.demo.controller.user;


import java.io.IOException;
import java.util.List;

import org.example.demo.model.User;
import org.example.demo.service.UserService;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(urlPatterns = "/profile")
public class ProfileServlet extends HttpServlet {

	UserService userService = new UserService();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		User user = (User) req.getSession(false).getAttribute("user");

        List<Integer> userStatics = userService.getUserStatics(user.getId());

		int totalTasks = userStatics.get(0);
		int completed = userStatics.get(1);
		int inProgress = userStatics.get(2);
		int todo = userStatics.get(3);
		int highPriority = userStatics.get(4);

		req.setAttribute("totalTasks", totalTasks);
		req.setAttribute("completed", completed);
		req.setAttribute("inProgress", inProgress);
		req.setAttribute("todo", todo);
		req.setAttribute("highPriority", highPriority);
		
		req.getRequestDispatcher("/views/user/profile.jsp").forward(req, res);
		
	}
}
