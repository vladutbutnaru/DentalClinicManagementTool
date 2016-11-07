package ro.dcmt.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ro.dcmt.data.beans.DashboardChartEntry;
import ro.dcmt.data.beans.Programare;
import ro.dcmt.data.controllers.ProgramariService;

/**
 * Servlet implementation class GetPatientsDashboardChartServlet
 */
public class GetPatientsDashboardChartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetPatientsDashboardChartServlet() {
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
		// TODO Auto-generated method stub
				response.setContentType("text/html");
				response.setCharacterEncoding("UTF-8");
				int doctorID = Integer.parseInt(request.getParameter("doctorID"));
				ArrayList<Programare> programari = ProgramariService.getAllAppointmentsForDoctor(doctorID);
				
				List<DashboardChartEntry> entries = new ArrayList<DashboardChartEntry>();
				for(Programare p : programari){
				DashboardChartEntry entry = new DashboardChartEntry();
				entry.setA(1);
				entry.setB(0);
				entry.setY(p.getData().getMonth() + " " + p.getData().getDate());
				entries.add(entry);
				
				}
			
				
			
				
				
				response.getWriter().write(new Gson().toJson(entries));
	}

}
