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

// AddServlet.java
@WebServlet(urlPatterns = "/tasks/add")
public class AddServlet extends HttpServlet {
    private TaskService taskService = new TaskService();

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        Task task = new Task();
        task.setTitle(req.getParameter("title"));
        task.setDescription(req.getParameter("description"));
        task.setStatus(Status.valueOf(req.getParameter("status")));
		task.setPriority(Priority.valueOf(req.getParameter("priority")));
        task.setUserId(((User) req.getSession(false).getAttribute("user")).getId());
        try {
            taskService.createTask(task);
        } catch (Exception e) {
            e.printStackTrace();
        }
        res.sendRedirect(req.getContextPath() + "/tasks");  
    }
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		req.getRequestDispatcher("/views/task/add.jsp").forward(req, res);
	}
}
