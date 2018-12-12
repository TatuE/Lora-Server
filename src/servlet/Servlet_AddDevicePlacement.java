package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao_DevicePlacement;
import helper.DateConverter;
import model.DevicePlacement;


@WebServlet("/Servlet_AddDevicePlacement")
public class Servlet_AddDevicePlacement extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public Servlet_AddDevicePlacement() {
    	super();
    	System.out.println("Servlet_AddDevicePlacement.Servlet_AddDevicePlacement()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_AddDevicePlacement.doGet()");	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_AddDevicePlacement.doPost()");
		DevicePlacement devicePlacement = new DevicePlacement();
		Dao_DevicePlacement dao = new Dao_DevicePlacement();
		DateConverter dc = new DateConverter();
		
		try {			
			devicePlacement.setLocation_id(Integer.parseInt(request.getParameter("location")));
			devicePlacement.setDevice_id(Integer.parseInt(request.getParameter("device")));
			devicePlacement.setPlacement_date(Date.valueOf(dc.dateFormat(request.getParameter("placement_date"))));		
			dao.newDevicePlacement(devicePlacement);
			response.sendRedirect("devicePlacementList.jsp?info=dpIad1");	
		}catch (Exception e) {
			response.sendRedirect("devicePlacementList.jsp?info=dpEad1");
		}		
	}
}