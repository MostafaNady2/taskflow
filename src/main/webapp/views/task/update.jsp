<%@ page contentType="text/html;charset=UTF-8" language="java"
import="java.util.List, org.example.demo.model.Task, org.example.demo.model.User"
errorPage="error.jsp"
 %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Update Task</title>
		<style>
			body { font-family: Arial, sans-serif; margin: 20px; }
			form { max-width: 500px; margin: 20px 0; }
			label { display: block; margin-top: 10px; }
			input, textarea, select { width: 100%; padding: 6px; margin-top: 4px; }
			button { margin-top: 15px; padding: 8px 16px; }
			.cancel { margin-left: 10px; }
		</style>
	</head>
	<body>
		<h1>Update Task</h1>

		<%
			Task task = (Task) request.getAttribute("task");
			if (task == null) {
			%>
			<p style="color: red;">Task not found.</p>
			<a href="<%= request.getContextPath() %>/tasks">Back to Tasks</a>
			<%
			} else {
			%>
			<form action="<%= request.getContextPath() %>/tasks/update" method="post">
				<input type="hidden" name="id" value="<%= task.getId() %>" />

				<label for="title">Title:</label>
				<input type="text" id="title" name="title" value="<%= task.getTitle() %>" required />

				<label for="description">Description:</label>
				<textarea id="description" name="description" rows="4"><%= task.getDescription() != null ? task.getDescription() : "" %></textarea>

				<label for="status">Status:</label>
				<select id="status" name="status">
					<option value="TODO" <%= task.getStatus().name().equals("TODO") ? "selected" : "" %>>To Do</option>
					<option value="IN_PROGRESS" <%= task.getStatus().name().equals("IN_PROGRESS") ? "selected" : "" %>>In Progress</option>
					<option value="COMPLETED" <%= task.getStatus().name().equals("COMPLETED") ? "selected" : "" %>>Completed</option>
				</select>

				<label for="priority">Priority:</label>
				<select id="priority" name="priority">
					<option value="LOW" <%= task.getPriority().name().equals("LOW") ? "selected" : "" %>>Low</option>
					<option value="MEDIUM" <%= task.getPriority().name().equals("MEDIUM") ? "selected" : "" %>>Medium</option>
					<option value="HIGH" <%= task.getPriority().name().equals("HIGH") ? "selected" : "" %>>High</option>
				</select>

				<div>
					<button type="submit">Update Task</button>
					<a href="<%= request.getContextPath() %>/tasks" class="cancel">Cancel</a>
				</div>
			</form>
			<%
			}
		%>
	</body>
</html>