package dao;

import java.sql.Date;
import java.util.ArrayList;

import helper.SqlDate;
import model.Device;

public class Dao_Device extends Dao{

	public Dao_Device() {
		super();	
	}
	
	public boolean newDevice(Device device) {
		boolean returnValue=true;
		SqlDate sqlDate = new SqlDate();
		
		sql="INSERT INTO LT_Devices(uid, in_use, deployment_date, activation_date) VALUES(?,?,?,?)";
		
		try {
			con=connect();
			prepStmt=con.prepareStatement(sql);
			prepStmt.setString(1, device.getUid());			
			prepStmt.setInt(2, 0);
			prepStmt.setDate(3, device.getDeployment_date());
			prepStmt.setDate(4, sqlDate.sqlCurrentDate());			
			prepStmt.executeQuery();
			con.close();
		} catch (Exception e) {
			return returnValue=false;
		}
		return returnValue;
	}
	
	public boolean setInUse(int id, int in_use) {
		boolean returnValue=true;
		
		sql="UPDATE LT_Devices SET in_use=? WHERE device_id=?";
		
		try {
			con=connect();
			prepStmt=con.prepareStatement(sql);
			prepStmt.setInt(1, in_use);
			prepStmt.setInt(2,id);
			prepStmt.executeQuery();
			con.close();			
		} catch (Exception e) {
			return returnValue=false;
		}		
		return returnValue;
	}
	
	public boolean deactivateDevice(int id) {
		boolean returnValue=true;
		SqlDate sqlDate = new SqlDate();
		
		sql="UPDATE LT_Devices SET deactivation_date=?, in_use=0, activation_date=NULL WHERE device_id=?";
		
		try {
			con=connect();
			prepStmt=con.prepareStatement(sql);			
			prepStmt.setDate(1, sqlDate.sqlCurrentDate());
			prepStmt.setInt(2, id);
			prepStmt.executeQuery();
			con.close();			
		} catch (Exception e) {
			return returnValue=false;
		}		
		return returnValue;
	}
	
	public boolean activateDevice(int id) {
		boolean returnValue=true;
		SqlDate sqlDate = new SqlDate();
		
		sql="UPDATE LT_Devices SET activation_date=?, in_use=0, deactivation_date=NULL WHERE device_id=?";
		
		try {
			con=connect();
			prepStmt=con.prepareStatement(sql);
			prepStmt.setDate(1, sqlDate.sqlCurrentDate());
			prepStmt.setInt(2, id);
			prepStmt.executeQuery();
			con.close();			
		} catch (Exception e) {
			return returnValue=false;
		}		
		return returnValue;
	}
	
	public boolean decommissionDevice(int id) {
		boolean returnValue=true;
		SqlDate sqlDate = new SqlDate();
		
		sql="UPDATE LT_Devices SET decommission_date=?, in_use=0 WHERE device_id=?";
		
		try {
			con=connect();
			prepStmt=con.prepareStatement(sql);
			prepStmt.setDate(1, sqlDate.sqlCurrentDate());
			prepStmt.setInt(2, id);
			prepStmt.executeQuery();
			con.close();			
		} catch (Exception e) {
			return returnValue=false;
		}		
		return returnValue;
	}
	
	public boolean updateDevice(Device device) {
		boolean returnValue=true;		
		sql="UPDATE LT_Devices SET uid=?, deployment_date=? WHERE device_id=?";
		
		try {
			con=connect();
			prepStmt=con.prepareStatement(sql);
			prepStmt.setString(1, device.getUid());
			prepStmt.setDate(2, device.getDeployment_date());
			prepStmt.setInt(3, device.getDevice_id());
			prepStmt.executeQuery();
			con.close();			
		} catch (Exception e) {
			return returnValue=false;
		}		
		return returnValue;
	}
	
