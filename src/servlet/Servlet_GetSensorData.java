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
		String jsp;
		try {
			if(request.getParameter("device_placement_id")!=null) {
				int id = Integer.parseInt(request.getParameter("device_placement_id"));
				sensorData = dao.getSensorData(id);
				jsp = "/locationSensorData.jsp";
			}else {
				sensorData = dao.getSensorData();
				jsp = "/sensorData.jsp";
			}				
			request.setAttribute("sensorData", sensorData);			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(jsp);			
			dispatcher.forward(request, response);			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_GetSensorData.doPost()");
	}

}
