package ro.dcmt.data.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ro.dcmt.data.connection.DBConnection;

public class ProgramariService implements DBEntityController {
	private static Logger logger = LoggerFactory.getLogger(ProgramariService.class);
	private static Connection conn = (Connection) DBConnection.getConnection();
	private static PreparedStatement stmt = null;
	private static ResultSet rs = null;

	public Object getById(int id) {
		// TODO Auto-generated method stub
		return null;
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

	public int getCountofPacientsForDoctor(int id) {
		int number = 0;
		try {

			stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM programari WHERE IDDoctor = ?");
			stmt.setInt(1, id);

			rs = stmt.executeQuery();
			rs.next();
			number=rs.getInt("total");
		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}
		return number;

	}
}
