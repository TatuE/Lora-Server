<%@ include file="header.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Device" %>
<%@ page import="helper.DateConverter" %> 
<%! @SuppressWarnings("unchecked") %> 
<%
	if(request.getParameter("info")==null){
		if(request.getAttribute("activatedDevices")==null||request.getAttribute("deactivatedDevices")==null){
			response.sendRedirect("Servlet_GetDevices");
		}
	}
	DateConverter dc = new DateConverter();	
%>
	<div class="overlay">
		<div id="blurWrapper">										
			<h1>Device List</h1>
			<br>					
			<div class="btn-group">
				<button type="button" title="Add device" class="btn btn-primary" id="addDevice">
			    	<span class="glyphicon glyphicon-plus"></span> Add device
			  	</button>					
				<button type="button" class="btn btn-info" id="search">
			   		<span class="glyphicon glyphicon-search"></span> Search
				</button>
				<button type="button" class="btn btn-success reload" id="reload">
			   		<span class="glyphicon glyphicon-refresh"></span> Reload
				</button>
			</div>
			<br>
			<h2>Active devices</h2>			
				<div class="scrollOuter">
					<div class="scrollInner generalTD">	
						<table class="table table-bordered table-striped">			
							<%
							if(request.getAttribute("activatedDevices")!=null){
								ArrayList<Device> devicesA = (ArrayList<Device>)request.getAttribute("activatedDevices");
								if(devicesA.size()>0){					
									out.print("<tr>");
									out.print("<th>Device UID</th>");
									out.print("<th>Deployment date</th>");
									out.print("<th>Active since</th>");
									out.print("<th>Status</th>");
									out.print("<th>Deactivate device</th>");
									out.print("<th>Alter device</th>");
									out.print("<th>Decommission device</th>");
									out.print("</tr>");					
									for(int i=0;i<devicesA.size();i++){
										out.print("<tr>");
										out.print("<td>"+devicesA.get(i).getUid()+"</td>");
										out.print("<td>"+dc.dateFormat(devicesA.get(i).getDeployment_date())+"</td>");
										out.print("<td>"+dc.dateFormat(devicesA.get(i).getActivation_date())+"</td>");
										if(devicesA.get(i).getIn_use()==1){
											out.print("<td>Device in use</td>");
										}else{
											out.print("<td>Device available</td>");
										}
										out.print("<td> <button id='deactivButtonA' title='Deactivate device' class='btn btn-warning' onclick=deactivateDevice("+devicesA.get(i).getDevice_id()+","+devicesA.get(i).getIn_use()+")><span class='glyphicon glyphicon-pause'></span> Deactivate</button></td>");
										out.print("<td> <button id='alterButtonA' title='Alter device' class='btn btn-success' onclick=alterDevice("+devicesA.get(i).getDevice_id()+")><span class='glyphicon glyphicon-wrench'></span> Alter</button></td>");
										out.print("<td> <button id='decomButtonA' title='Decomission device' class='btn btn-danger' onclick=decommissionDevice("+devicesA.get(i).getDevice_id()+","+devicesA.get(i).getIn_use()+")><span class='glyphicon glyphicon-stop'></span> Decommission</button></td>");
										out.print("</tr>");				
									}
								}else{
									if(request.getAttribute("returnValue")!=null){
										String returnValue = (String)request.getAttribute("returnValue");
										
										if(returnValue.equals("get")){
											out.print("<h3>No active devices</h3>");
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
				<h2>Inactive devices</h2>
				<br>
				<div class="scrollOuter">
					<div class="scrollInner generalTD">	
						<table class="table table-bordered table-striped">		
							<%
							if(request.getAttribute("deactivatedDevices")!=null){
								ArrayList<Device> devicesD = (ArrayList<Device>)request.getAttribute("deactivatedDevices");
								if(devicesD.size()>0){				
									out.print("<tr>");
									out.print("<th>Device UID</th>");
									out.print("<th>Deployment date</th>");
									out.print("<th>Inactive since</th>");
									out.print("<th>Reactivate device</th>");
									out.print("<th>Alter device</th>");
									out.print("<th>Decommission device</th>");
									out.print("</tr>");	
									for(int i=0;i<devicesD.size();i++){			
										out.print("<tr>");
										out.print("<td>"+devicesD.get(i).getUid()+"</td>");
										out.print("<td>"+dc.dateFormat(devicesD.get(i).getDeployment_date())+"</td>");
										out.print("<td>"+dc.dateFormat(devicesD.get(i).getDeactivation_date())+"</td>");
										out.print("<td> <button id='activButtonD' title='Activate device' class='btn btn-warning' onclick=activateDevice("+devicesD.get(i).getDevice_id()+")><span class='glyphicon glyphicon-play'></span> Activate</button></td>");
										out.print("<td> <button id='alterButtonD' title='Alter device' class='btn btn-success' onclick=alterDevice("+devicesD.get(i).getDevice_id()+")><span class='glyphicon glyphicon-wrench'></span> Alter</button></td>");
										out.print("<td> <button id='decomButtonD' title='Decomission device' class='btn btn-danger' onclick=decommissionDevice("+devicesD.get(i).getDevice_id()+","+devicesD.get(i).getIn_use()+")><span class='glyphicon glyphicon-stop'></span> Decommission</button></td>");
										out.print("</tr>");					
									}
								}else{
									if(request.getAttribute("returnValue")!=null){
										String returnValue = (String)request.getAttribute("returnValue");
										
										if(returnValue.equals("get")){
											out.print("<h3>No inactive devices</h3>");
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
		<h3>Search devices</h3>
		<br>		
		<form action="Servlet_GetDevices" method="post" id="searchForm">
			<div class="form-group">
				<label for="searchUid">Device UID: </label>
					<input type="text" name="uid" id="searchUid" placeholder="Enter device UID"></input>
			</div>
			<div class="form-group">
				<label for="from"> Deployment date start:</label>
					<input type="text" name="from" class="date" id="from" value="" placeholder="Enter search start date">
			</div>
			<div class="form-group">
				<label for="to"> Deployment date end:</label>
					<input type="text" name="to" class="date" id="to" value="" placeholder="Enter search end date">
			</div>		
			<button type="submit" value="Search" title="Search" class="btn btn-default">Search</button>		
		</form>
		<br>	
		<button title="cancel" title="Cancel" type="button" class="btn btn-default cancel">Cancel</button>	
	</div>
		
	<div id="addWindow" style="display:none">
		<h3>New device</h3>		
		<br>	
		<form action="Servlet_AddDevice" method="post" id="addDeviceForm">
			<div class="form-group">
				<label for="addUid">Device UID: </label>
					<input type="text" name="uid" id="addUid" placeholder="Enter device UID"></input>
			</div>
			<div class="form-group">	
				<label for="addDeploymentDate"> Device deployment date:</label>
					<input type="text" name="deployment_date" id="addDeploymentDate" class="date" value="" placeholder="Enter deployment date">
			</div>	
			<button type="submit" title="Add a new device" id="submit" class="btn btn-default">Add new device</button>	
		</form>
		<br>
		<button title="cancel" title="Cancel" type="button" class="btn btn-default cancel">Cancel</button>			
	</div>	
		
	<div id="altWindow" style="display:none">
		<h3>Alter device</h3>
		<br>
		<form action="Servlet_AlterDevice" method="post" id="alterDeviceForm">				
			<div class="form-group">
				<label for="altUid">Device UID: </label>
					<input type="text" name="uid" id="altUid" value="" placeholder="Enter device UID"></input>
			</div>
			<div>
				<label for="altDeploymentDate"> Device deployment date:</label>
					<input type="text" name="deployment_date" id="altDeploymentDate" class="date" value="" placeholder="Enter deployment date">
			</div>			
			<input type="hidden" name="device_id" id="altId" value=""><br>
			<button type="submit" value="Alter device" id="submit" class="btn btn-default">Alter device</button>	
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
		
		function activateDevice(id){			
			window.location.href="Servlet_ActivateDevice?device_id="+id;
		};
		
		function deactivateDevice(id, inUse){
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
				$("#deleteMessage").text("Device in use!!! Deactivate device?");	
			}else{
				$("#deleteMessage").text("Deactivate device?");
			}			
			$("#deleteWindow").toggle();
			$("#remove").click(function(){
				window.location.href="Servlet_DeactivateDevice?device_id="+id;
			});
		};
		
		function decommissionDevice(id, inUse){
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
				$("#deleteMessage").text("Device in use!!! Decommission device?");	
			}else{
				$("#deleteMessage").text("Decommission device?");
			}			
			$("#deleteWindow").toggle();
			$("#remove").click(function(){
				window.location.href="Servlet_DecommissionDevice?device_id="+id;
			});
		};
		
		function alterDevice(id){
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
			
			$.getJSON("Servlet_DevicesAjax", function(result){
				$.each(result, function(i, field){
					if(field.device_id==id){
						$("#altUid").val(field.uid);
						$("#altDeploymentDate").val(sqlDateParse(field.deployment_date));
						$("#altId").val(field.device_id);
					}	
				});
			});			
			$("#altWindow").toggle();
			blur();
			$("#altUid").focus();			
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
				window.location.href="Servlet_GetDevices";
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
				$("#searchUid").focus();
				
			});
			
			$("#addDevice").click(function(){
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
				$("#addUid").focus();
			});
			
			$("#submit").click(function(){				
				var str = $("#altUid").val();
				var str = valueChecker($("#altUid").val());
				$("#altUid").val(str);				
			});
			
			$("#addDeviceForm").validate({
				rules: {
					uid: {
						required: true,
						minlength: 1,
						maxlength: 10
					},
					deployment_date: {
						required: true	
					}
				},
				messages: {
					uid: {
						required: "Uid required!",
						minlength: "Too short!",
						maxlength: "Too long!"
					},
					deployment_date: {
						required: "Date required!"	
					}				
				},
				submitHandler: function (form) {					
					document.forms["addDeviceForm"].submit();
				}				
			});
			
			$("#alterDeviceForm").validate({				
				rules: {
					uid: {
						required: true,
						minlength: 1,
						maxlength: 10
					},
					deployment_date: {
						required: true	
					}
				},
				messages: {
					uid: {
						required: "Uid required!",
						minlength: "Too short!",
						maxlength: "Too long!"
					},
					deployment_date: {
						required: "Date required!"	
					}				
				},
				submitHandler: function (form) {					
					document.forms["alterDeviceForm"].submit();
				}				
			});			
		});
		<%
		if(request.getParameter("info")!=null){
			String info = request.getParameter("info");
			String infoValue="";
			if(info.equals("dE1")){
				infoValue= "forbidden symbol in form input!";
			}
			if(info.equals("dEad1")){
				infoValue= "Error in addign a new device";
			}
			
			if(info.equals("dEal1")){
				infoValue= "Error in altering device";
			}
			
			if(info.equals("dIad1")){
				infoValue= "New device added";
			}
			
			if(info.equals("dIal1")){
				infoValue= "Device altered";
			}
			if(infoValue!=""){
				out.print("info('"+infoValue+"');");
			}
		}		
		%>
	</script>
</body>
</html>