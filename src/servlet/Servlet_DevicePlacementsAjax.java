package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao_DevicePlacement;


@WebServlet("/Servlet_DevicePlacementsAjax")
public class Servlet_DevicePlacementsAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Servlet_DevicePlacementsAjax() {
        super();
        System.out.println("Servlet_DevicePlacementsAjax.Servlet_DevicePlacementsAjax()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_DevicePlacementsAjax.doGet()");
		Dao_DevicePlacement dao = new Dao_DevicePlacement();
		try {
			String strJSON = dao.getJSON();
			PrintWriter out = response.getWriter(  );
			response.setContentType("text/html"); 
		    out.println(strJSON);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_DevicePlacementsAjax.doPost()");
	}

}
