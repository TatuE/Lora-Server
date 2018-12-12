<%@ include file="header.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Location" %>
<%@ page import="helper.DateConverter" %>
<%! @SuppressWarnings("unchecked") %> 
<%
	if(request.getParameter("info")==null){
		if(request.getAttribute("activatedLocations")==null||request.getAttribute("deactivatedLocations")==null){
			response.sendRedirect("Servlet_GetLocations");
		}
	}
	DateConverter dc = new DateConverter();
%>
	<div class="overlay">
		<div id="blurWrapper">	
			<h1>Location List</h1>
			<br>					
			<div class="btn-group">
				<button type="button" title="Add location" class="btn btn-primary" id="addLocation">
				   	<span class="glyphicon glyphicon-plus"></span> Add location
				</button>					
				<button type="button" class="btn btn-info" id="search">
					<span class="glyphicon glyphicon-search"></span> Search
				</button>
				<button type="button" class="btn btn-success reload" id="reload">
			   		<span class="glyphicon glyphicon-refresh"></span> Reload
				</button>
			</div>		
			<br>
			<h2>Active locations</h2>			
			<div class="scrollOuter">
				<div class="scrollInner generalTD">				
					<table class="table table-bordered table-striped">		
						<%
						if(request.getAttribute("activatedLocations")!=null){
							ArrayList<Location> locationsA = (ArrayList<Location>)request.getAttribute("activatedLocations");
							if(locationsA.size()>0){				
								out.print("<tr>");
								out.print("<th>Locations name</th>");
								out.print("<th>Location</th>");
								out.print("<th>Deployment date</th>");
								out.print("<th>Active since</th>");
								out.print("<th>Status</th>	");
								out.print("<th>Deactivate location</th>");
								out.print("<th>Alter location</th>");
								out.print("<th>Decommission location</th>");
								out.print("</tr>");
								for(int i=0;i<locationsA.size();i++){
									out.print("<tr>");
									out.print("<td>"+locationsA.get(i).getName()+"</td>");
									out.print("<td>"+locationsA.get(i).getLocation()+"</td>");
									out.print("<td>"+dc.dateFormat(locationsA.get(i).getDeployment_date())+"</td>");
									out.print("<td>"+dc.dateFormat(locationsA.get(i).getActivation_date())+"</td>");
									if(locationsA.get(i).getIn_use()==1){
										out.print("<td>Location in use</td>");	
									}else{
										out.print("<td>Location available</td>");
									}
									out.print("<td> <button id='deactivButtonA' title='Deactivate location' class='btn btn-warning' onclick=deactivateLocation("+locationsA.get(i).getLocation_id()+","+locationsA.get(i).getIn_use()+")><span class='glyphicon glyphicon-pause'></span> Deactivate</button></td>");
									out.print("<td> <button id='alterButtonA' title='Alter location' class='btn btn-success' onclick=alterLocation("+locationsA.get(i).getLocation_id()+")><span class='glyphicon glyphicon-wrench'></span> Alter</button></td>");
									out.print("<td> <button id='decomButtonA' title='Decommission location' class='btn btn-danger' onclick=decommissionLocation("+locationsA.get(i).getLocation_id()+","+locationsA.get(i).getIn_use()+")><span class='glyphicon glyphicon-stop'></span> Decomission</button></td>");
									out.print("</tr>");				
								}
							}else{
								if(request.getAttribute("returnValue")!=null){
									String returnValue = (String)request.getAttribute("returnValue");
									
									if(returnValue.equals("get")){
										out.print("<h3>No active locations</h3>");
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
			<div>
				<h2>Inactive locations</h2>
			</div>
			<div class="scrollOuter">
				<div class="scrollInner generalTD">	
					<table class="table table-bordered table-striped">		
						<%
						if(request.getAttribute("deactivatedLocations")!=null){
							ArrayList<Location> locationsD = (ArrayList<Location>)request.getAttribute("deactivatedLocations");
							if(locationsD.size()>0){
								out.print("<tr>");
								out.print("<th>Locations name</th>");
								out.print("<th>Location</th>");
								out.print("<th>Deployment date</th>");
								out.print("<th>Inactive since</th>");
								out.print("<th>Activate location</th>");
								out.print("<th>Alter location</th>");
								out.print("<th>Decommission location</th>");
								out.print("</tr>");			
								for(int i=0;i<locationsD.size();i++){			
									out.print("<tr>");
									out.print("<td>"+locationsD.get(i).getName()+"</td>");
									out.print("<td>"+locationsD.get(i).getLocation()+"</td>");
									out.print("<td>"+dc.dateFormat(locationsD.get(i).getDeployment_date())+"</td>");
									out.print("<td>"+dc.dateFormat(locationsD.get(i).getDeactivation_date())+"</td>");
									out.print("<td> <button id='activButtonD' title='Activate location' class='btn btn-warning' onclick=activateLocation("+locationsD.get(i).getLocation_id()+")><span class='glyphicon glyphicon-play'></span> Activate</button></td>");
									out.print("<td> <button id='alterButtonD' title='Alter location' class='btn btn-success' onclick=alterLocation("+locationsD.get(i).getLocation_id()+")><span class='glyphicon glyphicon-wrench'></span> Alter</button></td>");
									out.print("<td> <button id='decomButtonD' title='Decommission location' class='btn btn-danger' onclick=decommissionLocation("+locationsD.get(i).getLocation_id()+","+locationsD.get(i).getIn_use()+")><span class='glyphicon glyphicon-stop'></span> Decommission</button></td>");
									out.print("</tr>");						
								}
							}else{
								if(request.getAttribute("returnValue")!=null){
									String returnValue = (String)request.getAttribute("returnValue");
									
									if(returnValue.equals("get")){
										out.print("<h3>No inactive locations</h3>");
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
		<h3>Search locations</h3>	
		<br>
		<form action="Servlet_GetLocations" method="post" id="searchForm">
			<div class="form-group">
				<label for="searchName">Location name: </label>
					<input type="text" name="name" id="searchName" placeholder="Enter location name"></input>
			</div>
			<div class="form-group">
				<label for="searchLocation">Location: </label>
					<input type="text" name="location" id="searchLocation" placeholder="Enter location"></input>
			</div>
			<div class="form-group">
				<label for="from"> Deployment date start:</label>
					<input type="text" name="from" class="date" id="from" value="" placeholder="Enter search start date">
			</div>
			<div class="form-group">
				<label for="to"> Deployment date end:</label>
					<input type="text" name="to" class="date" id="to" value="" placeholder="Enter search end date">
			</div>	
			<button type="submit" title="Search" class="btn btn-default" id="searchButton">Search</button>	
		</form>
		<br>
		<button title="cancel" title="Cancel" type="button" class="btn btn-default cancel">Cancel</button>
	</div>
	
	<div id="addWindow" style="display:none">
		<h3>New Location</h3>		
		<br>
		<form action="Servlet_AddLocation" method="post" id="addLocationForm">
			<div class="form-group">
				<label for="addName">Location name: </label>
					<input type="text" name="name" id="addName" placeholder="Enter location name"></input>
			</div>
			<div class="form-group">
				<label for="addLocation">Location: </label>
					<input type="text" name="location" id="addLocation" placeholder="Enter location"></input>
			</div>
			<div class="form-group">				
				<label for="addDeploymentDate">Location deployment date:</label>
					<input type="text" name="deployment_date" class="Date" id="addDeploymentDate" value="" placeholder="Enter deployment date">
			</div>			
			<button type="submit" title="Add a new location" class="btn btn-default"> Add new location</button>	
		</form>
		<br>
		<button title="cancel" title="Cancel" type="button" class="btn btn-default cancel">Cancel</button>	
	</div>
	
	<div id="altWindow" style="display:none">
		<form action="Servlet_AlterLocation" method="post" id="alterLocationForm">
			<div class="form-group">
				<label for="altName">Location name: </label>
					<input type="text" name="name" id="altName" value="" placeholder="Enter location name"></input>
			</div>
			<div class="form-group">
				<label for="altLocation">Location: </label>
					<input type="text" name="location" id="altLocation" value="" placeholder="Enter location"></input>
			</div>
			<div class="form-group">					
				<label for="altDeploymentDate">Location deployment date:</label>
					<input type="text" name="deployment_date" class="Date" id="altDeploymentDate" value="" placeholder="Enter deployment date">
			</div>		
			<input type="hidden" name="location_id" id="altId" value="">
			<button type="submit" title="Alter location" class="btn btn-default">Alter location</button>		
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
		
		function activateLocation(id){			
			window.location.href="Servlet_ActivateLocation?location_id="+id;
		};
		
		function deactivateLocation(id, inUse){
			$("#deleteWindow").css({
				"width": "300px", 
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
			if(inUse==1){
				$("#deleteMessage").text("Location in use!!! Deactivate location?");	
			}else{
				$("#deleteMessage").text("Deactivate location?");
			}			
			$("#deleteWindow").toggle();
			$("#remove").click(function(){
				window.location.href="Servlet_DeactivateLocation?location_id="+id;
			});
		};
		
		function decommissionLocation(id, inUse){
			$("#deleteWindow").css({
				"width": "350px", 
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
			if(inUse==1){
				$("#deleteMessage").text("Location in use!!! Decommission location?");	
			}else{
				$("#deleteMessage").text("Decommission location?");
			}			
			$("#deleteWindow").toggle();
			$("#remove").click(function(){
				window.location.href="Servlet_DecommissionLocation?location_id="+id;
			});			
		};
		
		
		function alterLocation(id){
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
			
			$.getJSON("Servlet_LocationsAjax", function(result){
				$.each(result, function(i, field){
					if(field.location_id==id){
						$("#altName").val(field.name);
						$("#altLocation").val(field.location);
						$("#altDeploymentDate").val(sqlDateParse(field.deployment_date));
						$("#altId").val(field.location_id);
					}	
				});
			});			
			$("#altWindow").toggle();
			blur();
			$("#altName").focus();			
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
				window.location.href="Servlet_GetLocations";
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
				$("#searchName").focus();				
			});
			
			$("#addLocation").click(function(){
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
				$("#addDeploymentDate").val(currentDate());
				$("#addWindow").toggle();
				blur();
				$("#addName").focus();
			});
			
			$("#addLocationForm").validate({
				rules: {
					name: {
						required: true,
						minlength: 1,
						maxlength: 25
					},
					location: {
						required: true,
						minlength: 1,
						maxlength: 25						
					},
					deployment_date: {
						required: true	
					}
				},
				messages: {
					name: {
						required: "Name required!",
						minlength: "Too short!",
						maxlength: "Too long!"
					},
					location: {
						required: "Location required!",
						minlength: "Too short!",
						maxlength: "Too long!"
					},
					deployment_date: {
						required: "Date required!"	
					}				
				},
				submitHandler: function (form) {					
					document.forms["addLocationForm"].submit();
				}				
			});
			
			$("#alterLocationForm").validate({				
				rules: {
					name: {
						required: true,
						minlength: 1,
						maxlength: 25
					},
					location: {
						required: true,
						minlength: 1,
						maxlength: 25						
					},
					deployment_date: {
						required: true	
					}
				},
				messages: {
					name: {
						required: "Name required!",
						minlength: "Too short!",
						maxlength: "Too long!"
					},
					location: {
						required: "Location required!",
						minlength: "Too short!",
						maxlength: "Too long!"
					},
					deployment_date: {
						required: "Date required!"	
					}				
				},
				submitHandler: function (form) {					
					document.forms["alterLocationForm"].submit();
				}				
			});			
		});
		<%
		if(request.getParameter("info")!=null){
			String info = request.getParameter("info");
			String infoValue="";
			if(info.equals("lE1")){
				infoValue= "forbidden symbol in form input!";
			}
			if(info.equals("lEad1")){
				infoValue= "Error in addign a new location";
			}
			
			if(info.equals("lEal1")){
				infoValue= "Error in altering location";
			}
			
			if(info.equals("lIad1")){
				infoValue= "New location added";
			}
			
			if(info.equals("lIal1")){
				infoValue= "Location altered";
			}
			if(infoValue!=""){
				out.print("info('"+infoValue+"');");
			}
		}		
		%>
	</script>
</body>
</html>