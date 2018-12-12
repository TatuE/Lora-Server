package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

public class Dao {
	public Connection con =null;
	public ResultSet rs = null;
	public PreparedStatement prepStmt = null;
	public String sql;

	public Dao() {
		super();
	}

	public Connection connect() throws Exception{
		String JDBCDriver = "org.mariadb.jdbc.Driver";
		String url = "jdbc:mariadb://<mariadb-server>";
		Class.forName(JDBCDriver);
		con = DriverManager.getConnection(url,"username", "password");
		return con;
	}

	public void closeConnection() throws Exception{
		if(con!=null) {
			con.close();
		}
	}

	public String getJSON(String [] columns, String table, String conditionColumn, String conditionValue, int sortBy) throws Exception{
		String returnJSON="";
		String clmnStr="";

		for(int i=0;i<columns.length;i++) {
			clmnStr+=columns[i]+",";
		}
		clmnStr = clmnStr.substring(0,clmnStr.length()-1);

		sql = "SELECT "+clmnStr+" FROM "+table+" WHERE decommission_date is NULL";
		if(conditionColumn.length()>0){
			sql += " AND "+conditionColumn+"=?";
		}
		if(sortBy>0){
			sql += " ORDER BY " + sortBy;
		}

		con=connect();
		if(con!=null){
			prepStmt = con.prepareStatement(sql);
			if(conditionColumn.length()>0){
				prepStmt.setString(1, conditionValue);
			}
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
