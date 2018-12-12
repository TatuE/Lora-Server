package dao;


import java.sql.ResultSetMetaData;
import java.util.ArrayList;

import helper.DateConverter;
import model.SensorData;

public class Dao_SensorData extends Dao {
	
	public boolean addSensorData(int id, int data) {
		boolean returnValue=true;
		
		sql="INSERT INTO LT_Sensor_data(device_placement_id,sensor_data) VALUES(?,?)";
		
		try {
			con=connect();
			prepStmt=con.prepareStatement(sql);
			prepStmt.setInt(1, id);
			prepStmt.setInt(2, data);
			prepStmt.executeQuery();
			con.close();			
		} catch (Exception e) {
			return returnValue=false;
		}
		return returnValue;
	}
	
	public ArrayList<SensorData> getSensorData(){
		ArrayList<SensorData> sensorDataList = new ArrayList<>();			
		
		sql="SELECT sd.sensor_data_id, sd.sensor_data, sd.sensor_data_time, dp.device_placement_id, l.location, l.name "
				+ "FROM LT_Sensor_data AS sd CROSS JOIN LT_Device_placements AS dp ON sd.device_placement_id=dp.device_placement_id CROSS JOIN LT_Locations AS l ON dp.location_id=l.location_id "
				+ "WHERE dp.in_use=1 ORDER BY 3 desc";
		
		try {
			con=connect();
			if(con!=null) {
				prepStmt=con.prepareStatement(sql);
				rs=prepStmt.executeQuery();
				if(rs!=null) {
					while(rs.next()) {						
						SensorData sensorData = new SensorData();
						sensorData.setSensor_data_id(rs.getInt("sd.sensor_data_id"));
						sensorData.setSensor_data(rs.getInt("sd.sensor_data"));
						sensorData.setSensor_data_time(rs.getTimestamp("sd.sensor_data_time"));
						sensorData.setDevice_placement_id(rs.getInt("dp.device_placement_id"));
						sensorData.setLocation(rs.getString("l.location"));
						sensorData.setLocationName(rs.getString("l.name"));						
						if(sensorDataList.isEmpty()) {
							sensorDataList.add(sensorData);		
						}else if(sensorDataList.get(sensorDataList.size()-1).getDevice_placement_id()!=sensorData.getDevice_placement_id()) {
							sensorDataList.add(sensorData);
						}											
					}
				}
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return sensorDataList;		
	}
	
	public ArrayList<SensorData> getSensorData(String locationName, String location, int status){
		ArrayList<SensorData> sensorDataList = new ArrayList<>();
			
		sql="SELECT sd.sensor_data_id, sd.sensor_data, sd.sensor_data_time, dp.device_placement_id, l.location, l.name "
				+ "FROM LT_Sensor_data AS sd CROSS JOIN LT_Device_placements AS dp ON sd.device_placement_id=dp.device_placement_id CROSS JOIN LT_Locations AS l ON dp.location_id=l.location_id "
				+ "WHERE l.name LIKE ? AND l.location LIKE ? AND dp.in_use=1 ORDER BY 3 desc";
		try {
			con=connect();
			if(con!=null) {
				prepStmt=con.prepareStatement(sql);
				prepStmt.setString(1, "%"+locationName+"%");
				prepStmt.setString(2, "%"+location+"%");
				rs=prepStmt.executeQuery();
				if(rs!=null) {
					while(rs.next()) {						
						SensorData sensorData = new SensorData();
						sensorData.setSensor_data_id(rs.getInt("sd.sensor_data_id"));
						sensorData.setSensor_data(rs.getInt("sd.sensor_data"));						
						sensorData.setSensor_data_time(rs.getTimestamp("sd.sensor_data_time"));						
						sensorData.setDevice_placement_id(rs.getInt("dp.device_placement_id"));
						sensorData.setLocation(rs.getString("l.location"));
						sensorData.setLocationName(rs.getString("l.name"));	
						if(sensorDataList.isEmpty()) {
							sensorDataList.add(sensorData);		
						}else if(sensorDataList.get(sensorDataList.size()-1).getDevice_placement_id()!=sensorData.getDevice_placement_id()) {
							sensorDataList.add(sensorData);
						}																						
					}
				}
				con.close();
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(status==1) {
			for(int i=0;i<sensorDataList.size();i++) {
				if(sensorDataList.get(i).getSensor_data()==0) {
					sensorDataList.remove(i);
				}
			}
		}else if (status==0) {
			for(int i=0;i<sensorDataList.size();i++) {
				if(sensorDataList.get(i).getSensor_data()==1) {
					sensorDataList.remove(i);
				}
			}
		}
		
		return sensorDataList;		
	}
	
	public String getJSON() throws Exception{
		String returnJSON="";
		DateConverter dc = new DateConverter();
		
		sql="SELECT sd.sensor_data_id, sd.sensor_data, sd.sensor_data_time, dp.device_placement_id, l.location, l.name "
				+ "FROM LT_Sensor_data AS sd CROSS JOIN LT_Device_placements AS dp ON sd.device_placement_id=dp.device_placement_id CROSS JOIN LT_Locations AS l ON dp.location_id=l.location_id "
				+ "WHERE dp.in_use=1 ORDER BY 3 desc;";
		
		con=connect();
		if(con!=null){
			prepStmt = con.prepareStatement(sql);			
    		rs = prepStmt.executeQuery();  
    		ResultSetMetaData rsmd = rs.getMetaData();
			if(rs!=null){
				int numColumns = rsmd.getColumnCount();
				returnJSON += "[";
				while(rs.next()){	
					returnJSON += "{";
					for (int i=1; i<numColumns+1; i++) {
						returnJSON += "\"";
						returnJSON += rsmd.getColumnName(i);
						returnJSON += "\":";
						returnJSON += "\"";
						try {
							String JSONValue = rs.getString(i);
							if(JSONValue==null) {
								JSONValue="";
							}
							if(JSONValue.contains("-")){
								JSONValue= dc.dateFormat(dc.timestampFormat(JSONValue));
							}
							returnJSON += JSONValue.trim();
						} catch (Exception e) {
							e.printStackTrace();
						}						
						returnJSON += "\"";
						if(i<numColumns){
							returnJSON += ",";
						}						
					}	
					returnJSON += "}";					
					returnJSON += ",";					
				}	
				returnJSON += "]";
			}
			con.close();
		}
		
		returnJSON = returnJSON.substring(0, returnJSON.length()-2) + "]";
		if(returnJSON.length()==1){			
			returnJSON="{}";
		}		
		return returnJSON;		
	}
}