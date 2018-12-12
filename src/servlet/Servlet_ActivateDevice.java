package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao_Device;


@WebServlet("/Servlet_ActivateDevice")
public class Servlet_ActivateDevice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Servlet_ActivateDevice() {
        super();
        System.out.println("Servlet_ActivateDevice.Servlet_activateDevice()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_ActivateDevice.doGet()");
		try {
			int id = Integer.parseInt(request.getParameter("device_id"));
			Dao_Device dao = new Dao_Device();
			if(dao.activateDevice(id)) {
				response.sendRedirect("Servlet_GetDevices");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_ActivateDevice.doPost()");
	}

}
