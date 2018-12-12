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


@WebServlet("/Servlet_AlterDevicePlacement")
public class Servlet_AlterDevicePlacement extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Servlet_AlterDevicePlacement() {
        super();
        System.out.println("Servlet_AlterDevicePlacement.Servlet_AlterDevicePlacement()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_AlterDevicePlacement.doGet()");				
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_AlterDevicePlacement.doPost()");
		DevicePlacement devicePlacement = new DevicePlacement();
		Dao_DevicePlacement dao = new Dao_DevicePlacement();
		DateConverter dc = new DateConverter();
		
		try {
			devicePlacement.setDevice_id(Integer.parseInt(request.getParameter("device")));			
			devicePlacement.setLocation_id(Integer.parseInt(request.getParameter("location")));			
			devicePlacement.setPlacement_date(Date.valueOf(dc.dateFormat(request.getParameter("placement_date"))));			
			devicePlacement.setDevice_placement_id(Integer.parseInt(request.getParameter("device_placement_id")));			
			dao.updateDevicePlacement(devicePlacement);
			response.sendRedirect("devicePlacementList.jsp?info=dpIal1");
		}catch (Exception e) {
			response.sendRedirect("devicePlacementList.jsp?info=dpEal1");
		}
	}

}
