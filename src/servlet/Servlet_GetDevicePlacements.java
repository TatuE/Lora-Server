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

import dao.Dao_DevicePlacement;
import helper.DateConverter;
import helper.ValueChecker;
import model.DevicePlacement;


@WebServlet("/Servlet_GetDevicePlacements")
public class Servlet_GetDevicePlacements extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public Servlet_GetDevicePlacements() {
        super();
        System.out.println("Servlet_GetDevicePlacements.Servlet_GetDevicePlacements()");
        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_GetDevicePlacements.doGet()");
		Dao_DevicePlacement dao = new Dao_DevicePlacement();		
		try {
			ArrayList<DevicePlacement> devicePlacements = dao.getDevicePlacements();
			String returnValue="get";
			request.setAttribute("returnValue", returnValue);
			request.setAttribute("devicePlacements", devicePlacements);
			String jsp = "/devicePlacementList.jsp";
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(jsp);
			dispatcher.forward(request, response);			
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_GetDevicePlacements.doPost()");
		Dao_DevicePlacement dao = new Dao_DevicePlacement();
		DateConverter dc = new DateConverter();
		ValueChecker vc = new ValueChecker();
		try {
			String locationName = request.getParameter("locationName");
			String location = request.getParameter("location");
			String uid = request.getParameter("uid");
			Date from;
			Date to;
			String sFrom = dc.dateFormat(request.getParameter("from"));
			String sTo = dc.dateFormat(request.getParameter("to"));
			
			if(vc.ifValid(locationName)||vc.ifValid(location)||vc.ifValid(uid)) {
				response.sendRedirect("devicePlacementList.jsp?info=dpE1");
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
				
				ArrayList<DevicePlacement> devicePlacements = dao.getDevicePlacements(locationName, location, uid, from, to);
				String returnValue="search";
				request.setAttribute("returnValue", returnValue);
				request.setAttribute("devicePlacements", devicePlacements);
				String jsp = "/devicePlacementList.jsp";
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(jsp);
				dispatcher.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
}