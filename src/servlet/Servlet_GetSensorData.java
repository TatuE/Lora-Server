package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao_SensorData;
import helper.ValueChecker;
import model.SensorData;

@WebServlet("/Servlet_GetSensorData")
public class Servlet_GetSensorData extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Servlet_GetSensorData() {
        super();
        System.out.println("Servlet_GetSensorData.Servlet_GetSensorData()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_GetSensorData.doGet()");
		Dao_SensorData dao = new Dao_SensorData();
		ArrayList<SensorData> sensorData;	
		try {
			sensorData = dao.getSensorData();
			String jsp = "/sensorData.jsp";							
			request.setAttribute("sensorData", sensorData);			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(jsp);			
			dispatcher.forward(request, response);			
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_GetSensorData.doPost()");
		Dao_SensorData dao = new Dao_SensorData();
		ValueChecker vc = new ValueChecker();
		ArrayList<SensorData> sensorData;
		
		try {
			String locationName = request.getParameter("locationName");
			String location = request.getParameter("location");
			int status = Integer.parseInt(request.getParameter("status"));
			
			if(vc.ifValid(location)||vc.ifValid(locationName)) {
				response.sendRedirect("sensorData.jsp?info=sdE1");
			}else {
				sensorData = dao.getSensorData(locationName, location, status);
				String jsp = "/sensorData.jsp";							
				request.setAttribute("sensorData", sensorData);			
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(jsp);			
				dispatcher.forward(request, response);				
			}
		}catch (Exception e) {
			e.printStackTrace();
		}		
	}
}
