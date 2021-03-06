package ro.dcmt.data.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ro.dcmt.data.beans.Produs;
import ro.dcmt.data.connection.DBConnection;

public class InventarService implements DBEntityController {
	private static Logger logger = LoggerFactory.getLogger(InventarService.class);
	private static Connection conn = (Connection) DBConnection.getConnection();
	private static PreparedStatement stmt = null;
	private static ResultSet rs = null;

	public Object getById(int id) {
		ArrayList<Produs> inventarDoctor = new ArrayList<Produs>();

		try {

			stmt = conn.prepareStatement("SELECT * FROM inventar WHERE ID = ?");
			stmt.setInt(1, id);

			rs = stmt.executeQuery();
			logger.info("getById: " + id);
			while (rs.next()) {
				Produs p = new Produs();
				p.setID(rs.getInt(1));
				p.setNumeProdus(rs.getString(2));
				p.setUM(rs.getString(3));
				p.setCantitateProdus(rs.getDouble(4));
				p.setIdCabinet(rs.getInt(5));
				p.setIdDoctor(rs.getInt(6));
				p.setMaxValue(rs.getDouble(7));
				inventarDoctor.add(p);

			}

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());

		}

		return inventarDoctor.get(0);

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

	public static ArrayList<Produs> getInventarForDoctor(int idDoctor) {
		ArrayList<Produs> inventarDoctor = new ArrayList<Produs>();

		try {

			stmt = conn.prepareStatement("SELECT * FROM inventar WHERE IDDoctor = ?");
			stmt.setInt(1, idDoctor);

			rs = stmt.executeQuery();
			logger.info("getInventarForDoctor: " + idDoctor);
			while (rs.next()) {
				Produs p = new Produs();
				p.setID(rs.getInt(1));
				p.setNumeProdus(rs.getString(2));
				p.setUM(rs.getString(3));
				p.setCantitateProdus(rs.getDouble(4));
				p.setIdCabinet(rs.getInt(5));
				p.setIdDoctor(idDoctor);
				p.setMaxValue(rs.getDouble(7));
				inventarDoctor.add(p);

			}

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());

		}

		return inventarDoctor;

	}

	public static Produs getProdusByName(String productName, int idDoctor) {
		Produs p = new Produs();
		try {

			stmt = conn.prepareStatement("SELECT * FROM inventar WHERE NumeProdus = ? AND IDDoctor = ?");
			stmt.setString(1, productName);
			stmt.setInt(2, idDoctor);
			rs = stmt.executeQuery();
			logger.info("getProdusByName: " + productName);
			if (rs.next()) {

				p.setID(rs.getInt(1));
				p.setNumeProdus(rs.getString(2));
				p.setUM(rs.getString(3));
				p.setCantitateProdus(rs.getDouble(4));
				p.setIdCabinet(rs.getInt(5));
				p.setMaxValue(rs.getDouble(7));
				p.setIdDoctor(idDoctor);

			}

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());

		}
		return p;
	}

	public static void updateProduct(Produs p) {
		try {

			stmt = conn.prepareStatement(
					"UPDATE inventar SET NumeProdus = ? , UM = ? , CantitateProdus = ? , IDCabinet = ? , IDDoctor = ? ,  MaximumValue = ? WHERE ID = ?");
			stmt.setString(1, p.getNumeProdus());
			stmt.setString(2, p.getUM());
			stmt.setDouble(3, p.getCantitateProdus());
			stmt.setInt(4, p.getIdCabinet());
			stmt.setInt(5, p.getIdDoctor());
			stmt.setDouble(6, p.getMaxValue());
			stmt.setInt(7, p.getID());
			stmt.executeUpdate();
			logger.info("updateProduct: " + p.getID());

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());

		}

	}

}
