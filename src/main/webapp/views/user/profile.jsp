<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.demo.model.User" errorPage="error.jsp" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Profile - Task Manager</title>
		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
		<style>
			* { margin: 0; padding: 0; box-sizing: border-box; }
			body {
				font-family: Arial, sans-serif;
				background: #f0f2f5;
			}
			/* Top Navigation Bar */
			.topbar {
				background: #1368ae;
				color: white;
				padding: 15px 25px;
				display: flex;
				justify-content: space-between;
				align-items: center;
				box-shadow: 0 2px 5px rgba(0,0,0,0.1);
			}
			.topbar h1 {
				font-size: 22px;
				font-weight: bold;
			}
			.topbar a {
				color: white;
				text-decoration: none;
				padding: 8px 16px;
				border-radius: 6px;
				font-size: 15px;
			}
			.topbar a:hover {
				background: #555;
			}
			.logout-btn {
				background: #b11c19;
			}
			.logout-btn:hover {
				background: #c62828;
			}
			
			.container {
				max-width: 900px;
				margin: 30px auto;
				background: white;
				border-radius: 12px;
				box-shadow: 0 4px 15px rgba(0,0,0,0.1);
				overflow: hidden;
			}
			.header {
				background: linear-gradient(135deg, #4CAF50, #45a049);
				color: white;
				padding: 40px 20px;
				text-align: center;
			}
			.avatar {
				width: 100px;
				height: 100px;
				background: white;
				color: #4CAF50;
				border-radius: 50%;
				display: flex;
				align-items: center;
				justify-content: center;
				font-size: 42px;
				font-weight: bold;
				margin: 0 auto 15px;
				border: 5px solid white;
			}
			.content {
				padding: 30px 20px;
			}
			.stats-grid {
				display: grid;
				grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
				gap: 15px;
				margin: 25px 0;
			}
			.stat-card {
				background: #f8f9fa;
				padding: 20px;
				border-radius: 10px;
				text-align: center;
			}
			.stat-number {
				font-size: 30px;
				font-weight: bold;
				color: #4CAF50;
			}
			.chart-container {
				margin: 30px 0;
				padding: 20px;
				background: #f8f9fa;
				border-radius: 12px;
			}
			.btn {
				padding: 12px 25px;
				border: none;
				border-radius: 6px;
				font-size: 15px;
				cursor: pointer;
				text-decoration: none;
				display: inline-block;
				margin: 5px;
			}
			.btn-primary { background: #4CAF50; color: white; }
			.btn-secondary { background: #1976D2; color: white; }
		</style>
	</head>
	<body>

		<!-- Top Navigation Bar -->
		<div class="topbar">
			<h1>Task Manager</h1>
			<a href="logout" class="logout-btn">Logout</a>
		</div>

		<%
			User user = (User) session.getAttribute("user");
			if(user == null) {
				response.sendRedirect("login");
				return;
			}
			
			int totalTasks = (Integer) request.getAttribute("totalTasks") != null ? (Integer) request.getAttribute("totalTasks") : 0;
			int completed = (Integer) request.getAttribute("completed") != null ? (Integer) request.getAttribute("completed") : 0;
			int inProgress = (Integer) request.getAttribute("inProgress") != null ? (Integer) request.getAttribute("inProgress") : 0;
			int todo = (Integer) request.getAttribute("todo") != null ? (Integer) request.getAttribute("todo") : 0;
			int highPriority = (Integer) request.getAttribute("highPriority") != null ? (Integer) request.getAttribute("highPriority") : 0;
		%>

		<div class="container">
			<div class="header">
				<div class="avatar"><%= user.getName() != null && !user.getName().isEmpty() ? user.getName().charAt(0) : "?" %></div>
				<h1><%= user.getName() %></h1>
				<p><%= user.getEmail() %></p>
			</div>

			<div class="content">
				<h2>Task Statistics</h2>

				<div class="stats-grid">
					<div class="stat-card">
						<div class="stat-number"><%= totalTasks %></div>
						<div>Total Tasks</div>
					</div>
					<div class="stat-card">
						<div class="stat-number" style="color:#4CAF50"><%= completed %></div>
						<div>Completed</div>
					</div>
					<div class="stat-card">
						<div class="stat-number" style="color:#ff9800"><%= inProgress %></div>
						<div>In Progress</div>
					</div>
					<div class="stat-card">
						<div class="stat-number" style="color:#666"><%= todo %></div>
						<div>To Do</div>
					</div>
				</div>

				<div class="chart-container">
					<canvas id="statusChart" height="180"></canvas>
				</div>

				<div class="chart-container">
					<canvas id="priorityChart" height="180"></canvas>
				</div>

				<div style="text-align: center; margin-top: 30px;">
					<a href="tasks" class="btn btn-primary">View All Tasks</a>
					<a href="#" class="btn btn-secondary">Edit Profile</a>
				</div>
			</div>
		</div>

		<script>
			new Chart(document.getElementById('statusChart'), {
				type: 'doughnut',
				data: {
					labels: ['Completed', 'In Progress', 'To Do'],
					datasets: [{
						data: [<%= completed %>, <%= inProgress %>, <%= todo %>],
						backgroundColor: ['#4CAF50', '#ff9800', '#666']
					}]
				},
				options: { responsive: true, maintainAspectRatio: true }
			});
			
			new Chart(document.getElementById('priorityChart'), {
				type: 'bar',
				data: {
					labels: ['High Priority'],
					datasets: [{
						label: 'High Priority Tasks',
						data: [<%= highPriority %>],
						backgroundColor: '#e53935'
					}]
				},
				options: {
					responsive: true,
					maintainAspectRatio: true,
					scales: { y: { beginAtZero: true } }
				}
			});
		</script>
	</body>
</html>