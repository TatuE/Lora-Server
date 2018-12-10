<%@ include file="header.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.SensorData" %>
<%@ page import="helper.DateConverter" %>
<meta http-equiv="Refresh" content="10">
<%! @SuppressWarnings("unchecked") %>	
		<div>
			<br>
			<button title="back" id="back" onclick="document.location='sensorData.jsp'">Back</button>
			<%
			if(request.getAttribute("sensorData")!=null){
				ArrayList<SensorData> sensorData = (ArrayList<SensorData>)request.getAttribute("sensorData");
				out.print("<h2> Location: "+sensorData.get(0).getLocationName()+", "+sensorData.get(0).getLocation()+" sensor readings </h2>");	
			}else{
				out.print("<h2> No sensor data from location </h2>");
			}
			%>						
		</div>	
		<table>		
			<%
				if(request.getAttribute("sensorData")!=null){
					ArrayList<SensorData> sensorData = (ArrayList<SensorData>)request.getAttribute("sensorData");
					if(sensorData.size()>0){
						DateConverter dc = new DateConverter();
						out.print("<tr>");				
						out.print("<th>Status</th>");
						out.print("<th>Contact time</th>");
						out.print("</tr>");
						
						for(int i=0;i<sensorData.size();i++){
							out.print("<tr>");				
							if(sensorData.get(i).getSensor_data()==1){
								out.print("<td>Fire detected</td>");
							}else{
								out.print("<td>No fire detected</td>");
							}
							out.print("<td>"+dc.dateFormat(sensorData.get(i).getSensor_data_time())+"</td>");					
							out.print("</tr>");
						}
					}else{
						out.print("<h2> No location sensor data</h2>");					
					}
				}
			%>
		</table>
		<script>
			var navButton = document.getElementById("sensor data");
			navButton.style.display = "none";
		</script>
	</body>
</html>