	public Device getDevice(int id) throws Exception {
		Device device = new Device();		
		sql="SELECT * FROM LT_Devices WHERE device_id=?";
		
		con=connect();
		if(con!=null) {
			prepStmt=con.prepareStatement(sql);
			prepStmt.setInt(1, id);
			rs=prepStmt.executeQuery();
			if(rs!=null) {
				while(rs.next()) {
					device.setDevice_id(rs.getInt("device_id"));
					device.setUid(rs.getString("uid"));
					device.setIn_use(rs.getInt("in_use"));
					device.setDeployment_date(rs.getDate("deployment_date"));					
				}
			}
			con.close();
		}		
		return device;
	}
	
	public int getDevice(String uid) throws Exception{
		int device_id=0;
		
		sql="SELECT device_id FROM LT_Devices WHERE uid=?";
		
		con=connect();
		if(con!=null) {
			prepStmt=con.prepareStatement(sql);
			prepStmt.setString(1, uid);
			rs=prepStmt.executeQuery();
			if(rs!=null) {
				while(rs.next()) {
					device_id=rs.getInt("device_id");
				}
			}			
		}		
		return device_id;
	}
	
	public ArrayList<Device> getDevices(){
		ArrayList<Device> devices = new ArrayList<>();		
		sql="SELECT * FROM LT_Devices WHERE decommission_date is NULL";
		
		try {
			con=connect();
			if(con!=null) {
				prepStmt=con.prepareStatement(sql);
				rs=prepStmt.executeQuery();
				if(rs!=null) {					
					while(rs.next()) {
						Device device = new Device();
						device.setDevice_id(rs.getInt("device_id"));
						device.setUid(rs.getString("uid"));
						device.setIn_use(rs.getInt("in_use"));
						device.setDeployment_date(rs.getDate("deployment_date"));
						device.setActivation_date(rs.getDate("activation_date"));
						device.setDeactivation_date(rs.getDate("deactivation_date"));
						devices.add(device);
					}
				}
				con.close();
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return devices;
	}
	
	public ArrayList<Device> getDevices(String uid, Date from, Date to){
		ArrayList<Device> devices = new ArrayList<>();
		
		if(from==null||to==null) {			
			sql="SELECT * FROM LT_Devices WHERE uid LIKE ? AND decommission_date is NULL";			
			try {
				con=connect();
				if(con!=null) {
					prepStmt=con.prepareStatement(sql);
					prepStmt.setString(1, "%"+uid+"%");
					rs=prepStmt.executeQuery();
					if(rs!=null) {						
						while(rs.next()) {
							Device device = new Device();
							device.setDevice_id(rs.getInt("device_id"));
							device.setUid(rs.getString("uid"));
							device.setIn_use(rs.getInt("in_use"));
							device.setDeployment_date(rs.getDate("deployment_date"));
							device.setActivation_date(rs.getDate("activation_date"));
							device.setDeactivation_date(rs.getDate("deactivation_date"));
							devices.add(device);
						}
					}
					con.close();
				}				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			sql="SELECT * FROM LT_Devices WHERE uid LIKE ? AND deployment_date BETWEEN ? AND ? AND decommission_date is NULL";
			try {
				con=connect();
				if(con!=null) {
					prepStmt=con.prepareStatement(sql);
					prepStmt.setString(1, "%"+uid+"%");
					prepStmt.setDate(2, from);
					prepStmt.setDate(3, to);
					rs=prepStmt.executeQuery();
					if(rs!=null) {						
						while(rs.next()) {
							Device device = new Device();
							device.setDevice_id(rs.getInt("device_id"));
							device.setUid(rs.getString("uid"));
							device.setIn_use(rs.getInt("in_use"));
							device.setDeployment_date(rs.getDate("deployment_date"));
							device.setActivation_date(rs.getDate("activation_date"));
							device.setDeactivation_date(rs.getDate("deactivation_date"));
							devices.add(device);
						}
					}
					con.close();
				}				
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}
		return devices;
	}	
}
