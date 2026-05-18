<%@ page contentType="text/html;charset=UTF-8" language="java"
import="org.example.demo.model.User"
errorPage="error.jsp"
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Update Profile - Task Manager</title>
		<style>
			* { margin: 0; padding: 0; box-sizing: border-box; }
			body { font-family: Arial, sans-serif; background: #f0f2f5; }
			
			.topbar {
				background: #1368ae;
				color: white;
				padding: 15px 25px;
				display: flex;
				justify-content: space-between;
				align-items: center;
				box-shadow: 0 2px 5px rgba(0,0,0,0.1);
			}
			.topbar h1 { font-size: 22px; font-weight: bold; }
			.topbar a {
				color: white;
				text-decoration: none;
				padding: 8px 16px;
				border-radius: 6px;
				font-size: 15px;
			}
			.topbar a:hover { background: #555; }
			.logout-btn { background: #b11c19; }
			.logout-btn:hover { background: #c62828; }
			
			.container {
				max-width: 520px;
				margin: 40px auto;
				background: white;
				border-radius: 12px;
				box-shadow: 0 4px 15px rgba(0,0,0,0.1);
				overflow: hidden;
			}
			.header {
				background: linear-gradient(135deg, #4CAF50, #45a049);
				color: white;
				padding: 30px 20px;
				text-align: center;
			}
			.avatar {
				width: 80px;
				height: 80px;
				background: white;
				color: #4CAF50;
				border-radius: 50%;
				display: flex;
				align-items: center;
				justify-content: center;
				font-size: 34px;
				font-weight: bold;
				margin: 0 auto 12px;
				border: 4px solid white;
			}
			.content { padding: 30px; }
			.error {
				background: #fdecea;
				color: #c62828;
				padding: 10px 14px;
				border-radius: 6px;
				margin-bottom: 18px;
				font-size: 14px;
				border-left: 4px solid #e53935;
			}
			label {
				display: block;
				margin-top: 16px;
				font-size: 14px;
				font-weight: bold;
				color: #333;
			}
			label span { font-weight: normal; color: gray; }
			input {
				width: 100%;
				padding: 10px 12px;
				margin-top: 5px;
				border: 1px solid #ccc;
				border-radius: 6px;
				font-size: 14px;
				box-sizing: border-box;
			}
			input:focus { outline: none; border-color: #4CAF50; box-shadow: 0 0 0 2px rgba(76,175,80,0.15); }
			.actions { margin-top: 25px; display: flex; gap: 10px; }
			.btn {
				padding: 10px 22px;
				border: none;
				border-radius: 6px;
				font-size: 15px;
				cursor: pointer;
				text-decoration: none;
				display: inline-block;
			}
			.btn-primary { background: #4CAF50; color: white; }
			.btn-primary:hover { background: #45a049; }
			.btn-secondary { background: #f0f0f0; color: #333; }
			.btn-secondary:hover { background: #ddd; }
		</style>
	</head>
	<body>

		<div class="topbar">
			<h1>Task Manager</h1>
			<a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
		</div>

		<%
			User user = (User) session.getAttribute("user");
			String errorMessage = (String) request.getAttribute("errorMessage");
			
			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/login");
				return;
			}
		%>

		<div class="container">
			<div class="header">
				<div class="avatar"><%= user.getName().charAt(0) %></div>
				<h2>Edit Profile</h2>
				<p style="font-size:14px; opacity:0.85;"><%= user.getEmail() %></p>
			</div>

			<div class="content">
				<% if (errorMessage != null) { %>
				<div class="error"><%= errorMessage %></div>
				<% } %>

				<form action="<%= request.getContextPath() %>/user/update" method="post">
					<input type="hidden" name="id" value="<%= user.getId() %>" />

					<label for="name">Name:</label>
					<input type="text" id="name" name="name" value="<%= user.getName() %>" required />

					<label for="email">Email:</label>
					<input type="email" id="email" name="email" value="<%= user.getEmail() %>" required />

					<label for="password">New Password </span></label>
					<input type="password" id="password" name="password" placeholder="Enter new password" />

					<label for="confirmPassword">Confirm Password:</label>
					<input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password" />

					<div class="actions">
						<button type="submit" class="btn btn-primary">Update Profile</button>
						<a href="<%= request.getContextPath() %>/profile" class="btn btn-secondary">Cancel</a>
					</div>
				</form>
			</div>
		</div>

	</body>
</html>