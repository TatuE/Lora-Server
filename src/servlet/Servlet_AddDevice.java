package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao_Device;
import helper.DateConverter;
import helper.ValueChecker;
import model.Device;

@WebServlet("/Servlet_AddDevice")
public class Servlet_AddDevice extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Servlet_AddDevice() {
        super();
        System.out.println("Servlet_AddDevice.Servlet_AddNewDevice()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_AddDevice.doGet()");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_AddDevice.doPost()");
		Device device = new Device();
		Dao_Device dao = new Dao_Device();
		DateConverter dc = new DateConverter();
		ValueChecker vc = new ValueChecker();
		
		try {
			String uid = request.getParameter("uid");
			if(vc.ifValid(uid)) {				
				response.sendRedirect("deviceList.jsp?info=dE1");				
			}else {
				device.setUid(request.getParameter("uid"));		
				device.setDeployment_date(Date.valueOf(dc.dateFormat(request.getParameter("deployment_date"))));		
				dao.newDevice(device);		
				response.sendRedirect("deviceList.jsp?info=dIad1");	
			}
		}catch (Exception e) {
			response.sendRedirect("deviceList.jsp?info=dEad1");	
		}
	}
}