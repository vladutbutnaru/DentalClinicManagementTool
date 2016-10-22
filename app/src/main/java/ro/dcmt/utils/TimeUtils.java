package ro.dcmt.utils;

import java.sql.Timestamp;
import java.util.Date;

public class TimeUtils {
public static long differenceNowAndTimestamp(Timestamp t){
		Date d = new Date();
		
	  long milliseconds1 = t.getTime();
	  long milliseconds2 = d.getTime();
	  long diff = milliseconds1 - milliseconds2;
	  long diffDays = diff / (24 * 60 * 60 * 1000);
	
	  return diffDays;
}
}
