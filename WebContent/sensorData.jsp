<%@ include file="header.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.SensorData" %>
<%@ page import="helper.DateConverter" %>

<%! @SuppressWarnings("unchecked") %> 
<%
	if(request.getAttribute("sensorData")==null){
		response.sendRedirect("Servlet_GetSensorData");
	}
	//<meta http-equiv="Refresh" content="10">
%>
	<div id="overlay">
		<div id="blurWrapper">	
			<h1>Location sensor readings</h1>		
			<br>	
			<table class="table table-bordered">			
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
	<div id="sensorDataWindow" style="display:none">
		<h3 id="sensorLocation"></h3>
		<br>		
		<button title="cancel" title="Cancel" type="button" class="btn btn-default cancel">Cancel</button>
		<br><br>		
		<div>
			<table id="sensorTable" class="table table-bordered">
			<tr>
				<th>Status</th>
				<th>Contact time</th>
			</tr>
			
						
			</table>
		</div>	
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
				"height": "85%",
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
			
			$("#sensorDataWindow").toggle();
		}
		$(document).ready(function(){
			$(".cancel").click(function(){
				window.location.href="Servlet_GetSensorData";
			});
				
		});			
	</script>
</body>
</html>