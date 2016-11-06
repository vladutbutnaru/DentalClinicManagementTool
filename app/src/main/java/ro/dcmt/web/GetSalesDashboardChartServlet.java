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
 * Servlet implementation class GetSalesDashboardChartServlet
 */
public class GetSalesDashboardChartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetSalesDashboardChartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		int doctorID = Integer.parseInt(request.getParameter("doctorID"));
		ArrayList<Programare> programari = ProgramariService.getAllAppointmentsForDoctor(doctorID);
		List<DashboardChartEntry> entries = new ArrayList<DashboardChartEntry>();
		for(Programare p : programari){
		DashboardChartEntry entry = new DashboardChartEntry();
		entry.setA(1);
		entry.setB(p.getIdOperatii().split(",").length);
		entry.setY(p.getData().getYear()+1900 + "-" + p.getData().getMonth() + "-" + p.getData().getDate());
		entries.add(entry);
		
		}
		System.out.println(new Gson().toJson(entries));
		
	
		
		
		response.getWriter().write(new Gson().toJson(entries));
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
