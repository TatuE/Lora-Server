<%@ include file="header.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.SensorData" %>
<%@ page import="helper.DateConverter" %>

<%! @SuppressWarnings("unchecked") %> 
<%	
	if(request.getParameter("info")==null){
		if(request.getAttribute("sensorData")==null){
			response.sendRedirect("Servlet_GetSensorData");
		}
	}	
%>
	<div class="overlay">
		<div id="blurWrapper">	
			<h1>Location sensor readings</h1>		
			<br>
			<div class="btn-group">									
				<button type="button" class="btn btn-info" id="search">
			   		<span class="glyphicon glyphicon-search"></span> Search
				</button>
				<button type="button" class="btn btn-success reload" id="reload">
			   		<span class="glyphicon glyphicon-refresh"></span> Reload
				</button>
			</div>
			<br><br>
			<div class="scrollOuter">
				<div class="scrollInner generalTD">				
					<table class="table table-bordered table-striped">			
						<%
						if(request.getAttribute("sensorData")!=null){
							ArrayList<SensorData> sensorData = (ArrayList<SensorData>)request.getAttribute("sensorData");
							if(sensorData.size()>0){
							DateConverter dc = new DateConverter();
							out.print("<tr>");
							out.print("<th>Locations name</th>");
							out.print("<th>Location</th>");
							out.print("<th>Status</th>");
							out.print("<th>Last contact</th>");
							out.print("<th>List all sensor records</th>");
							out.print("</tr>");
							
							for(int i=0;i<sensorData.size();i++){
								out.print("<tr>");
								out.print("<td>"+sensorData.get(i).getLocationName()+"</td>");
								out.print("<td>"+sensorData.get(i).getLocation()+"</td>");
								if(sensorData.get(i).getSensor_data()==1){
									out.print("<td>Fire detected</td>");
								}else{
									out.print("<td>No fire detected</td>");
								}
								out.print("<td>"+dc.dateFormat(sensorData.get(i).getSensor_data_time())+"</td>");
								out.print("<td> <button id='listButton' title='List sensor data' class='btn btn-info' onclick=listAllData("+sensorData.get(i).getDevice_placement_id()+")><span class='glyphicon glyphicon-search'></span> List data</button></td>");
								out.print("</tr>");
								}
							}else{
								out.print("<h2> No active location sensor data</h2>");
							}
						}
						%>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div id="searchWindow" style="display:none">
		<h3>Search devices</h3>
		<br>		
		<form action="Servlet_GetSensorData" method="post" id="searchForm">
			<div class="form-group">
				<label for="searchLocationName">Location name: </label>
					<input type="text" name="locationName" id="searchLocationName" placeholder="Enter location name"></input>
			</div>
			<div class="form-group">	
			<label for="searchLocation"> Location:</label>
				<input type="text" name="location" id="searchLocation" value="" placeholder="Enter location area">
			</div>
			<div class="form-group">
				<label for="SearchFormSelect">Status: </label>
					<select name="status" class="form-control" id="SearchFormSelect">
						<option value="0"> No fire detected</option>
						<option value="1"> Fire detected</option>
						<option value="2">Status indifferent</option>
					</select>
			</div>				
			<button type="submit" class="btn btn-default" value="Search">Search</button>		
		</form>
		<br>	
		<button title="cancel" title="Cancel" type="button" class="btn btn-default cancel">Cancel</button>	
	</div>	
	<div id="sensorDataWindow" style="display:none">
		<h3 id="sensorLocation"></h3>
		<br>		
		<button title="Back" type="button" class="btn btn-default reload">back</button>
		<br><br>		
		<div class="scrollOuter">
			<div class="scrollInner sensorTD">
				<table id="sensorTable" class="table table-bordered table-striped">
				<tr>
					<th>Status</th>
					<th>Contact time</th>
				</tr>				
							
				</table>
			</div>
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
	
		function listAllData(id){			
			$("#sensorDataWindow").css({
				"width": "450px",
				"height": "580px",
				"border-radius": "15px",
				"background-color": "white",		
				"color": "black",
				"text-align": "center",
				"padding": "10px",
				"border": "1px solid black",
				"position": "fixed",
				"left": "35%",
				"top": "10%",
				"z-index": "10"
			});			
			
			$.getJSON("Servlet_SensorDataAjax", function(result){				
				$.each(result, function(i, field){
					if(field.device_placement_id==id){						
						$("#sensorLocation").text("Location: "+field.name+", "+field.location);
						return false;					
					}					
				});
				
				$.each(result, function(i, field){
					if(field.device_placement_id==id){
						var data;
						if(field.sensor_data==0){
							data= "No fire detected";
						}else{
							data= "Fire detected";	
						}
						$("#sensorTable tr:last").after("<tr><td>"+data+"</td><td>"+field.sensor_data_time+"</td></tr>");						
					}					
				});
			});	
			blur();
			$("#sensorDataWindow").toggle();
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
			$(".reload").click(function(){
				window.location.href="Servlet_GetSensorData";
			});
			
			$(".cancel").click(function(){
				$("#searchWindow").css({
					"display":"none"	
				});
				
				$("#sensorDataWindow").css({
					"display":"none"	
				});				
				
				$("#blurWrapper").css({
					"filter": "",
					"-webkit-filter": "",
					"pointer-events": ""
				});				
			});
			
			$("#search").click(function(){
				$("#searchWindow").css({
					"width": "350px", 
					"border-radius": "15px",
					"background-color": "white",		
					"color": "black",
					"text-align": "center",
					"padding": "10px",
					"border": "1px solid black",
					"position": "fixed",
					"left": "35%",
					"top": "15%",
					"z-index": "10"
				});				
				$("#searchWindow").toggle();
				blur();
				$("#searchLocationName").focus();
				
			});				
		});
		<%
		if(request.getParameter("info")!=null){
			String info = request.getParameter("info");
			String infoValue="";
			if(info.equals("sdE1")){
				infoValue= "forbidden symbol in form input!";
			}
			
			if(infoValue!=""){
				out.print("info('"+infoValue+"');");
			}
		}		
		%>
	</script>
</body>
</html>