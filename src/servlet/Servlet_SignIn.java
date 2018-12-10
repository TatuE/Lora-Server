package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import dao.Dao_SignIn;

@WebServlet("/Servlet_SignIn")
public class Servlet_SignIn extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Servlet_SignIn() {
        super();
        System.out.println("Servlet_SignIn.Servlet_SignIn()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_SignIn.doGet()");
		int id;
		
		try {
			id = Integer.parseInt(request.getParameter("signOut"));
			if(id==1) {
				HttpSession session = request.getSession(true);
				session.removeAttribute("User");
				response.sendRedirect("Servlet_GetSensorData");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_SignIn.doPost()");
		Dao_SignIn dao = new Dao_SignIn();
		String user="";
		try {
			String user_name = request.getParameter("user_name");
			String psswd = request.getParameter("psswd");
			user = dao.signIn(user_name, psswd);
			if(user.length()>0) {
				HttpSession session = request.getSession(true);
				session.setAttribute("User", user);				
				if(session.getAttribute("targetPage")!=null) {
					response.sendRedirect(session.getAttribute("targetPage").toString());
				}else {
					response.sendRedirect("Servlet_GetSensorData");
				}			
			}
			
		} catch (Exception e) {
			response.sendRedirect("index.jsp");
		}
	}

}
