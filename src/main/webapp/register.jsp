<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="error.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Register</title>
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
				width: 360px;
			}
			
			h2 {
				text-align: center;
				margin-bottom: 24px;
				color: #333;
			}
			
			label {
				font-size: 13px;
				color: #555;
				display: block;
				margin-bottom: 4px;
			}
			
			input[type="text"],
			input[type="email"],
			input[type="password"] {
				width: 100%;
				padding: 10px;
				margin-bottom: 16px;
				border: 1px solid #ddd;
				border-radius: 6px;
				font-size: 14px;
				outline: none;
			}
			
			input:focus {
				border-color: #4CAF50;
			}
			
			button {
				width: 100%;
				padding: 11px;
				background: #4CAF50;
				color: white;
				border: none;
				border-radius: 6px;
				font-size: 15px;
				cursor: pointer;
				margin-top: 10px;
			}
			
			button:hover {
				background: #45a049;
			}
			
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
			<h2>Create Account</h2>

			<form action="register" method="post">

				<label>Full Name</label>
				<input type="text" name="name" placeholder="Enter your full name" required />

				<label>Email</label>
				<input type="email" name="email" placeholder="Enter your email" required />

				<label>Password</label>
				<input type="password" name="password" placeholder="Create password" required />

				<label>Confirm Password</label>
				<input type="password" name="confirmPassword" placeholder="Confirm password" required />

				<button type="submit">Register</button>
			</form>

			<div class="link">
				Already have an account? <a href="login">Login here</a>
			</div>
		</div>
	</body>
</html>