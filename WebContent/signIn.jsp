<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>LoRa Server Login</title>
<style>

	#formArea {
		width: 450px;		
		position: fixed;
		left: 40%;
		top: 10%;
	}

</style>
</head>
<body>
	<div id="blurWrapper">
		<div id="formArea">
			<h3>Lora-Tocsin sign in</h3>
			<br>
			<form action="Servlet_SignIn" method="post" id="signIn">
			<div class="form-group">
				<label for="user_name">User name:</label>	
					<input type="text" name="user_name" id="user_name" placeholder="Enter username">
			</div>
			<div class="form-group">
				<label for="psswd">Password:</label>
					<input type="password" name="psswd" id="psswd" placeholder="Enter password">
			</div>
			<button type="submit" class="btn btn-default" title="Sign in" id="logIn">Sign in</button>
			</form>
		</div>
	</div>
	<div id="infoWindow" style="display:none">
		<br>
		<h3 id="infoMessage"></h3>
		<br>
		<button title="Ok" type="button" class="btn btn-default reload" id="infoButton">Ok</button>	
	</div>	
	<script>
		function blur(){
			$("#blurWrapper").css({
				"filter": "blur(8px)",
				"-webkit-filter": "blur(8px)",
				"pointer-events": "none"
			});			
		}
		
		function info(infoValue, infoType){
			
			$("#infoWindow").css({
				"width": "400px", 
				"border-radius": "15px",
				"background-color": "white",		
				"color": "black",
				"text-align": "center",
				"padding": "10px",
				"border": "1px solid black",
				"position": "fixed",
				"left": "35%",
				"top": "35%",	
				"z-index": "10"
			});
			$("#infoMessage").text(infoValue);
			blur();
			$("#infoWindow").toggle();
			$("#infoButton").focus();	
						
		};
		
		$(document).ready(function(){
			$("#user_name").focus();
			
			$(".reload").click(function(){
				window.location.href="Servlet_GetSensorData";
			});
			
		});
		<%
		if(request.getParameter("info")!=null){
			String info = request.getParameter("info");
			String infoValue="";
			if(info.equals("siE1")){
				infoValue= "Invalid username or password!";
			}
			if(info.equals("siE2")){
				infoValue= "Error sign in!";
			}
			if(info.equals("siE3")){
				infoValue= "Forbidden symbols in form input";
			}
			if(infoValue!=""){
				out.print("info('"+infoValue+"');");
			}
		}		
		%>	
	</script>
</body>
</html>