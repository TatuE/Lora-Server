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
import model.DevicePlacement;


@WebServlet("/Servlet_DeactivateLocation")
public class Servlet_DeactivateLocation extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Servlet_DeactivateLocation() {
        super();
        System.out.println("Servlet_DeactivateLocation.Servlet_DeactivateLocation()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_DeactivateLocation.doGet()");
		int id = Integer.parseInt(request.getParameter("location_id"));
		Dao_DevicePlacement daoDp = new Dao_DevicePlacement();
		Dao_Device daoD = new Dao_Device();
		Dao_Location daoL = new Dao_Location();
		
		try {
			DevicePlacement devicePlacement = daoDp.getDevicePlacement("location_id", id);
			
			if(devicePlacement.getLocation_id()==id) {
				if(daoDp.setInUseFalse(devicePlacement.getDevice_placement_id())&&daoL.deactivateLocation(id)&&daoD.setInUse(devicePlacement.getDevice_id(), 0)) {
					response.sendRedirect("Servlet_GetLocations");
				}else {
					System.out.println("error");
				}			
			}else if(daoL.deactivateLocation(id)) {
				response.sendRedirect("Servlet_GetLocations");
			}else {
				System.out.println("error");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_DeactivateLocation.doPost()");
	}

}
