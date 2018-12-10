package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao_Location;
import helper.DateConverter;
import helper.ValueChecker;
import model.Location;




@WebServlet("/Servlet_AlterLocation")
public class Servlet_AlterLocation extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Servlet_AlterLocation() {
        super();
        System.out.println("Servlet_AlterLocation.Servlet_AlterLocation()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_AlterLocation.doGet()");			
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_AlterLocation.doPost()");
		Location location = new Location();
		Dao_Location dao = new Dao_Location();
		DateConverter dc = new DateConverter();
		ValueChecker vc = new ValueChecker();
		try {
			String name = request.getParameter("name");
			String locationName = request.getParameter("location");
			if(vc.ifValid(locationName)||vc.ifValid(name)) {
				response.sendRedirect("Servlet_GetLocations");
				// and error?
			}
			location.setName(name);
			location.setLocation(locationName);
			location.setDeployment_date(Date.valueOf(dc.dateFormat(request.getParameter("deployment_date"))));
			location.setLocation_id(Integer.parseInt(request.getParameter("location_id")));
			dao.updateLocation(location);
			response.sendRedirect("Servlet_GetLocations");
		}catch (Exception e) {
			System.out.println("error");
		}		
	}
}