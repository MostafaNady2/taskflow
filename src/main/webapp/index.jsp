<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="error.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Login</title>
		<style>
			* { margin: 0; padding: 0; box-sizing: border-box; }
			
			body {
				font-family: Arial, sans-serif;
				background: #f0f2f5;
				height: 100vh;
				display: flex;
				justify-content: center;
				align-items: center;
			}
			
			.card {
				background: white;
				padding: 40px;
				border-radius: 12px;
				box-shadow: 0 2px 10px rgba(0,0,0,0.1);
				width: 320px;
			}
			
			h2 {
				text-align: center;
				margin-bottom: 24px;
				color: #333;
			}
			
			label { font-size: 13px; color: #555; }
			
			input[type="email"],
			input[type="password"] {
				width: 100%;
				padding: 10px;
				margin: 6px 0 16px;
				border: 1px solid #ddd;
				border-radius: 6px;
				font-size: 14px;
				outline: none;
			}
			
			input:focus { border-color: #4CAF50; }
			
			button {
				width: 100%;
				padding: 11px;
				background: #4CAF50;
				color: white;
				border: none;
				border-radius: 6px;
				font-size: 15px;
				cursor: pointer;
			}
			
			button:hover { background: #45a049; }
			.link {
				text-align: center;
				margin-top: 20px;
				font-size: 14px;
			}
			
			.link a {
				color: #4CAF50;
				text-decoration: none;
			}
			
			.link a:hover {
				text-decoration: underline;
			}
		</style>
	</head>
	<body>
		<div class="card">
			<h2>Login</h2>
			<form action="login" method="post">
				<label>Email</label>
				<input type="email" name="email" placeholder="Enter your email" required />

				<label>Password</label>
				<input type="password" name="password" placeholder="Enter your password" required />

				<button type="submit">Login</button>
			</form>

			<div class="link">
				Don't have an account? <a href="register">Register here</a>
			</div>
		</div>
	</body>
</html>