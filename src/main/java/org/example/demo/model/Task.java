package org.example.demo.model;

public class Task {
	private int id;
	private String title;
	private String description;
	private Status status;
	private Priority priority;
	private int userId;

	public Task() {
	}

	public Task(String title, String description, Status status, Priority priority, int userId) {
		this.title = title;
		this.description = description;
		this.status = status;
		this.priority = priority;
		this.userId = userId;
	}

	public int getId() {
		return id;
	}

	public String getTitle() {
		return title;
	}

	public String getDescription() {
		return description;
	}

	public Status getStatus() {
		return status;
	}

	public Priority getPriority() {
		return priority;
	}

	public int getUserId() {
		return userId;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public void setPriority(Priority priority) {
		this.priority = priority;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
}