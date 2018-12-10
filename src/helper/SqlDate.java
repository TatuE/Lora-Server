package helper;

public class SqlDate {

	public SqlDate() {
		super();

	}
	
	public java.sql.Date sqlCurrentDate(){
		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		return sqlDate;	
	}
	
	

}
