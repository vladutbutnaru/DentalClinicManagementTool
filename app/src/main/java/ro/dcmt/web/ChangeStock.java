package ro.dcmt.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ro.dcmt.data.beans.Produs;
import ro.dcmt.data.controllers.InventarService;

/**
 * Servlet implementation class ChangeStock
 */
public class ChangeStock extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeStock() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int productID = Integer.parseInt(request.getParameter("productId"));
		double newValue = Double.parseDouble(request.getParameter("valoare"));
		InventarService is = new InventarService();
		Produs p = (Produs) is.getById(productID);
		p.setCantitateProdus(newValue);
		InventarService.updateProduct(p);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
