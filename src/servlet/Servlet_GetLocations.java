package servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

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


@WebServlet("/Servlet_GetLocations")
public class Servlet_GetLocations extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public Servlet_GetLocations() {
        super();
        System.out.println("Servlet_GetLocations.Servlet_GetLocations()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_GetLocations.doGet()");
		Dao_Location dao = new Dao_Location();
		ArrayList<Location> activatedLocations = new ArrayList<>();
		ArrayList<Location> deactivatedLocations = new ArrayList<>();
		try {
			ArrayList<Location> locations = dao.getLocations();
			for(int i=0;i<locations.size();i++) {
				if(locations.get(i).getActivation_date()==null) {
					deactivatedLocations.add(locations.get(i));
				}else if(locations.get(i).getDeactivation_date()==null) {
					activatedLocations.add(locations.get(i));
				}
			}
			String returnValue="get";
			request.setAttribute("returnValue", returnValue);
			request.setAttribute("activatedLocations", activatedLocations);
			request.setAttribute("deactivatedLocations", deactivatedLocations);
			String jsp = "/locationList.jsp";
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(jsp);
			dispatcher.forward(request, response);			
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_GetLocations.doPost()");
		Dao_Location dao = new Dao_Location();
		DateConverter dc = new DateConverter();
		ValueChecker vc = new ValueChecker();
		ArrayList<Location> activatedLocations = new ArrayList<>();
		ArrayList<Location> deactivatedLocations = new ArrayList<>();
		
		try {
			String name = request.getParameter("name");
			String location = request.getParameter("location");
			Date from;
			Date to;
			String sFrom = dc.dateFormat(request.getParameter("from"));
			String sTo = dc.dateFormat(request.getParameter("to"));
			
			if(vc.ifValid(name)||vc.ifValid(location)) {
				response.sendRedirect("locationList.jsp?info=lE1");
			}else {			
				if(sFrom.equals("")) {
					from=null;
				}else {
					from = Date.valueOf(sFrom);
				}
				
				if(sTo.equals("")) {
					to=null;
				}else {
					to=Date.valueOf(sTo);
				}			
				ArrayList<Location> locations =	dao.getLocations(name, location, from, to);
				for(int i=0;i<locations.size();i++) {
					if(locations.get(i).getActivation_date()==null) {
						deactivatedLocations.add(locations.get(i));
					}else if(locations.get(i).getDeactivation_date()==null) {
						activatedLocations.add(locations.get(i));
					}
				}
				String returnValue="search";
				request.setAttribute("returnValue", returnValue);
				request.setAttribute("activatedLocations", activatedLocations);
				request.setAttribute("deactivatedLocations", deactivatedLocations);
				String jps = "/locationList.jsp";
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(jps);
				dispatcher.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}	
}