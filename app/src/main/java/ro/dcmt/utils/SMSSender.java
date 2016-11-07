package ro.dcmt.utils;

import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.HttpClientBuilder;

public class SMSSender {
	
	public static void sendSMS(String numarTelefon, String numePacient, String numeDoctor, String data, String numeCabinet) throws Exception{
		 HttpClient httpClient = HttpClientBuilder.create().build(); //Use this instead 

		    
		    
		    
		 String message = "Doctorul " + numeDoctor + " a confirmat programarea ta de pe " + data + " la " + numeCabinet + ". Iti multumim, " + numePacient;
		    try {
		        HttpPost request = new HttpPost("http://client.alertsms.ro/api/v2");
		        StringEntity params =new StringEntity("{\"method\":\"TrimiteSMS\",\"user\":\"wurgut\",\"password\":\"wurgut321qaz\",\"token\":\"265fbbdbaf82361b8ecd0b5e1798a8fa\",\"content\":[{\"destinatar\":\""+numarTelefon+"\",\"mesaj\":\""+message+"\",\"flash\":true}]}");
		        request.addHeader("content-type", "application/json");
		        request.addHeader("POSTFIELDS", "{\"method\":\"TrimiteSMS\",\"user\":\"wurgut\",\"password\":\"wurgut321qaz\",\"token\":\"265fbbdbaf82361b8ecd0b5e1798a8fa\",\"content\":[{\"destinatar\":\""+numarTelefon+"\",\"mesaj\":\""+message+"\",\"flash\":true}]}");
		        request.setEntity(params);
		        ResponseHandler<String> responseHandler=new BasicResponseHandler();
		        String response = httpClient.execute(request, responseHandler);
		        System.out.println(response);
		        // handle response here...
		    }catch (Exception ex) {
		        // handle exception here
		    } 
		
		    
		    
		   

		   
		
	}
}
