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

@WebServlet("/Servlet_DecommissionDevice")
public class Servlet_DecommissionDevice extends HttpServlet {
	private static final long serialVersionUID = 1L;       

    public Servlet_DecommissionDevice() {
        super();
        System.out.println("Servlet_DecommissionDevice.Servlet_DecommissionDevice()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_DecommissionDevice.doGet()");
		int id = Integer.parseInt(request.getParameter("device_id"));
		Dao_DevicePlacement daoDp = new Dao_DevicePlacement();
		Dao_Device daoD = new Dao_Device();
		Dao_Location daoL = new Dao_Location();
		
		DevicePlacement devicePlacement = daoDp.getDevicePlacement("device_id", id);
		
		if(devicePlacement.getDevice_id()==id) {
			if(daoDp.setInUseFalse(devicePlacement.getDevice_placement_id())&&daoD.decommissionDevice(id)&&daoL.setInUse(devicePlacement.getLocation_id(), 0)) {
				response.sendRedirect("Servlet_GetDevices");
			}else {
				System.out.println("error");
			}			
		}else if(daoD.decommissionDevice(id)) {
			response.sendRedirect("Servlet_GetDevices");
		}else {
			System.out.println("error");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_DecommissionDevice.doPost()");		
	}
}