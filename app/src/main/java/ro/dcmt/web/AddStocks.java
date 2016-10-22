package ro.dcmt.web;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ro.dcmt.data.beans.InventarProgramare;
import ro.dcmt.data.beans.Produs;
import ro.dcmt.data.controllers.InventarProgramareService;
import ro.dcmt.data.controllers.InventarService;

/**
 * Servlet implementation class AddStocks
 */
public class AddStocks extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddStocks() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		InventarService is = new InventarService();
		InventarProgramareService ips = new InventarProgramareService();
		int programareID = Integer.parseInt(request.getParameter("idProgramare"));
		String[] stockValues = request.getParameterValues("stockValues[]");
		ArrayList<InventarProgramare> inventarProgramare = InventarProgramareService.getInventarProgramareForProgramare(programareID);
		int pos = 0;
		for(String value : stockValues){
			double valueNumeric = Double.parseDouble(value);
			Produs p = (Produs) is.getById(inventarProgramare.get(pos).getProdusID());
			p.setCantitateProdus(p.getCantitateProdus() - valueNumeric);
			InventarService.updateProduct(p);
			InventarProgramare ip = (InventarProgramare) ips.getById(inventarProgramare.get(pos++).getID());
			ip.setCantitate(valueNumeric);
			InventarProgramareService.updateInventarProgramare(ip);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
