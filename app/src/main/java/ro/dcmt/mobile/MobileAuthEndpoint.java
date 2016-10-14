package ro.dcmt.mobile;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.JsonObject;

import ro.dcmt.data.beans.User;
import ro.dcmt.data.controllers.UserService;


public class MobileAuthEndpoint extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private static Logger logger = LoggerFactory.getLogger(MobileAuthEndpoint.class);


	
	public MobileAuthEndpoint() {
		super();

	}

	
	public void init(ServletConfig config) throws ServletException {
		logger.info("Mobile Authentication Endpoint initialized");
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User u = new User();
	
		u.setEmail(request.getParameter("email"));
		u.setPassword(request.getParameter("password"));
		if (UserService.checkAuthMobile(u)) {
			logger.info("Mobile user logged in: " + u.getEmail());
		
			response.getWriter().append("OK");
		} else {
			logger.info("Mobile user failed authentication with: " + u.getEmail());
			
			response.getWriter().append("NOK");
		}
	}

}
