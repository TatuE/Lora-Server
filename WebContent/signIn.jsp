<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoRa Server sign in</title>
</head>
<body>
	<form action="Servlet_SignIn" method="post" id="signIn">
	<label>User name:</label>	
	<input type="text" name="user_name" id="user_name"><br>
	<label>Password:</label>
	<input type="password" name="psswd" id="psswd"><br>
	<label></label>
	<input type="submit" value="Log in" id="logIn">
	</form>
</body>
</html>