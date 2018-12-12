<%@ include file="header.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.DevicePlacement" %>
<%@ page import="helper.DateConverter" %>
<%! @SuppressWarnings("unchecked") %>
<%
	if(request.getParameter("info")==null){
		if(request.getAttribute("devicePlacements")==null){
			response.sendRedirect("Servlet_GetDevicePlacements");
		}
	}
%>
	<div class="overlay">
		<div id="blurWrapper">		
			<h1>Device placement list</h1>		
			<br>
			<div class="btn-group">
				<button type="button" title="Add device placement" class="btn btn-primary" id="addDevicePlacement">
				   	<span class="glyphicon glyphicon-plus"></span> Add device placement
				</button>					
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
						if(request.getAttribute("devicePlacements")!=null){
							ArrayList<DevicePlacement> devicePlacement = (ArrayList<DevicePlacement>)request.getAttribute("devicePlacements");
							if(devicePlacement.size()>0){
								DateConverter dc = new DateConverter();
								out.print("<tr>");
								out.print("<th>Location Name</th>");
								out.print("<th>Location</th>");
								out.print("<th>Device UID</th>");
								out.print("<th>Placement date</th>");
								out.print("<th>Deactivate</th>");
								out.print("<th>Alter device placement</th>");
								out.print("</tr>");
								for(int i=0;i<devicePlacement.size();i++){
									out.print("<tr>");
									out.print("<td>"+devicePlacement.get(i).getLocationName()+"</td>");
									out.print("<td>"+devicePlacement.get(i).getLocation()+"</td>");
									out.print("<td>"+devicePlacement.get(i).getDeviceUid()+"</td>");
									out.print("<td>"+dc.dateFormat(devicePlacement.get(i).getPlacement_date())+"</td>");
									out.print("<td> <button id='deactivButton' title='Deactivate device placement' class='btn btn-warning' onclick=deactivateDevicePlacement("+devicePlacement.get(i).getDevice_placement_id()+")><span class='glyphicon glyphicon-pause'></span> Deactivate</button></td>");
									out.print("<td> <button id='alterButton' title='Alter device placement' class='btn btn-success' onclick=alterDevicePlacement("+devicePlacement.get(i).getDevice_placement_id()+")><span class='glyphicon glyphicon-wrench'></span> Alter</button></td>");
									out.print("</tr>");
								}
							}else{
								if(request.getAttribute("returnValue")!=null){
									String returnValue = (String)request.getAttribute("returnValue");
									
									if(returnValue.equals("get")){
										out.print("<h3>No active devices placements</h3>");
									}else if(returnValue.equals("search")){
										out.print("<h3>No search results</h3>");
									}		
								}					
							}
						}				
						%>		
					</table>
				</div>	
			</div>
		</div>
	</div>
	
	<div id="searchWindow" style="display:none">
		<h3>Search device placements</h3>
		<br>
		<form action="Servlet_GetDevicePlacements" method="post" id="searchForm">
			<div class="form-group">
				<label for="searchLocationName">Location name: </label>
					<input type="text" name="locationName" id="searchLocationName" placeholder="Enter location name"></input>
			</div>
			<div class="form-group">
				<label for="searchLocation">Location: </label>
					<input type="text" name="location" id="searchLocation" placeholder="Enter location"></input>
			</div>
			<div class="form-group">
				<label for="searchUid">Device UID: </label>
					<input type="text" name="uid" id="searchUid" placeholder="Enter device UID"></input>
			</div>
			<div class="form-group">
				<label for="from">Placement date start:</label>
					<input type="text" name="from" class="date" value="" id="from" placeholder="Enter search start date">
			</div>
			<div class="form-group">
				<label>Placement date end:</label>
					<input type="text" name="to" class="date" value="" id="to" placeholder="Enter search end date">
			</div>
			<button type="submit" title="Search" class="btn btn-default">Search</button>		
		</form>
		<br>
		<button title="cancel" title="Cancel" type="button" class="btn btn-default cancel">Cancel</button>	
	</div>
	
	<div id="addWindow" style="display:none">
		<h3>Add device placements</h3>
		<br>
		<form action="Servlet_AddDevicePlacement" method="post" id="addDevicePlacementForm">
			<div class="form-group">
				<label for="addLocation">Location</label>
					<select name="location" id="addLocation" class="form-control"></select>
			</div>
			<div class="form-group">
				<label for="addDevice">Device</label>
					<select name="device" id="addDevice" class="form-control"></select>
			</div>
			<div>
				<label for="addPlacementDate">Placement date</label>
					<input type="text" name="placement_date" id="addPlacementDate" class="date" placeholder="Enter placement date"></input>
			</div><br>
			<button type="submit" title="Add device placement" class="btn btn-default">Add device placement</button>
		</form>
		<br>
		<button title="cancel" title="Cancel" type="button" class="btn btn-default cancel">Cancel</button>	
	</div>
	
	<div id="altWindow" style="display:none">
		<h3>Alter device placements</h3>
		<br>
		<form action="Servlet_AlterDevicePlacement" method="post" id="alterDevicePlacementForm">		
			<div class="form-group">
				<label for="altLocation">Location</label>
					<select name="location" id="altLocation" class="form-control"></select>
			</div>
			<div class="form-group">
				<label for="altDevice">Device</label>
					<select name="device" id="altDevice" class="form-control"></select>
			</div>
			<div class="form-group">
				<label for="altPlacementDate">Placement date</label>
					<input type="text" name="placement_date" id="altPlacementDate" class="date" value="" placeholder="Enter placement date"></input>
			</div><br>
			<input type="hidden" name="device_placement_id" id="altId" value="" ></input>
			<button type="submit" title="Alter device placement" class="btn btn-default">Alter device placement</button>
		</form>
		<br>
		<button title="cancel" title="Cancel" type="button" class="btn btn-default cancel">Cancel</button>
	</div>
	
	<div id="infoWindow" style="display:none">
		<br>
		<h3 id="infoMessage"></h3>
		<br>
		<button title="Ok" type="button" class="btn btn-default reload" id="infoButton">Ok</button>	
	</div>
	
	<div id="deleteWindow" style="display:none">
		<br>
		<h3 id="deleteMessage"></h3>
		<br>		
		<div class="btn-group">
			<button type="button" title="Yes" class="btn btn-danger" id="remove">Yes</button>					
			<button type="button" title="No" class="btn btn-success cancel" id="cancel">No</button>				
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
		
		function currentDate(){
			var d = new Date();
			var yyyy = d.getFullYear().toString();
		    var mm = (d.getMonth() + 101).toString().slice(-2);
		    var dd = (d.getDate() + 100).toString().slice(-2);
		    var date = dd.concat(".",mm,".",yyyy);
		    return date;	
		}
		
		function sqlDateParse(sqlDate){
			var x = sqlDate.split("-");
			var date = x[2].concat(".",x[1],".",x[0]);
			return date;
		}		
		
		function deactivateDevicePlacement(id){
			var locationId;
			var deviceId;
			
			$("#deleteWindow").css({
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
			blur();
			$("#deleteMessage").text("Deactivate device placement?");						
			$("#deleteWindow").toggle();
			$("#remove").click(function(){					
				$.getJSON("Servlet_DevicePlacementsAjax", function(result){
					$.each(result, function(i, field){
						if(field.device_placement_id==id){
							window.location.href="Servlet_DeactivateDevicePlacement?device_placement_id="+id+"&device_id="+field.device_id+"&location_id="+field.location_id;	
						}
					});
				});
			});	
		};
		
		function alterDevicePlacement(id){
			$("#altWindow").css({
				"width": "320px", 
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
			
			$.getJSON("Servlet_DevicePlacementsAjax", function(result){
				$.each(result, function(i, field){
					if(field.device_placement_id==id){
						var deviceId = field.device_id;
						var locationId = field.location_id;
						$("#altPlacementDate").val(sqlDateParse(field.placement_date));
						$("#altId").val(id);
						$.getJSON("Servlet_LocationsAjax", function(result){
							$.each(result, function(i, fieldL){
								if(fieldL.location_id==locationId){
									$("#altLocation").append("<option selected value='"+fieldL.location_id+"'>"+fieldL.name+", "+fieldL.location+"</option>");		
								}else if(fieldL.in_use==0&&fieldL.activation_date.includes("-")){
									$("#altLocation").append("<option value='"+fieldL.location_id+"'>"+fieldL.name+", "+fieldL.location+"</option>");	
								}
							});
						});		
						
						$.getJSON("Servlet_DevicesAjax", function(result){
							$.each(result, function(i, fieldD){
								if(fieldD.device_id==deviceId){
									$("#altDevice").append("<option selected value='"+fieldD.device_id+"'>"+fieldD.uid+"</option>");	
								}else if(field.in_use==0&&field.activation_date.includes("-")){
									$("#altDevice").append("<option value='"+fieldD.device_id+"'>"+fieldD.uid+"</option>");	
								}				
							});
						});					
					}	
				});
			});			
			$("#altWindow").toggle();
			blur();
			$("#altLocation").focus();			
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
			$(".date").datepicker({ dateFormat: 'dd.mm.yy' });
			
			$(".cancel").click(function(){
				$("#searchWindow").css({
					"display":"none"	
				});
				
				$("#addWindow").css({
					"display":"none"	
				});
				
				$("#altWindow").css({
					"display":"none"	
				});
				
				$("#deleteWindow").css({
					"display":"none"	
				});
				
				$("#blurWrapper").css({
					"filter": "",
					"-webkit-filter": "",
					"pointer-events": ""
				});	
			});
			
			$(".reload").click(function(){
				window.location.href="Servlet_GetDevicePlacements";
			});
			
			$("#search").click(function(){
				$("#searchWindow").css({
					"width": "320px", 
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
			
			$("#addDevicePlacement").click(function(){
				$("#addWindow").css({
					"width": "320px", 
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
				
				$("#addLocation").append("<option value='-1'>Select location</option>");
				$.getJSON("Servlet_LocationsAjax", function(result){
					$.each(result, function(i, field){
						if(field.in_use==0&&field.activation_date.includes("-")){
							$("#addLocation").append("<option value='"+field.location_id+"'>"+field.name+", "+field.location+"</option>");	
						}				
					});
				});
				
				$("#addDevice").append("<option value='-1'>Select device</option>");
				$.getJSON("Servlet_DevicesAjax", function(result){
					$.each(result, function(i, field){
						if(field.in_use==0&&field.activation_date.includes("-")){
							$("#addDevice").append("<option value='"+field.device_id+"'>"+field.uid+"</option>");	
						}				
					});
				});
				$("#addPlacementDate").val(currentDate());
				$("#addWindow").toggle();
				blur();
				$("#addLocation").focus();
			});
			
			$("#addDevicePlacementForm").validate({
				rules: {
					location: {
						required: true,
						min: 0
					},
					device: {
						required: true,
						min: 0
					},
					placement_date: {
						required: true	
					}
				},
				messages: {
					location: {
						required: "Location required!",
						min: "Location required!"
					},
					device: {
						required: "Location required!",
						min: "Location required!"
					},
					placement_date: {
						required: "Date required!"	
					}				
				},
				submitHandler: function (form) {					
					document.forms["addDevicePlacementForm"].submit();
				}				
			});
			
			$("#alterDevicePlacementForm").validate({				
				rules: {
					location: {
						required: true,
						min: 0
					},
					device: {
						required: true,
						min: 0
					},
					placement_date: {
						required: true	
					}
				},
				messages: {
					location: {
						required: "Location required!",
						min: "Location required!"
					},
					device: {
						required: "Location required!",
						min: "Location required!"
					},
					placement_date: {
						required: "Date required!"	
					}				
				},
				submitHandler: function (form) {					
					document.forms["alterDevicePlacementForm"].submit();
				}				
			});
		});
		<%
		if(request.getParameter("info")!=null){
			String info = request.getParameter("info");
			String infoValue="";
			if(info.equals("dpE1")){
				infoValue= "forbidden symbol in form input!";
			}
			if(info.equals("dpEad1")){
				infoValue= "Error in addign a new device placement";
			}
			
			if(info.equals("dpEal1")){
				infoValue= "Error in altering device placement";
			}
			
			if(info.equals("dpIad1")){
				infoValue= "New device placement added";
			}
			
			if(info.equals("dpIal1")){
				infoValue= "Device placement altered";
			}
			out.print("info('"+infoValue+"');");
		}		
		%>		
	</script>
</body>
</html>