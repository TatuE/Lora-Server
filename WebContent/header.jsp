<%
	if(!request.getRequestURI().equals("/loRaServer/sensorData.jsp")){		
		if(session.getAttribute("User")==null){
			session.setAttribute("targetPage", request.getRequestURL());
			response.sendRedirect("signIn.jsp");
		}
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
	<script src="http://code.jquery.com/ui/1.11.0/jquery-ui.js"></script><!-- datepickeriä varten -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css"><!-- datepickeriä varten -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<meta charset="UTF-8">
	<title>Lora-Tocsin</title>
	<style>
		body{
			  background-color:#535559;
		}	
	</style>
</head>
<body>
	<div>
		<nav class="navbar navbar-inverse navbar-fixed-top" >
  			<div class="container-fluid">
    			<div class="navbar-header">
      				<h4 class="navbar-text">Lora-Tocsin</h4>
    			</div>
    			<ul class="nav navbar-nav">      
			    	<li><a href="Servlet_GetSensorData" id="sensorData">Sensor data</a></li>
			    	<li class="navMenu"><a href="Servlet_GetDevices" id="deviceList">Device list</a></li>
			    	<li class="navMenu"><a href="Servlet_GetLocations" id="locationList">Location list</a></li>
			    	<li class="navMenu"><a href="Servlet_GetDevicePlacements" id="devicePlacementList">Device placement list</a></li>
    			</ul>    			
			    <ul class="nav navbar-nav navbar-right">			    	
			    	<li id="user"><p class="navbar-text" id="userName"></p></li>			      
			    	<li id="signIn"><a href="signIn.jsp"><span class="glyphicon glyphicon-log-in"></span> Sign in</a></li>      
			    	<li title="Sign out"><button class="btn btn-danger navbar-btn" id="signOut" onclick=signOut()>Sign out</button></li>      
			    </ul>
  			</div>
		</nav>		
	</div>
	<br>
	<script>
		function signOut(){
			location.href="Servlet_SignIn?signOut=1";	
		}
		
		<%
		String currentPage = request.getRequestURI();	
		if(currentPage.equals("/loRaServer/sensorData.jsp")){
			out.print("$('#sensorData').hide();");
		}else if(currentPage.equals("/loRaServer/deviceList.jsp")){
			out.print("$('#deviceList').hide();");
		}else if(currentPage.equals("/loRaServer/locationList.jsp")){
			out.print("$('#locationList').hide();");
		}else if(currentPage.equals("/loRaServer/devicePlacementList.jsp")){
			out.print("$('#devicePlacementList').hide();");
		}
		
		if(session.getAttribute("User")==null){	
			out.println("$('.navMenu').hide();");
			out.println("$('#user').hide();");	
			out.print("$('#signOut').hide();");
		}
		
		if(session.getAttribute("User")!=null){
			out.print("$('#signIn').hide();");
			out.println("$('.navMenu').show();");
			out.println("$('#user').show();");	
			out.print("$('#signOut').show();");
			out.print("$('#userName').text('Signed in: "+session.getAttribute("User")+"');");
		}		
		%>
	</script>	
<hr>