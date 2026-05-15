package org.example.demo.controller.task;

import java.io.*;
import java.sql.SQLException;
import java.util.List;

import org.example.demo.model.Priority;
import org.example.demo.model.Status;
import org.example.demo.model.Task;
import org.example.demo.model.User;
import org.example.demo.service.TaskService;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;

@WebServlet(urlPatterns = { "/tasks" })
public class TaskServlet extends HttpServlet {
	private TaskService taskService = new TaskService();

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			res.sendRedirect("login");
			return;
		}

		User user = (User) session.getAttribute("user");
		String search = req.getParameter("search");
		String sortBy = req.getParameter("sortBy");

		if (search == null || search.trim().isEmpty()) {
			search = null;
		}

		List<Task> tasks= null;
		try {
			tasks = taskService.getUserTasksWithFilter(user.getId(), search, sortBy);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		req.setAttribute("tasks", tasks);
		req.getRequestDispatcher("/views/task/tasks.jsp").forward(req, res);

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		Task task = new Task();
		task.setTitle(req.getParameter("title"));
		task.setDescription(req.getParameter("description"));
		task.setStatus(Status.valueOf(req.getParameter("status"))); // convert string to enum
		task.setPriority(Priority.valueOf(req.getParameter("priority")));
		task.setUserId(((User) req.getSession().getAttribute("user")).getId());
		taskService.createTask(task);
		res.sendRedirect("tasks");
	}
}
