package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao_Location;


@WebServlet("/Servlet_ActivateLocation")
public class Servlet_ActivateLocation extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Servlet_ActivateLocation() {
        super();
        System.out.println("Servlet_ActivateLocation.Servlet_ActivateLocation()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_ActivateLocation.doGet()");
		int id = Integer.parseInt(request.getParameter("location_id"));
		Dao_Location dao = new Dao_Location();
		if(dao.activateLocation(id)) {
			response.sendRedirect("Servlet_GetLocations");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_ActivateLocation.doPost()");
	}

}
