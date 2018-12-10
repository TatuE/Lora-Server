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


@WebServlet("/Servlet_AlterDevice")
public class Servlet_AlterDevice extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Servlet_AlterDevice() {
        super();
        System.out.println("Servlet_AlterDevice.Servlet_AlterDevice()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_AlterDevice.doGet()");	
			
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_AlterDevice.doPost()");		
		Device device = new Device();
		Dao_Device dao = new Dao_Device();	
		DateConverter dc = new DateConverter();
		ValueChecker vc = new ValueChecker();
		
		try {
		String uid = request.getParameter("uid");	
		if(vc.ifValid(uid)) {
			response.sendRedirect("Servlet_GetDevices");
			// and error?
		}
		device.setUid(uid);		
		device.setDeployment_date(Date.valueOf(dc.dateFormat(request.getParameter("deployment_date"))));
		device.setDevice_id(Integer.parseInt(request.getParameter("device_id")));
		dao.updateDevice(device);
		response.sendRedirect("Servlet_GetDevices");
		}catch (Exception e) {
			System.out.println("error");
		}	
	}
}