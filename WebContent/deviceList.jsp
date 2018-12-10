<%@ include file="header.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Device" %>
<%@ page import="helper.DateConverter" %> 
<%! @SuppressWarnings("unchecked") %> 
<%	
	DateConverter dc = new DateConverter();	
%>
	<div id="overlay">
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
				<button type="button" class="btn btn-success" id="reload">
			   		<span class="glyphicon glyphicon-refresh"></span> Reload
				</button>
			</div>
			<br>
			<h2>Active devices</h2>			
			<div>	
				<table class="table table-bordered">			
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
								out.print("<td> <button id='deactivButtonA' title='Deactivate device' class='btn btn-warning' onclick=deactivateDevice("+devicesA.get(i).getDevice_id()+")><span class='glyphicon glyphicon-pause'></span> Deactivate</button></td>");
								out.print("<td> <button id='alterButtonA' title='Alter device' class='btn btn-success' onclick=alterDevice("+devicesA.get(i).getDevice_id()+")><span class='glyphicon glyphicon-wrench'></span> Alter</button></td>");
								out.print("<td> <button id='decomButtonA' title='Decomission device' class='btn btn-danger' onclick=decommissionDevice("+devicesA.get(i).getDevice_id()+")><span class='glyphicon glyphicon-cross'></span> Decommission</button></td>");
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
				<h2>Inactive devices</h2>
				<br>
				<div>
				<table class="table table-bordered">		
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
								out.print("<td> <button id='decomButtonD' title='Decomission device' class='btn btn-danger' onclick=decommissionDevice("+devicesD.get(i).getDevice_id()+")><span class='glyphicon glyphicon-cross'></span> Decommission</button></td>");
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
	<div id="searchWindow" style="display:none">
		<h3>Search devices</h3>
		<br>
		<form action="Servlet_GetDevices" method="post" id="searchForm">
			<label>Device UID: </label>
				<input type="text" name="uid" id="searchUid"></input><br>		
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
		<h3>New device</h3>		
		<br>	
		<form action="Servlet_AddDevice" method="post" id="addDeviceForm">
			<label>Device UID: </label>
				<input type="text" name="uid" id="addUid"></input><br>		
			<label> Device deployment date:</label>
				<input type="text" name="deployment_date" id="addDeploymentDate" class="date" value=""><br><br>		
			<label> </label>
				<input type="submit" value="Add a new device" id="submit">		
		</form>
		<br>
		<button title="cancel" title="Cancel" type="button" class="btn btn-default cancel">Cancel</button>			
	</div>	
		
	<div id="altWindow" style="display:none">
		<h3>Alter device</h3>
		<br>
		<form action="Servlet_AlterDevice" method="post" id="alterDeviceForm">				
			<label>Device UID: </label>
				<input type="text" name="uid" id="altUid" value=""></input><br>		
			<label> Device deployment date:</label>
				<input type="text" name="deployment_date" id="altDeploymentDate" class="date" value=""><br><br>	
			<label> </label>
				<input type="hidden" name="device_id" id="altId" value="">
				<input type="submit" value="Alter device" id="submit">		
		</form>
		<br>
		<button title="cancel" title="Cancel" type="button" class="btn btn-default cancel">Cancel</button>		
	</div>
	<div id="infoWindow" style="display:none">
		<br>
		<h3 id="infoMessage"></h3>
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
		
		function activateDevice(id){			
			window.location.href="Servlet_ActivateDevice?device_id="+id;
		};
		
		function deactivateDevice(id){
			window.location.href="Servlet_DeactivateDevice?device_id="+id;
		};
		
		function decommissionDevice(id){
			window.location.href="Servlet_DecommissionDevice?device_id="+id;
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
				"top": "35%",	
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
		
		function info(id){
			if(id=="dE1"){
				alert("toimii");	
			}			
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
				
				$("#blurWrapper").css({
					"filter": "",
					"-webkit-filter": "",
					"pointer-events": ""
				});				
			});
			
			$("#reload").click(function(){
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
					"top": "35%",
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
					"top": "35%",
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
			String infoValue = request.getParameter("info");
			out.print("info("+infoValue+");");
		}		
		%>
	</script>
</body>
</html>