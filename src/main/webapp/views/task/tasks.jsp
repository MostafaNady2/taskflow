<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, org.example.demo.model.Task, org.example.demo.model.User" errorPage="error.jsp" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Tasks</title>
		<style>
			body { font-family: Arial, sans-serif; background:#f0f2f5; padding:20px; }
			h1 { color:#333; }
			.topbar { display:flex; justify-content:space-between; align-items:center; margin-bottom:20px; flex-wrap:wrap; gap:10px; }
			.topbar span { color:#555; font-size:14px; }
			
			<%-- .logout { padding:8px 16px; background:#e53935; color:white; border:none; border-radius:6px; text-decoration:none; font-size:14px; }
			.logout:hover { background:#c62828; } --%>
			
			table { width:100%; border-collapse:collapse; background:white; border-radius:8px; overflow:hidden; box-shadow:0 2px 8px rgba(0,0,0,0.1); margin-top:15px; }
			th { background:#4CAF50; color:white; padding:12px; text-align:left; }
			td { padding:12px; border-bottom:1px solid #eee; }
			tr:hover { background:#f9f9f9; }
			.TODO { color:gray; font-weight:bold; }
			.IN_PROGRESS { color:orange; font-weight:bold; }
			.COMPLETED { color:green; font-weight:bold; }
			.LOW { color:#4CAF50; font-weight:bold; }
			.MEDIUM { color:#ff9800; font-weight:bold; }
			.HIGH { color:#e53935; font-weight:bold; }
			.btn-delete, .btn-edit { padding:6px 14px; color:white; border:none; border-radius:4px; cursor:pointer; font-size:13px; }
			.btn-delete { background:#e53935; }
			.btn-delete:hover { background:#c62828; }
			.btn-edit { background:#1976D2; }
			.btn-edit:hover { background:#1565C0; }
			.controls { background:white; padding:18px 20px; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.08); margin-bottom:20px; display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:15px; }
			.search-box input { width:380px; padding:12px 15px; border:1px solid #ccc; border-radius:6px; font-size:16px; }
			.sort-section { display:flex; align-items:center; gap:10px; }
			select { padding:10px 12px; border-radius:6px; border:1px solid #ccc; }
			button.sort-btn { padding:10px 22px; background:#1976D2; color:white; border:none; border-radius:6px; cursor:pointer; font-size:15px; }
			button.sort-btn:hover { background:#1565C0; }
			.btn-profile, .btn-add {
				padding: 10px 20px;
				border: none;
				border-radius: 6px;
				text-decoration: none;
				font-size: 14px;
				font-weight: bold;
				cursor: pointer;
				display: inline-block;
				margin-left: 8px;
			}
			
			.btn-profile {
				background: #1976D2;
				color: white;
			}
			
			.btn-profile:hover {
				background: #1565C0;
			}
			
			.btn-add {
				background: #4CAF50;
				color: white;
			}
			
			.btn-add:hover {
				background: #45a049;
			}
		</style>
	</head>
	<body>

		<%
			User user   = (User) session.getAttribute("user");
			String search = request.getParameter("search") ;
			String sortBy = request.getParameter("sortBy") ;
			String sortOrder = request.getParameter("sortOrder") ;
			
			if(search == null) {
				search = "";
			}
			if(sortBy == null) {
				sortBy = "";
			}
		%>

		<div class="topbar">
			<h1>Task Manager</h1>
			<div>
				<span>Welcome, <%= user.getName().substring(0,1).toUpperCase() + user.getName().substring(1) %></span>

				<a href="profile" class="btn-profile">Profile</a>
				<a href="tasks/add" class="btn-add"> Add Task</a>
				<%-- <a href="logout" class="logout">Logout</a> --%>
			</div>
		</div>

		<!-- Search + Sort -->
		<div class="controls">
			<form action="tasks" method="get" style="width:100%; display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:15px;">

				<!-- Search -->
				<div class="search-box" style="display:flex; gap:10px; align-items:center;">
					<input type="text" name="search"
					placeholder="Search by title or description..."
					value="<%= search %>">
					<!-- No separate search button -->
				</div>

				<!-- Sort -->
				<div class="sort-section">
					<label><strong>Sort By:</strong></label>
					<select name="sortBy">
						<option value="">Default</option>
						<option value="title"    <%= "title".equals(sortBy)    ? "selected" : "" %>>Title</option>
						<option value="status"   <%= "status".equals(sortBy)   ? "selected" : "" %>>Status</option>
						<option value="priority" <%= "priority".equals(sortBy) ? "selected" : "" %>>Priority</option>
					</select>
					<select name="sortOrder">
						<option value="asc"  <%= !"desc".equals(sortOrder) ? "selected" : "" %>>&#8593;</option>
						<option value="desc" <%=  "desc".equals(sortOrder) ? "selected" : "" %>>&#8595;</option>
					</select>
					<button type="submit" class="sort-btn">Apply</button>
				</div>

			</form>
		</div>
		<!-- Tasks Table -->
		<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>Title</th>
					<th>Description</th>
					<th>Status</th>
					<th>Priority</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
					List<Task> tasks = (List<Task>) request.getAttribute("tasks");
					if (tasks != null && !tasks.isEmpty()) {
						for (Task task : tasks) {
						%>
						<tr>
							<td><%= task.getId() %></td>
							<td><%= task.getTitle() %></td>
							<td><%= task.getDescription() %></td>
							<td class="<%= task.getStatus().name() %>"><%= task.getStatus().name() %></td>
							<td class="<%= task.getPriority().name() %>"><%= task.getPriority().name() %></td>
							<td>
								<div style="display:flex; gap:6px;">
									<form action="tasks/update" method="get" style="display:inline;">
										<input type="hidden" name="id" value="<%= task.getId() %>">
										<button type="submit" class="btn-edit">Update</button>
									</form>
									<form action="tasks/delete" method="post" style="display:inline;">
										<input type="hidden" name="id" value="<%= task.getId() %>">
										<button type="submit" class="btn-delete" onclick="return confirm('Delete this task?')">Delete</button>
									</form>
								</div>
							</td>
						</tr>
						<%
						}
					} else {
					%>
					<tr>
						<td colspan="6" style="text-align:center; color:gray; padding:20px;">No tasks found</td>
					</tr>
					<% } %>
				</tbody>
			</table>

		</body>
	</html>