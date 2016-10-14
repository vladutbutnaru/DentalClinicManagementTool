package ro.dcmt.mobile;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ro.dcmt.data.beans.Cabinet;
import ro.dcmt.data.controllers.CabinetService;
import ro.dcmt.data.controllers.FeedbackService;

/**
 * Servlet implementation class GetCabinetsNearbyEndpoint
 */
public class GetCabinetsNearbyEndpoint extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetCabinetsNearbyEndpoint() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String city = request.getParameter("city");
		CabinetService cs = new CabinetService();
		FeedbackService fs = new FeedbackService();
		String responseText = "";
		Cabinet cabinet;
		
		for(Object c : cs.getAllByColumn("Oras", city)){
			 cabinet = (Cabinet) c;
		
			responseText+= cabinet.getNume();
			responseText+="," + fs.getMedianFeedbackForCabinet(cabinet.getId());
			responseText+="," + cabinet.getImage().getName();
			responseText+=";";
			
			
			
		}
		System.out.println(responseText);
		response.getWriter().append(responseText);
		
	}

}
