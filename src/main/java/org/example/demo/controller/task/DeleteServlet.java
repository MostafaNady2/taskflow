package org.example.demo.controller.task;

import java.io.IOException;

import org.example.demo.service.TaskService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
@WebServlet("/tasks/delete")
public class DeleteServlet extends HttpServlet{
	TaskService taskService = new TaskService();
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		int id = Integer.parseInt(req.getParameter("id"));
		taskService.deleteTask(id);
		res.sendRedirect(req.getContextPath() + "/tasks");
	}
}
