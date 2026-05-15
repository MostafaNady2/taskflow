<%@ page contentType="text/html;charset=UTF-8" language="java" 
import="java.util.List, org.example.demo.model.Task, org.example.demo.model.User" ErrorPage="error.jsp"
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">   <!-- ← This is important -->
		<title>Add New Task</title>
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
		<h1>Add New Task</h1>

		<form action="<%= request.getContextPath() %>/tasks/add" method="post">
			<label for="title">Title:</label>
			<input type="text" id="title" name="title" required />

			<label for="description">Description:</label>
			<textarea id="description" name="description" rows="4"></textarea>

			<label for="status">Status:</label>
			<select id="status" name="status">
				<option value="TODO">To Do</option>
				<option value="IN_PROGRESS">In Progress</option>
				<option value="COMPLETED">Completed</option>
			</select>
			<label for="priority">Priority:</label>
			<select id="priority" name="priority">
				<option value="LOW">Low</option>
				<option value="MEDIUM">Medium</option>
				<option value="HIGH">High</option>
			</select>

			<div>
				<button type="submit">Create Task</button>
				<a href="<%= request.getContextPath() %>/tasks" class="cancel">Cancel</a>
			</div>
		</form>
	</body>
</html>