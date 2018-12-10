package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao;


@WebServlet("/Servlet_DevicesAjax")
public class Servlet_DevicesAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Servlet_DevicesAjax() {
        super();
        System.out.println("Servlet_DevicesAjax.Servlet_DevicesAjax()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_DevicesAjax.doGet()");
		Dao dao = new Dao();
		try {
			String[] columns = {"device_id","uid","in_use","deployment_date","activation_date"};
			String strJSON = dao.getJSON(columns, "LT_Devices", "", "", 1);
			PrintWriter out = response.getWriter(  );
			response.setContentType("text/html"); 
		    out.println(strJSON);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_DevicesAjax.doPost()");
	}

}
