package org.example.demo.controller.task;

import java.io.IOException;

import org.example.demo.model.Priority;
import org.example.demo.model.Status;
import org.example.demo.model.Task;
import org.example.demo.model.User;
import org.example.demo.service.TaskService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/tasks/update")
public class UpdateServlet extends HttpServlet {
	private TaskService taskService = new TaskService();
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		Task updated = new Task();
		updated.setId(Integer.parseInt(req.getParameter("id")));
		updated.setTitle(req.getParameter("title"));
		updated.setDescription(req.getParameter("description"));
		updated.setStatus(Status.valueOf(req.getParameter("status"))); // convert string to enum
		updated.setPriority(Priority.valueOf(req.getParameter("priority")));
		updated.setUserId(((User) req.getSession(false).getAttribute("user")).getId());
		taskService.updateTask(updated);
		res.sendRedirect(req.getContextPath() + "/tasks");
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		int id = Integer.parseInt(req.getParameter("id"));
		Task task = taskService.getTaskById(id).get();
		req.setAttribute("task", task);
		req.getRequestDispatcher("/views/task/update.jsp").forward(req, res);
	}

}
