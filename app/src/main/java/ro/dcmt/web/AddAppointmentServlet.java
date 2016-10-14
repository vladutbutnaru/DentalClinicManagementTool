package ro.dcmt.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ro.dcmt.data.beans.Pacient;
import ro.dcmt.data.beans.Programare;
import ro.dcmt.data.controllers.PacientService;

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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String numePacient = request.getParameter("numePacient");
		int doctorID = Integer.parseInt(request.getParameter("doctorID"));
		String dataProgramare = request.getParameter("dataProgramare");
		String oraProgramare = request.getParameter("oraProgramare");
		String values = request.getParameter("values");
		String notificationSMS = request.getParameter("notificationSMS");
		String notificationEmail = request.getParameter("notificationEmail");
		String notificationMobile = request.getParameter("notificationMobile");
		PacientService ps = new PacientService();
		Pacient p = ps.getPacientByFirstAndLastName(numePacient.split(" ")[0], numePacient.split(" ")[1]);
		Programare programare =new Programare();
		programare.setIdUser(doctorID);
		programare.setCanal("web_doctor");
		System.out.println(values);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
