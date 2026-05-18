package org.example.demo.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

import org.example.demo.dao.TaskDao;
import org.example.demo.model.Task;

public class TaskService {
	private TaskDao taskDao = new TaskDao();

	public List<Task> getUserTasks(int userId) {
		return taskDao.getUserTasks(userId);
	}

	public Optional<Task> getTaskById(int taskId) {
		Optional<Task> TaskById = taskDao.getTaskById(taskId);
		TaskById.orElseThrow(() -> new RuntimeException("Task not found"));
		return TaskById;
	}

	public void createTask(Task task) {
		taskDao.createTask(task);
	}

	public void deleteTask(int taskId) {
		taskDao.deleteTask(taskId);
	}

	public void updateTask(Task task) {
		taskDao.updateTask(task);
	}

	public List<Task> getUserTasksWithFilter(int userId, String searchBy, String sortBy, String sortOrder) throws SQLException {
		if (searchBy != null) {
			searchBy = searchBy.trim();
			if (searchBy.isEmpty() || searchBy.isBlank()) {
				searchBy = null;
			}
		}

		if (sortBy != null) {
			sortBy = sortBy.trim();
			if (sortBy.isEmpty() || sortBy.isBlank()) {
				sortBy = null;
			}
		}

		try {
			// case 1: Only Search (no sort)
			if (searchBy != null && sortBy == null) {
				return searchTasks(userId, searchBy);
			}

			// case 2: Only Sort (no search)
			if (searchBy == null && sortBy != null) {
				return sortBy(userId, sortBy, sortOrder);
			}

			// Case 3: Both Search + Sort
			if (searchBy != null && sortBy != null) {
				return searchAndSort(userId, searchBy, sortBy, sortOrder);
			}

			// Case 4: Default - no filter
			return getUserTasks(userId);

		} catch (Exception e) {
			e.printStackTrace();
			return getUserTasks(userId); // fallback
		}
	}

	public List<Task> sortBy(int userId, String sortBy, String sortOrder) throws SQLException {
		return taskDao.getSortedTasks(userId, sortBy, sortOrder);
	}

	public List<Task> searchTasks(int userId, String keyword) throws SQLException {
		return taskDao.searchTasks(userId, keyword);
	}

	public List<Task> searchAndSort(int userId, String searchBy, String sortBy, String sortOrder) throws SQLException {
		return taskDao.searchAndSortTasks(userId, searchBy, sortBy, sortOrder);
	}
}
