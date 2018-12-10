package dao;



import java.sql.Date;
import java.util.ArrayList;

import helper.SqlDate;
import model.Location;

public class Dao_Location extends Dao {

	public Dao_Location() {
		super();		
	}
	
	public boolean newLocation(Location location) {
		boolean returnValue=true;
		SqlDate sqlDate = new SqlDate();
		
		sql="INSERT INTO LT_Locations(name, location, in_use, deployment_date, activation_date) VALUES(?,?,?,?,?)";
		
		try {
			con=connect();
			prepStmt=con.prepareStatement(sql);
			prepStmt.setString(1, location.getName());
			prepStmt.setString(2, location.getLocation());
			prepStmt.setInt(3, 0);
			prepStmt.setDate(4, location.getDeployment_date());
			prepStmt.setDate(5, sqlDate.sqlCurrentDate());
			prepStmt.executeQuery();
			con.close();			
		} catch (Exception e) {
			return returnValue=false;
		}
		return returnValue;
	}
	
	public boolean setInUse(int id, int in_use) {
		boolean returnValue=true;
		
		sql="UPDATE LT_Locations SET in_use=? WHERE location_id=?";
		
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
	
	public boolean deactivateLocation(int id) {
		boolean returnValue=true;
		SqlDate sqlDate = new SqlDate();
		
		sql="UPDATE LT_Locations SET deactivation_date=?, in_use=0, activation_date=NULL WHERE location_id=?";
		
		try {
			con=connect();
			prepStmt=con.prepareStatement(sql);
			prepStmt.setDate(1, sqlDate.sqlCurrentDate());
			prepStmt.setInt(2,id);
			prepStmt.executeQuery();
			con.close();			
		} catch (Exception e) {
			return returnValue=false;
		}		
		return returnValue;
	}
	
	public boolean activateLocation(int id) {
		boolean returnValue=true;
		SqlDate sqlDate = new SqlDate();
		
		sql="UPDATE LT_Locations SET activation_date=?, in_use=0, deactivation_date=NULL WHERE location_id=? ";
		
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
	
	public boolean decommissionLocation(int id) {
		boolean returnValue=true;
		SqlDate sqlDate = new SqlDate();
		
		sql="UPDATE LT_Locations SET decommission_date=?, in_use=0 WHERE location_id=?";
		
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
	
	public boolean updateLocation(Location location) {
		boolean returnValue=true;
		
		sql="UPDATE LT_Locations SET name=?, location=?, deployment_date=? WHERE location_id=? ";
		
		try {
			con=connect();
			prepStmt=con.prepareStatement(sql);
			prepStmt.setString(1, location.getName());
			prepStmt.setString(2, location.getLocation());
			prepStmt.setDate(3, location.getDeployment_date());
			prepStmt.setInt(4, location.getLocation_id());
			prepStmt.executeQuery();
			con.close();			
		} catch (Exception e) {
			return returnValue=false;
		}		
		return returnValue;
	}
	
	public Location getLocation(int id) throws Exception {
		Location location = new Location();
		
		sql="SELECT * FROM LT_Locations WHERE location_id=?";
		con=connect();
		if(con!=null) {
			prepStmt=con.prepareStatement(sql);
			prepStmt.setInt(1, id);
			rs=prepStmt.executeQuery();
			if(rs!=null) {				
				while(rs.next()) {
					location.setLocation_id(rs.getInt("location_id"));
					location.setName(rs.getString("name"));
					location.setLocation(rs.getString("location"));
					location.setIn_use(rs.getInt("in_use"));
					location.setDeployment_date(rs.getDate("deployment_date"));					
				}
			}
			con.close();
		}		
		return location;
	}
	
	public ArrayList<Location> getLocations(){
		ArrayList<Location> locations = new ArrayList<>();
		
		sql="SELECT * FROM LT_Locations WHERE decommission_date is NULL ";
		
		try {
			con=connect();
			if(con!=null) {
				prepStmt=con.prepareStatement(sql);		
				rs=prepStmt.executeQuery();
				if(rs!=null) {
					while(rs.next()) {
						Location location = new Location();
						location.setLocation_id(rs.getInt("location_id"));
						location.setName(rs.getString("name"));
						location.setLocation(rs.getString("location"));
						location.setIn_use(rs.getInt("in_use"));
						location.setDeployment_date(rs.getDate("deployment_date"));
						location.setActivation_date(rs.getDate("activation_date"));
						location.setDeactivation_date(rs.getDate("deactivation_date"));
						locations.add(location);
					}
				}
				con.close();
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return locations;
	}
	
	public ArrayList<Location> getLocations(String name, String locationName, Date from, Date to){
		ArrayList<Location> locations = new ArrayList<>();
		
		if(from==null||to==null) {
			sql="SELECT * FROM LT_Locations WHERE name LIKE ? AND location LIKE ? AND decommission_date is NULL";
			try {
				con=connect();
				if(con!=null) {
					prepStmt=con.prepareStatement(sql);
					prepStmt.setString(1, "%"+name+"%");
					prepStmt.setString(2, "%"+locationName+"%");
					rs=prepStmt.executeQuery();
					if(rs!=null) {
						while(rs.next()) {
							Location location = new Location();
							location.setLocation_id(rs.getInt("location_id"));
							location.setName(rs.getString("name"));
							location.setLocation(rs.getString("location"));
							location.setIn_use(rs.getInt("in_use"));
							location.setDeployment_date(rs.getDate("deployment_date"));
							location.setActivation_date(rs.getDate("activation_date"));
							location.setDeactivation_date(rs.getDate("deactivation_date"));
							locations.add(location);
						}
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			sql="SELECT * FROM LT_Locations WHERE name LIKE ? AND location LIKE ? AND deployment_date BETWEEN ? AND ? AND decommission_date is NULL";
			try {
				con=connect();
				if(con!=null) {
					prepStmt=con.prepareStatement(sql);
					prepStmt.setString(1, "%"+name+"%");
					prepStmt.setString(2, "%"+locationName+"%");
					prepStmt.setDate(3, from);
					prepStmt.setDate(4, to);
					rs=prepStmt.executeQuery();
					if(rs!=null) {
						while(rs.next()) {
							Location location = new Location();
							location.setLocation_id(rs.getInt("location_id"));
							location.setName(rs.getString("name"));
							location.setLocation(rs.getString("location"));
							location.setIn_use(rs.getInt("in_use"));
							location.setDeployment_date(rs.getDate("deployment_date"));
							location.setActivation_date(rs.getDate("activation_date"));
							location.setDeactivation_date(rs.getDate("deactivation_date"));
							locations.add(location);
						}
					}
					con.close();
				}				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}		
		return locations;		
	}
}