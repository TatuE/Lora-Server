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


@WebServlet("/Servlet_DeactivateDevice")
public class Servlet_DeactivateDevice extends HttpServlet {
	private static final long serialVersionUID = 1L;       
    
    public Servlet_DeactivateDevice() {
        super();
        System.out.println("Servlet_DeactivateDevice.Servlet_deactivateDevice()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_DeactivateDevice.doGet()");
		int id = Integer.parseInt(request.getParameter("device_id"));
		Dao_DevicePlacement daoDp = new Dao_DevicePlacement();
		Dao_Device daoD = new Dao_Device();
		Dao_Location daoL = new Dao_Location();
		
		try {		
			DevicePlacement devicePlacement = daoDp.getDevicePlacement("device_id", id);
			
			if(devicePlacement.getDevice_id()==id) {
				if(daoDp.setInUseFalse(devicePlacement.getDevice_placement_id())&&daoD.deactivateDevice(id)&&daoL.setInUse(devicePlacement.getLocation_id(), 0)) {
					response.sendRedirect("Servlet_GetDevices");
				}else {
					System.out.println("error");
				}			
			}else if(daoD.deactivateDevice(id)) {
				response.sendRedirect("Servlet_GetDevices");
			}else {
				System.out.println("error");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_DeactivateDevice.doPost()");
	}

}
