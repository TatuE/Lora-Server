package dao;

public class Dao_SignIn extends Dao {

	public Dao_SignIn() {
		super();
	
	}
	
	public String signIn(String user_name, String psswd) {
		String returnValue="";
		
		sql="SELECT CONCAT(first_name, ' ', last_name) AS user FROM LT_Users WHERE user_name=? AND psswd=? AND in_use=1";
		
		try {
			con=connect();
			if(con!=null) {
				prepStmt = con.prepareStatement(sql);
				prepStmt.setString(1, user_name);
				prepStmt.setString(2, psswd);
				rs=prepStmt.executeQuery();
				if(rs!=null) {
					while(rs.next()) {
						returnValue = rs.getString("user");
					}
				}
				con.close();
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return returnValue;
	}	
}
