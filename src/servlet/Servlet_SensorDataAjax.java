package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao_SensorData;


@WebServlet("/Servlet_SensorDataAjax")
public class Servlet_SensorDataAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Servlet_SensorDataAjax() {
        super();
        System.out.println("Servlet_SensorDataAjax.Servlet_SensorDataAjax()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_SensorDataAjax.doGet()");
		Dao_SensorData dao = new Dao_SensorData();
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
		System.out.println("Servlet_SensorDataAjax.doPost()");
	}
}
