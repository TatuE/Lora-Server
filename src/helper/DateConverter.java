package helper;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.regex.Pattern;


public class DateConverter {

	public DateConverter() {
		super();
	}
	
	public String dateFormat(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
		
		return sdf.format(date);
		
	}
	
	public String dateFormat(Timestamp timestamp) {
		SqlDate sqlDate = new SqlDate();
		Date currentDate = sqlDate.sqlCurrentDate();
		SimpleDateFormat sdfY = new SimpleDateFormat("yyyy");
		SimpleDateFormat sdfM = new SimpleDateFormat("MM");
		SimpleDateFormat sdfD = new SimpleDateFormat("dd");
		
		if(Integer.parseInt(sdfY.format(currentDate))>Integer.parseInt(sdfY.format(timestamp))) {
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss dd.MM.yyyy");
			return sdf.format(timestamp);
		}
		
		if(Integer.parseInt(sdfM.format(currentDate))==Integer.parseInt(sdfM.format(timestamp))) {
			
			if(Integer.parseInt(sdfD.format(currentDate))==Integer.parseInt(sdfD.format(timestamp))) {
				SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
				return sdf.format(timestamp);
			}else {
				SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss dd.MM");
				return sdf.format(timestamp);
			}			
		}else {
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss dd.MM");
			return sdf.format(timestamp);
		}		
	}
	
	public String dateFormat(String date) {
		String returnString="";
		String[] stringParts = date.split((Pattern.quote(".")));
		
		for(int i=stringParts.length-1;i>-1;i--) {
			if(i>0) {
				returnString+=stringParts[i]+"-";
			}else {
				returnString+=stringParts[i];
			}			
		}		
		return returnString;		
	}
	
	public Timestamp timestampFormat(String timestampString) {		
		Timestamp timestamp = Timestamp.valueOf(timestampString);		
		return timestamp;
	}
}
