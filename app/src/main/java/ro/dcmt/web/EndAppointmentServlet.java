package ro.dcmt.web;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ro.dcmt.data.beans.InventarProgramare;
import ro.dcmt.data.beans.Invoice;
import ro.dcmt.data.beans.Produs;
import ro.dcmt.data.controllers.InventarProgramareService;
import ro.dcmt.data.controllers.InventarService;
import ro.dcmt.data.controllers.InvoiceService;

/**
 * Servlet implementation class EndAppointmentServlet
 */
public class EndAppointmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EndAppointmentServlet() {
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
		
		String[] produse = request.getParameterValues("produse[]");
		int doctorID = Integer.parseInt(request.getParameter("idMedic"));
		int programareID = Integer.parseInt(request.getParameter("idProgramare"));
		int generateInvoice = Integer.parseInt(request.getParameter("generateInvoice"));
		int sendInvoice = Integer.parseInt(request.getParameter("sendInvoiceViaEmail"));
		double price = Double.parseDouble(request.getParameter("price"));
		
		for (String productName : produse) {
			if (!productName.equals("") && !productName.isEmpty()) {
				Produs produs = InventarService.getProdusByName(productName.trim(), doctorID);
				InventarProgramare ip = new InventarProgramare();
				ip.setProdusID(produs.getID());
				ip.setProgramareID(programareID);
			
				InventarProgramareService.insertInventarProgramare(ip);
				
			}
		}
	
	
		if (generateInvoice > 0) {
			Invoice i = new Invoice();
			i.setPrice(price);
			i.setProgramareID(programareID);
			i.setId(InvoiceService.insertInvoice(i.getProgramareID(), i.getPrice()));
			String path = "invoice.jsp?invoiceID=" + i.getId();
			System.out.println(path);
			response.getWriter().append(path);
			
			

		} else {
			if (sendInvoice > 0) {
				// TO DO: SEND EMAIL TO PATIENT WITH THE INVOICE

			}
			response.getWriter().append("home.jsp");
		

		}

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
