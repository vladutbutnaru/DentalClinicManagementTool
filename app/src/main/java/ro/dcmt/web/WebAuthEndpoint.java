package ro.dcmt.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.JsonObject;

import ro.dcmt.data.beans.User;
import ro.dcmt.data.controllers.UserService;

/**
 * Servlet implementation class WebAuthEndpoint
 */
public class WebAuthEndpoint extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger logger = LoggerFactory.getLogger(WebAuthEndpoint.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public WebAuthEndpoint() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Cookie[] cookies = request.getCookies();
		
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("user"))
					
					cookie.setMaxAge(0);
					
			}
		}
		for(Cookie c : cookies){
			response.addCookie(c);
			
		}
		response.sendRedirect("login.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User u = new User();
	
		u.setEmail(request.getParameter("email"));
		u.setPassword(request.getParameter("password"));
		if (UserService.checkAuth(u)) {
			logger.info("Web user logged in: " + u.getEmail());
			Cookie loginCookie = new Cookie("user", u.getEmail());
			// setting cookie to expiry in 6 hours
			loginCookie.setMaxAge(6 * 60 * 60);
			response.addCookie(loginCookie);
		
		
			response.sendRedirect("home.jsp");
		} else {
			logger.info("Web user failed authentication with: " + u.getEmail());
			Cookie failedCookie = new Cookie("failed", "yes");
			// setting cookie to expiry in 5 seconds
			failedCookie.setMaxAge(1 * 5);
			response.addCookie(failedCookie);
			response.sendRedirect("login.jsp");
		}
	}

}
