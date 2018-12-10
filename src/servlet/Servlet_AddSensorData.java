package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao_Device;
import dao.Dao_DevicePlacement;
import dao.Dao_SensorData;
import model.DevicePlacement;

@WebServlet("/Servlet_AddSensorData")
public class Servlet_AddSensorData extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Servlet_AddSensorData() {
        super();
        System.out.println("Servlet_AddSensorData.Servlet_AddSensorData()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_AddSensorData.doGet()");
		Dao_Device daoD = new Dao_Device();
		Dao_DevicePlacement daoDp = new Dao_DevicePlacement();
		Dao_SensorData daoSd = new Dao_SensorData();
		
		try {
			String uid = request.getParameter("loraUid");
			int data = Integer.parseInt(request.getParameter("sensorValue"));
			if(!uid.contains("<")||!uid.contains("'")||uid.length()<=10) {
				if(data==0||data==1) {
					DevicePlacement devicePlacement = daoDp.getDevicePlacement("device_id", daoD.getDevice(uid));				
					if(devicePlacement.getDevice_placement_id()>0) {
						daoSd.addSensorData(devicePlacement.getDevice_placement_id(), data);
					}
				}
			}
		} catch (Exception e) {
			
		}				
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet_AddSensorData.doPost()");
	}

}
