package ro.dcmt.data.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ro.dcmt.data.beans.Invoice;
import ro.dcmt.data.beans.Programare;
import ro.dcmt.data.connection.DBConnection;

public class InvoiceService implements DBEntityController {
	private static Logger logger = LoggerFactory.getLogger(InvoiceService.class);
	private static Connection conn = (Connection) DBConnection.getConnection();
	private static PreparedStatement stmt = null;
	private static ResultSet rs = null;

	public Object getById(int id) {
		Invoice o = new Invoice();
		try {

			stmt = conn.prepareStatement("SELECT * FROM invoices WHERE ID = ?");

			stmt.setInt(1, id);
			rs = stmt.executeQuery();
			logger.info("getById: " + id);
			if (rs.next()) {

				o.setId(rs.getInt(1));
				o.setProgramareID(rs.getInt(2));
				o.setData(rs.getTimestamp(3));
				o.setPrice(rs.getDouble(4));

			}

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());

		}
		return o;
	}

	public ArrayList<Object> getAllByColumn(String column, String value) {
		// TODO Auto-generated method stub
		return null;
	}

	public void delete(int id) {
		// TODO Auto-generated method stub

	}

	public void update(int id) {
		// TODO Auto-generated method stub

	}

	public static int insertInvoice(int programareID, double price) {
		int invoiceID = 0;
		try {

			stmt = conn.prepareStatement("INSERT INTO invoices (programareID,Pret)" + " VALUES (?,?)",
					Statement.RETURN_GENERATED_KEYS);
			stmt.setInt(1, programareID);
			stmt.setDouble(2, price);

			invoiceID = stmt.executeUpdate();
			ResultSet generatedKeys = stmt.getGeneratedKeys();
			if (generatedKeys.next()) {
				invoiceID = (generatedKeys.getInt(1));
			}

			logger.info("insertInvoice: " + invoiceID);

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}
		return invoiceID;
	}

	public static ArrayList<Invoice> getInvoicesForDoctor(int idDoctor) {
		ArrayList<Invoice> invoices = new ArrayList<Invoice>();
		ProgramariService ps = new ProgramariService();

		try {

			stmt = conn.prepareStatement("SELECT * FROM invoices");

			rs = stmt.executeQuery();
			logger.info("getInvoicesForDoctor: " + idDoctor);
			while (rs.next()) {
				int appointmentID = rs.getInt(2);
				Programare p = (Programare) ps.getById(appointmentID);
				if (p.getIdDoctor() == idDoctor) {
					Invoice i = new Invoice();
					i.setProgramareID(appointmentID);
					i.setId(rs.getInt(1));
					i.setPrice(rs.getDouble(4));
					i.setData(rs.getTimestamp(3));
					invoices.add(i);

				}
			}

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());

		}

		return invoices;

	}

	public static double getTotalAmountOfMoneyForDoctor(int idDoctor) {
		double sum = 0;
		ArrayList<Programare> programariDoctor = ProgramariService.getAllAppointmentsForDoctor(idDoctor);
		for (Programare p : programariDoctor) {
			try {

				stmt = conn.prepareStatement("SELECT Pret FROM invoices WHERE programareID = ?");
				stmt.setInt(1, p.getId());
				rs = stmt.executeQuery();
				logger.info("getTotalAmountOfMoneyForDoctor: " + idDoctor);
				while (rs.next()) {
					sum += rs.getDouble(1);

				}

			} catch (SQLException ex) {
				// handle any errors
				System.out.println("SQLException: " + ex.getMessage());
				System.out.println("SQLState: " + ex.getSQLState());
				System.out.println("VendorError: " + ex.getErrorCode());
				logger.error(ex.getMessage());

			}
		}
		return sum;

	}

}
