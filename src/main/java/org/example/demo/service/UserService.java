package org.example.demo.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.example.demo.dao.UserDao;
import org.example.demo.model.Task;
import org.example.demo.model.User;

public class UserService {
	private UserDao userDao = new UserDao();

	public List<User> getAllUsers() {
		return userDao.getAllUsers();
	}
	public User getUserById(int id) {
		Optional<User> userById = userDao.getUserById(id);
		userById.orElseThrow(() -> new RuntimeException("User not found"));
		return userById.get();
	}

	public User getUserByEmail(String email) {
		Optional<User> userByEmail= Optional.ofNullable(null);
		userByEmail = userDao.getUserByEmail(email);
		return userByEmail.orElse(null); 
	}
	public User getUserByCredentials(String email, String password) {
		Optional<User> userByCredentials = userDao.getUserByCredentials(email, password);
		userByCredentials.orElseThrow(() -> new RuntimeException("User not found"));
		return userByCredentials.get();
	}

	public int  createUser(User user){
		return userDao.createUser(user);
	}

	public List<Integer> getUserStatics(int userId) {
		TaskService taskService = new TaskService();
		List<Task> tasks = taskService.getUserTasks(userId);
		int totalTasks = tasks.size();
		int completed = (int)tasks.stream().filter(task -> task.getStatus().name().equals("COMPLETED")).count();
		int inProgress = (int)tasks.stream().filter(task -> task.getStatus().name().equals("IN_PROGRESS")).count();
		int todo = (int)tasks.stream().filter(task -> task.getStatus().name().equals("TODO")).count();
		int highPriority = (int)tasks.stream().filter(task -> task.getPriority().name().equals("HIGH")).count();
		List<Integer> userStatics = new ArrayList<>();
		userStatics.add(totalTasks);
		userStatics.add(completed);
		userStatics.add(inProgress);
		userStatics.add(todo);
		userStatics.add(highPriority);
		return userStatics;
	}
}
