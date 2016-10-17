package ro.dcmt.web;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ro.dcmt.data.beans.Operatie;
import ro.dcmt.data.beans.Pacient;
import ro.dcmt.data.beans.Programare;
import ro.dcmt.data.controllers.OperatieService;
import ro.dcmt.data.controllers.PacientService;
import ro.dcmt.data.controllers.ProgramariService;

/**
 * Servlet implementation class GetAppointmentInfo
 */
public class GetAppointmentInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetAppointmentInfo() {
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
		int id = Integer.parseInt(request.getParameter("appointmentID"));
		String returnText = "";
		ProgramariService ps = new ProgramariService();
		PacientService pacientService = new PacientService();

		Programare p = (Programare) ps.getById(id);
		Pacient pacient = (Pacient) pacientService.getById(p.getIdUser());
		int months = p.getData().getMonth() + 1;
		String dataProgramare = p.getData().getYear() + 1900 + "-" + months + "-" + p.getData().getDate();
		String oraProgramare = p.getData().getHours() + ":" + p.getData().getMinutes() + ":" + p.getData().getSeconds();
		OperatieService os = new OperatieService();
		ArrayList<Operatie> operatiiProgramare = os.getOperatiiForAppointment(p.getIdOperatii());
		returnText = pacient.getFirstName() + " " + pacient.getLastName() + ";" + dataProgramare + ";" + oraProgramare
				+ ";" + p.getComentariu() + ";";

		for (Operatie o : operatiiProgramare) {
			returnText += o.getTitlu() + " ";
		}

		response.getWriter().append(returnText);

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
