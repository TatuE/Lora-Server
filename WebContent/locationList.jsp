<%@ include file="header.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Location" %>
<%@ page import="helper.DateConverter" %>
<%! @SuppressWarnings("unchecked") %> 
<%
	DateConverter dc = new DateConverter();
%>
	<div id="overlay">
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
				<button type="button" class="btn btn-success" id="reload">
			   		<span class="glyphicon glyphicon-refresh"></span> Reload
				</button>
			</div>		
			<br>
			<h2>Active locations</h2>			
			<div>	
				<table class="table table-bordered">		
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
								out.print("<td> <button id='deactivButtonA' title='Deactivate location' class='btn btn-warning' onclick=deactivateLocation("+locationsA.get(i).getLocation_id()+")><span class='glyphicon glyphicon-pause'></span> Deactivate</button></td>");
								out.print("<td> <button id='alterButtonA' title='Alter location' class='btn btn-success' onclick=alterLocation("+locationsA.get(i).getLocation_id()+")><span class='glyphicon glyphicon-wrench'></span> Alter</button></td>");
								out.print("<td> <button id='decomButtonA' title='Decommission location' class='btn btn-danger' onclick=decommissionLocation("+locationsA.get(i).getLocation_id()+")><span class='glyphicon glyphicon-play'></span> Decomission</button></td>");
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
			<div>
				<div>
					<h2>Inactive locations</h2>
				</div>
				<table class="table table-bordered">		
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
								out.print("<td> <button id='decomButtonD' title='Decommission location' class='btn btn-danger' onclick=decommissionLocation("+locationsD.get(i).getLocation_id()+")><span class='glyphicon glyphicon-wrench'></span> Decommission</button></td>");
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
	<div id="searchWindow" style="display:none">
		<h3>Search locations</h3>	
		<br>
		<form action="Servlet_GetLocations" method="post" id="searchForm">
			<label>Location name: </label>
				<input type="text" name="name" id="searchName"></input><br>
			<label>Location: </label>
				<input type="text" name="location" id="searchLocation"></input><br>			
			<label> Deployment date start:</label>
				<input type="text" name="from" class="date" value=""><br>
			<label> Deployment date end:</label>
				<input type="text" name="to" class="date" value=""><br><br>
			<label> </label>
				<input type="submit" value="Search">		
		</form>
		<br>
		<button title="cancel" title="Cancel" type="button" class="btn btn-default cancel">Cancel</button>
	</div>
	<div id="addWindow" style="display:none">
		<h3>New Location</h3>		
		<br>
		<form action="Servlet_AddLocation" method="post" id="addLocationForm">
			<label>Location name: </label>
				<input type="text" name="name" id="addName"></input><br>
			<label>Location: </label>
				<input type="text" name="location" id="addLocation"></input><br>				
			<label>Location deployment date:</label>
				<input type="text" name="deployment_date" class="Date" id="addDeploymentDate" value=""><br><br>	
			<label> </label>
				<input type="submit" value="Add a new location">		
		</form>
		<br>
		<button title="cancel" title="Cancel" type="button" class="btn btn-default cancel">Cancel</button>	
	</div>
	<div id="altWindow" style="display:none">
		<form action="Servlet_AlterLocation" method="post" id="alterLocationForm">	
			<label>Location name: </label>
				<input type="text" name="name" id="altName" value=""></input><br>
			<label>Location: </label>
				<input type="text" name="location" id="altLocation" value=""></input><br>				
			<label>Location deployment date:</label>
				<input type="text" name="deployment_date" class="Date" id="altDeploymentDate" value=""><br><br>	
			<label> </label>
				<input type="hidden" name="location_id" id="altId" value="">
				<input type="submit" value="Alter location">		
		</form>
		<br>
		<button title="cancel" title="Cancel" type="button" class="btn btn-default cancel">Cancel</button>	
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
		
		function valueChecker(value){
			var str = value;
			var falseValues = ["<",">","'"];
			for (i=0;i<falseValues.length;i++){
				if(str.includes(falseValues[i])){
					str="";
				}
			}
			return str;
		}
		
		function activateLocation(id){			
			window.location.href="Servlet_ActivateLocation?location_id="+id;
		};
		
		function deactivateLocation(id){
			window.location.href="Servlet_DeactivateLocation?location_id="+id;
		};
		
		function decommissionLocation(id){
			window.location.href="Servlet_DecommissionLocation?location_id="+id;
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
				"top": "35%",	
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
				
				$("#blurWrapper").css({
					"filter": "",
					"-webkit-filter": "",
					"pointer-events": ""
				});	
			});
			
			$("#reload").click(function(){
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
					"top": "35%",
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
					"top": "35%",
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
	</script>
</body>
</html>