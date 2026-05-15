<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <style>
        body {
            background-color: rgb(2, 188, 123);
            text-align: center;
        }
        p {
            font-size: 50px;
            color: rgb(1, 0, 12);
        }
    </style>
</head>
<body>
	<p>ERROR</p>
	<p><%= exception.message %></p>
	<p><%= Try to login %></p>
	<a href="login">login</a>
</body>
</html>