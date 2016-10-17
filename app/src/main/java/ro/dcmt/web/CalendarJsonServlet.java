package ro.dcmt.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ro.dcmt.data.beans.CalendarFEEntry;
import ro.dcmt.data.beans.Pacient;
import ro.dcmt.data.beans.Programare;
import ro.dcmt.data.controllers.PacientService;
import ro.dcmt.data.controllers.ProgramariService;

/**
 * Servlet implementation class CalendarJsonServlet
 */
public class CalendarJsonServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CalendarJsonServlet() {
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
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		ArrayList<Programare> programari = ProgramariService
				.getAllAppointmentsForDoctor(Integer.parseInt(request.getParameter("doctorID")));
		PacientService ps = new PacientService();
		List<CalendarFEEntry> listOfEvents = new ArrayList<CalendarFEEntry>();
		for (Programare p : programari) {
			Pacient pacientProgramare = (Pacient) ps.getById(p.getIdUser());
			CalendarFEEntry event = new CalendarFEEntry();
			event.setId(p.getId());
			event.setColor("green");

			event.setAllDay(false);
			event.setTitle("Programare pentru " + pacientProgramare.getFirstName() + " "
					+ pacientProgramare.getLastName()
					+" (" + p.getId() + ")");

			int hoursEnd = p.getData().getHours() + 2;
			int months = p.getData().getMonth()+1;
			event.setStart(p.getData().getYear() + 1900 + "-" + months + "-" + p.getData().getDate()
					+ " " + p.getData().getHours() + ":" + p.getData().getMinutes());
			event.setEnd(p.getData().getYear() + 1900 + "-" + months + "-" + p.getData().getDate() + " "
					+ hoursEnd + ":" + p.getData().getMinutes());

			listOfEvents.add(event);

		}

		out.write(new Gson().toJson(listOfEvents));

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
