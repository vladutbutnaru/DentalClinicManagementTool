package ro.dcmt.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ro.dcmt.data.beans.Produs;
import ro.dcmt.data.controllers.InventarService;

/**
 * Servlet implementation class AddProductInStockServlet
 */
public class AddProductInStockServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProductInStockServlet() {
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
		String numeProdus = request.getParameter("numeProdus");
		String um = request.getParameter("um");
		String cantitateProdus = request.getParameter("cantitate");
		String IDCabinet = request.getParameter("idCabinet");
		String IDDoctor = request.getParameter("idDoctor");
		String maximumValue = request.getParameter("maximumValue");
		
		Produs p = new Produs();
		p.setNumeProdus(numeProdus);
		p.setUM(um);
		p.setCantitateProdus(Double.parseDouble(cantitateProdus));
		p.setIdCabinet(Integer.parseInt(IDCabinet));
		p.setIdDoctor(Integer.parseInt(IDDoctor));
		p.setMaxValue(Double.parseDouble(maximumValue));
		InventarService.addProduct(p);
		
		
		
	}

}
