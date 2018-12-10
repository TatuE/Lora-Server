package dao;



import java.sql.Date;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;

import helper.SqlDate;
import model.DevicePlacement;

public class Dao_DevicePlacement extends Dao {

	public Dao_DevicePlacement() {
		super();
	}	
	
	public boolean newDevicePlacement(DevicePlacement devicePlacement) {
		boolean returnValue=true;		
		int id=0;
		Dao_Device daoD = new Dao_Device();
		Dao_Location daoL = new Dao_Location();
		
		sql="SELECT device_placement_id FROM LT_Device_placements WHERE location_id=? AND device_id=? AND in_use=0 AND placement_date is null";
		
		try {
			con=connect();
			if(con!=null) {				
				prepStmt=con.prepareStatement(sql);
				prepStmt.setInt(1, devicePlacement.getLocation_id());
				prepStmt.setInt(2, devicePlacement.getDevice_id());
				rs=prepStmt.executeQuery();
				if(rs!=null) {					
					while(rs.next()) {
						id=rs.getInt("device_placement_id");
					}					
				}
				con.close();
			}
			if(daoD.setInUse(devicePlacement.getDevice_id(), 1)&&daoL.setInUse(devicePlacement.getLocation_id(), 1)) {
				if(id>0) {										
					sql="UPDATE LT_Device_placements SET in_use=1, removal_date=null, placement_date=? WHERE device_placement_id=?";
					
					con=connect();
					if(con!=null) {					
						prepStmt=con.prepareStatement(sql);
						prepStmt.setDate(1, devicePlacement.getPlacement_date());
						prepStmt.setInt(2, id);
						prepStmt.executeQuery();
						con.close();
						
					}
				}else {				
					sql="INSERT INTO LT_Device_placements(location_id, device_id, in_use, placement_date) VALUES (?,?,?,?)";
					con=connect();
					if(con!=null) {
						prepStmt=con.prepareStatement(sql);
						prepStmt.setInt(1, devicePlacement.getLocation_id());
						prepStmt.setInt(2, devicePlacement.getDevice_id());
						prepStmt.setInt(3, 1);
						prepStmt.setDate(4, devicePlacement.getPlacement_date());
						prepStmt.executeQuery();
						con.close();						
					}
				}
			}else {
				returnValue=false;
			}
		}catch (Exception e) {
			return returnValue=false;
		}		
		return returnValue;
	}
	
	public boolean setInUseFalse(int id) {
		boolean returnValue=true;		
		SqlDate sqlDate = new SqlDate();
		
		sql="UPDATE LT_Device_placements SET in_use=0, placement_date=null, removal_date=? WHERE device_placement_id=?";
			
		try {
			con=connect();
			if(con!=null) {
				prepStmt=con.prepareStatement(sql);
				prepStmt.setDate(1, sqlDate.sqlCurrentDate());
				prepStmt.setInt(2, id);
				prepStmt.executeQuery();
				con.close();
			}
		} catch (Exception e) {
			return returnValue=false;
		}		
		return returnValue;		
	}		
	
	public boolean updateDevicePlacement(DevicePlacement devicePlacement) {
		boolean returnValue=true;
		Dao_Device daoD = new Dao_Device();
		Dao_Location daoL = new Dao_Location();
		
		DevicePlacement orgDevicePlacement = getDevicePlacement(devicePlacement.getDevice_placement_id());
		
		if(orgDevicePlacement.getDevice_id()!=devicePlacement.getDevice_id()) {
			daoD.setInUse(devicePlacement.getDevice_id(), 1);
			daoD.setInUse(orgDevicePlacement.getDevice_id(), 0);
		}
		
		if(orgDevicePlacement.getLocation_id()!=devicePlacement.getLocation_id()) {
			daoL.setInUse(devicePlacement.getLocation_id(), 1);
			daoL.setInUse(orgDevicePlacement.getLocation_id(), 0);
		}
		
		sql="UPDATE LT_Device_placements SET location_id=?, device_id=?, placement_date=? WHERE device_placement_id=?";
		
		try {
			con=connect();
			if(con!=null) {
				prepStmt=con.prepareStatement(sql);
				prepStmt.setInt(1, devicePlacement.getLocation_id());
				prepStmt.setInt(2, devicePlacement.getDevice_id());
				prepStmt.setDate(3, devicePlacement.getPlacement_date());
				prepStmt.setInt(4, devicePlacement.getDevice_placement_id());
				prepStmt.executeQuery();
				con.close();
			}			
		} catch (Exception e) {
			return returnValue=false;
		}
		return returnValue;
	}
	
