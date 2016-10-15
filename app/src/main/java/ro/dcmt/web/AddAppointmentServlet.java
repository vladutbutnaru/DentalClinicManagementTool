package ro.dcmt.web;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ro.dcmt.data.beans.Pacient;
import ro.dcmt.data.beans.Programare;
import ro.dcmt.data.controllers.PacientService;
import ro.dcmt.data.controllers.ProgramariService;

/**
 * Servlet implementation class AddAppointmentServlet
 */
public class AddAppointmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddAppointmentServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@SuppressWarnings("deprecation")
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// get string parameters from request
		String numePacient = request.getParameter("numePacient");
		String dataProgramare = request.getParameter("dataProgramare");
		String oraProgramare = request.getParameter("oraProgramare");
		String comentariuProgramare = request.getParameter("comentariuProgramare");
		String[] operatii = request.getParameterValues("values[]");
		// get numeric parameters from request
		int doctorID = Integer.parseInt(request.getParameter("doctorID"));
		int notificationSMS = Integer.parseInt(request.getParameter("notificationSMS"));
		int notificationEmail = Integer.parseInt(request.getParameter("notificationEmail"));
		int notificationMobile = Integer.parseInt(request.getParameter("notificationMobile"));
		// get selected pacient (if exists)
		PacientService ps = new PacientService();
		Pacient p = ps.getPacientByFirstAndLastName(numePacient.split(" ")[0], numePacient.split(" ")[1]);

		// fill new appointment with data and isnert
		Programare programare = new Programare();
		int year = Integer.parseInt(dataProgramare.split("-")[0]);
		int month = Integer.parseInt(dataProgramare.split("-")[1]);
		int day = Integer.parseInt(dataProgramare.split("-")[2]);
		int hour = Integer.parseInt(oraProgramare.split(":")[0]);
		int minute = Integer.parseInt(oraProgramare.split(":")[1]);
		int second = Integer.parseInt(oraProgramare.split(":")[2]);
		String timeStr = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
		Timestamp t = Timestamp.valueOf(timeStr);

		String operatiiProgramare = "";
		for (String operatie : operatii)
			operatiiProgramare += operatie + ",";

		programare.setIdUser(p.getId());
		programare.setCanal("web_doctor");
		programare.setNotificationEmail(notificationEmail == 1);
		programare.setNotificationSMS(notificationSMS == 1);
		programare.setNotificationMobile(notificationMobile == 1);
		programare.setIdDoctor(doctorID);
		programare.setData(t);
		programare.setRespins(false);
		programare.setAprobat(true);
		programare.setIdOperatii(operatiiProgramare);
		programare.setComentariu(comentariuProgramare);

		ProgramariService.insertAppointment(programare);

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
