package helper;

public class ValueChecker {

	public ValueChecker() {
		super();
		
	}
	
	public boolean ifValid(String value) {
		boolean returnValue = false;
		String[] falseValues = {"<","'",">"};
		
		for(int i=0;i<falseValues.length;i++) {
			if(value.contains(falseValues[i])) {
				returnValue=true;
			}
		}		
		return returnValue;
	}
}