	public DevicePlacement getDevicePlacement(int id) {
		DevicePlacement devicePlacement = new DevicePlacement();
		
		sql="SELECT * FROM LT_Device_placements WHERE device_placement_id=?";
		
		try {
			con=connect();
				if(con!=null) {
				prepStmt=con.prepareStatement(sql);
				prepStmt.setInt(1, id);
				rs=prepStmt.executeQuery();
				if(rs!=null) {
					while(rs.next()) {
						devicePlacement.setDevice_placement_id(rs.getInt("device_placement_id"));
						devicePlacement.setLocation_id(rs.getInt("location_id"));
						devicePlacement.setDevice_id(rs.getInt("device_id"));
						devicePlacement.setPlacement_date(rs.getDate("placement_date"));						
					}					
				}
			con.close();
			}					
		} catch (Exception e) {
			e.printStackTrace();
		}
		return devicePlacement;		
	}
	
	public DevicePlacement getDevicePlacement(String column, int id) {
		DevicePlacement devicePlacement = new DevicePlacement();
		
		sql="SELECT * FROM LT_Device_placements WHERE "+column+"=? AND in_use=1 AND removal_date IS NULL";
		try {
			con=connect();
				if(con!=null) {
				prepStmt=con.prepareStatement(sql);
				prepStmt.setInt(1, id);
				rs=prepStmt.executeQuery();
				if(rs!=null) {
					while(rs.next()) {
						devicePlacement.setDevice_placement_id(rs.getInt("device_placement_id"));
						devicePlacement.setLocation_id(rs.getInt("location_id"));
						devicePlacement.setDevice_id(rs.getInt("device_id"));						
					}					
				}
			con.close();
			}					
		} catch (Exception e) {
			e.printStackTrace();
		}
		return devicePlacement;			
	}
	
