package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao_Device;
import dao.Dao_DevicePlacement;
import dao.Dao_Location;


@WebServlet("/Servlet_DeactivateDevicePlacement")
public class Servlet_DeactivateDevicePlacement extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public Servlet_DeactivateDevicePlacement() {
        super();
        System.out.println("Servlet_DeactivateDevicePlacement.Servlet_DeactivateDevicePlacement()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_DeactivateDevicePlacement.doGet()");
		Dao_DevicePlacement daoDp = new Dao_DevicePlacement();
		Dao_Device daoD = new Dao_Device();
		Dao_Location daoL = new Dao_Location();
		
		try {
			int device_placement_id = Integer.parseInt(request.getParameter("device_placement_id"));
			int device_id = Integer.parseInt(request.getParameter("device_id"));
			int location_id = Integer.parseInt(request.getParameter("location_id"));
			if(daoDp.setInUseFalse(device_placement_id)&&daoD.setInUse(device_id, 0)&&daoL.setInUse(location_id, 0)) {
				response.sendRedirect("Servlet_GetDevicePlacements");
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}				
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_DeactivateDevicePlacement.doPost()");
	}

}
