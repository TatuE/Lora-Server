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

import dao.Dao_Device;
import helper.DateConverter;
import helper.ValueChecker;
import model.Device;

@WebServlet("/Servlet_GetDevices")
public class Servlet_GetDevices extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public Servlet_GetDevices() {
        super();
        System.out.println("Servlet_GetDevices.Servlet_GetDevices()");

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_GetDevices.doGet()");
		Dao_Device dao = new Dao_Device();
		ArrayList<Device> activatedDevices = new ArrayList<>();
		ArrayList<Device> deactivatedDevices = new ArrayList<>();
		try {
			ArrayList<Device> devices = dao.getDevices();
			for(int i=0;i<devices.size();i++) {
				if(devices.get(i).getActivation_date()==null) {
					deactivatedDevices.add(devices.get(i));					
				}else if(devices.get(i).getDeactivation_date()==null) {
					activatedDevices.add(devices.get(i));
				}
			}
			String returnValue="get";
			request.setAttribute("returnValue", returnValue);
			request.setAttribute("activatedDevices", activatedDevices);
			request.setAttribute("deactivatedDevices", deactivatedDevices);
			String jsp = "/deviceList.jsp";
			RequestDispatcher dispacher = getServletContext().getRequestDispatcher(jsp);
			dispacher.forward(request, response);			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_GetDevices.doPost()");
		Dao_Device dao = new Dao_Device();
		DateConverter dc = new DateConverter();
		ValueChecker vc = new ValueChecker();
		ArrayList<Device> devices = new ArrayList<>();
		ArrayList<Device> activatedDevices = new ArrayList<>();
		ArrayList<Device> deactivatedDevices = new ArrayList<>();
		try {
			String uid = request.getParameter("uid");
			Date from;
			Date to;
			String sFrom = dc.dateFormat(request.getParameter("from"));
			String sTo = dc.dateFormat(request.getParameter("to"));			
			
			if(vc.ifValid(uid)) {
				uid="";
				// or ErroR!
			}			
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
			devices = dao.getDevices(uid, from, to);			
			for(int i=0;i<devices.size();i++) {
				if(devices.get(i).getActivation_date()!=null) {
					activatedDevices.add(devices.get(i));
				}else if(devices.get(i).getDeactivation_date()!=null) {
					deactivatedDevices.add(devices.get(i));
				}
			}
			String returnValue="search";
			request.setAttribute("returnValue", returnValue);
			request.setAttribute("activatedDevices", activatedDevices);
			request.setAttribute("deactivatedDevices", deactivatedDevices);	
			String jsp = "/deviceList.jsp";
			RequestDispatcher dispacher = getServletContext().getRequestDispatcher(jsp);
			dispacher.forward(request, response);			
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
}