	public ArrayList<DevicePlacement> getDevicePlacements(){
		ArrayList<DevicePlacement> devicePlacements = new ArrayList<>();
		
		sql="SELECT dp.device_placement_id, dp.location_id, dp.device_id, dp.placement_date, l.name, l.location, d.uid "
				+ "FROM LT_Device_placements AS dp CROSS JOIN LT_Locations AS l ON dp.location_id=l.location_id CROSS JOIN LT_Devices AS d ON dp.device_id=d.device_id "
				+ "WHERE dp.in_use=1 AND dp.removal_date IS NULL";		
		try {
			con=connect();
			if(con!=null) {
				prepStmt=con.prepareStatement(sql);
				rs=prepStmt.executeQuery();
				if(rs!=null) {
					while(rs.next()) {
						DevicePlacement devicePlacement = new DevicePlacement();
						devicePlacement.setDevice_placement_id(rs.getInt("dp.device_placement_id"));
						devicePlacement.setLocation_id(rs.getInt("dp.location_id"));
						devicePlacement.setDevice_id(rs.getInt("dp.device_id"));						
						devicePlacement.setPlacement_date(rs.getDate("dp.placement_date"));
						devicePlacement.setLocationName(rs.getString("l.name"));
						devicePlacement.setLocation(rs.getString("l.location"));
						devicePlacement.setDeviceUid(rs.getString("d.uid"));						
						devicePlacements.add(devicePlacement);
					}
				}
				con.close();
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return devicePlacements;
	}
	
	public ArrayList<DevicePlacement> getDevicePlacements(String locationName, String location, String uid, Date from, Date to){
		ArrayList<DevicePlacement> devicePlacements = new ArrayList<>();
		
		if(from==null||to==null) {
			sql="SELECT dp.device_placement_id, dp.location_id, dp.device_id, dp.placement_date, l.name, l.location, d.uid "
					+ "FROM LT_Device_placements AS dp CROSS JOIN LT_Locations AS l ON dp.location_id=l.location_id CROSS JOIN LT_Devices AS d ON dp.device_id=d.device_id "
					+ "WHERE dp.in_use=1 AND l.name LIKE ? AND l.location LIKE ? AND d.uid LIKE?";
			try {
				con=connect();
				if(con!=null) {
					prepStmt=con.prepareStatement(sql);
					prepStmt.setString(1, "%"+locationName+"%");
					prepStmt.setString(2, "%"+location+"%");
					prepStmt.setString(3, "%"+uid+"%");
					rs=prepStmt.executeQuery();
					if(rs!=null) {						
						while(rs.next()) {
							DevicePlacement devicePlacement = new DevicePlacement();
							devicePlacement.setDevice_placement_id(rs.getInt("dp.device_placement_id"));
							devicePlacement.setLocation_id(rs.getInt("dp.location_id"));
							devicePlacement.setDevice_id(rs.getInt("dp.device_id"));						
							devicePlacement.setPlacement_date(rs.getDate("dp.placement_date"));
							devicePlacement.setLocationName(rs.getString("l.name"));
							devicePlacement.setLocation(rs.getString("l.location"));
							devicePlacement.setDeviceUid(rs.getString("d.uid"));						
							devicePlacements.add(devicePlacement);							
						}
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			sql="SELECT dp.device_placement_id, dp.location_id, dp.device_id, dp.placement_date, l.name, l.location, d.uid "
					+ "FROM LT_Device_placements AS dp CROSS JOIN LT_Locations AS l ON dp.location_id=l.location_id CROSS JOIN LT_Devices AS d ON dp.device_id=d.device_id "
					+ "WHERE dp.in_use=1 AND l.name LIKE ? AND l.location LIKE ? AND d.uid LIKE? AND dp.placement_date BETWEEN ? AND ?";
			try {
				con=connect();
				if(con!=null) {
					prepStmt=con.prepareStatement(sql);
					prepStmt.setString(1, "%"+locationName+"%");
					prepStmt.setString(2, "%"+location+"%");
					prepStmt.setString(3, "%"+uid+"%");
					prepStmt.setDate(4, from);
					prepStmt.setDate(5, to);
					rs=prepStmt.executeQuery();
					if(rs!=null) {
						while(rs.next()) {
							DevicePlacement devicePlacement = new DevicePlacement();
							devicePlacement.setDevice_placement_id(rs.getInt("dp.device_placement_id"));
							devicePlacement.setLocation_id(rs.getInt("dp.location_id"));
							devicePlacement.setDevice_id(rs.getInt("dp.device_id"));						
							devicePlacement.setPlacement_date(rs.getDate("dp.placement_date"));
							devicePlacement.setLocationName(rs.getString("l.name"));
							devicePlacement.setLocation(rs.getString("l.location"));
							devicePlacement.setDeviceUid(rs.getString("d.uid"));						
							devicePlacements.add(devicePlacement);							
						}
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}		
		return devicePlacements;
	}
	
	public String getJSON() throws Exception{
		String returnJSON="";
		
		sql="SELECT dp.device_placement_id, dp.location_id, dp.device_id, dp.placement_date, l.name, l.location, d.uid "
				+ "FROM LT_Device_placements AS dp CROSS JOIN LT_Locations AS l ON dp.location_id=l.location_id CROSS JOIN LT_Devices AS d ON dp.device_id=d.device_id "
				+ "WHERE dp.in_use=1 AND dp.removal_date IS NULL";
		
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
