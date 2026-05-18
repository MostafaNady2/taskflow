package org.example.demo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.example.demo.model.Priority;
import org.example.demo.model.Status;
import org.example.demo.model.Task;
import org.example.demo.utils.DBUtil;

public class TaskDao {
	public List<Task> getUserTasks(int userId) {
		List<Task> tasks = new ArrayList<>();
		String query = "select * from tasks where user_id = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pst = conn.prepareStatement(query)) {
			pst.setInt(1, userId);
			ResultSet rs = pst.executeQuery();
			return mapResultSet(rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tasks;
	}

	public Optional<Task> getTaskById(int id) {
		Optional<Task> task = Optional.empty();
		String query = "select * from tasks where id = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pst = conn.prepareStatement(query)) {
			pst.setInt(1, id);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Task t = new Task();
				t.setId(rs.getInt("id"));
				t.setTitle(rs.getString("title"));
				t.setDescription(rs.getString("description"));
				t.setStatus(Status.valueOf(rs.getString("status")));
				t.setPriority(Priority.valueOf(rs.getString("priority")));
				t.setUserId(rs.getInt("user_id"));
				task = Optional.of(t);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return task;
	}

	public void createTask(Task task) {
		String query = "insert into tasks (title, description, status,priority, user_id) values (?, ?, ?, ?, ?)";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pst = conn.prepareStatement(query)) {
			pst.setString(1, task.getTitle());
			pst.setString(2, task.getDescription());
			pst.setString(3, task.getStatus().toString());
			pst.setString(4, task.getPriority().toString());
			pst.setInt(5, task.getUserId());
			pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void deleteTask(int taskId) {
		String query = "delete from tasks where id = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pst = conn.prepareStatement(query)) {
			pst.setInt(1, taskId);
			pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void updateTask(Task task) {
		String query = "update tasks set title = ?, description = ?, status = ? ,priority = ? where id = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pst = conn.prepareStatement(query)) {
			pst.setString(1, task.getTitle());
			pst.setString(2, task.getDescription());
			pst.setString(3, task.getStatus().toString());
			pst.setString(4, task.getPriority().toString());
			pst.setInt(5, task.getId());
			pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Task> searchTasks(int userId, String keyword) throws SQLException {
		String sql = "SELECT * FROM tasks WHERE user_id = ? AND (title LIKE ? OR description LIKE ?)";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			stmt.setString(2, "%" + keyword + "%");
			stmt.setString(3, "%" + keyword + "%");
			return mapResultSet(stmt.executeQuery());
		}
	}

	public List<Task> getSortedTasks(int userId, String sortBy, String sortOrder) throws SQLException {
		String sql = "SELECT * FROM tasks WHERE user_id = ? ORDER BY " + sortBy + " " + sortOrder;
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			return mapResultSet(stmt.executeQuery());
		}
	}

	// helper method to avoid code repetition
	private List<Task> mapResultSet(ResultSet rs) throws SQLException {
		List<Task> tasks = new ArrayList<>();
		while (rs.next()) {
			Task t = new Task();
			t.setId(rs.getInt("id"));
			t.setTitle(rs.getString("title"));
			t.setDescription(rs.getString("description"));
			t.setStatus(Status.valueOf(rs.getString("status")));
			t.setPriority(Priority.valueOf(rs.getString("priority")));
			t.setUserId(rs.getInt("user_id"));
			tasks.add(t);
		}
		return tasks;
	}

	public List<Task> searchAndSortTasks(int userId, String searchBy, String sortBy, String sortOrder) throws SQLException {
		String sql = "SELECT * FROM tasks WHERE user_id = ? AND (title LIKE ? OR description LIKE ?) ORDER BY " + sortBy + " " + sortOrder;
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			stmt.setString(2, "%" + searchBy + "%");
			stmt.setString(3, "%" + searchBy + "%");
			return mapResultSet(stmt.executeQuery());
		}
	}
}
