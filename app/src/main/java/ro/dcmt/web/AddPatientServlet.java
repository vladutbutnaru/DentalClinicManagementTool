package ro.dcmt.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ro.dcmt.data.beans.Pacient;
import ro.dcmt.data.controllers.PacientService;
import ro.dcmt.utils.HTMLMailSender;

/**
 * Servlet implementation class AddPatientServlet
 */
public class AddPatientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddPatientServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String prenume = request.getParameter("prenume");
		String nume = request.getParameter("nume");
		String oras = request.getParameter("oras");
		String email = request.getParameter("email");
		String numarTelefon = request.getParameter("numarTelefon");
		PacientService ps = new PacientService();
		Pacient p = new Pacient();
		p.setFirstName(prenume);
		p.setLastName(nume);
		p.setCity(oras);
		p.setEmail(email);
		p.setPhoneNumber(numarTelefon);
		ps.createPacientFromMedicInterface(p);
	
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}