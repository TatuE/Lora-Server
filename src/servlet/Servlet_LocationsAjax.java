package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao;


@WebServlet("/Servlet_LocationsAjax")
public class Servlet_LocationsAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;       
    
    public Servlet_LocationsAjax() {
        super();
        System.out.println("Servlet_LocationsAjax.Servlet_LocationsAjax()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_LocationsAjax.doGet()");		
		Dao dao = new Dao();
		try {
			String[] columns = {"location_id","name","location","deployment_date","in_use","activation_date"};
			String strJSON = dao.getJSON(columns, "LT_Locations", "", "", 1);
			PrintWriter out = response.getWriter(  );
			response.setContentType("text/html"); 
		    out.println(strJSON);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_LocationsAjax.doPost()");
	}
}
