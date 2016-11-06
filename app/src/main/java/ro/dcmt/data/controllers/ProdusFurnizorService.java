package ro.dcmt.data.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ro.dcmt.data.beans.Operatie;
import ro.dcmt.data.beans.ProdusFurnizor;
import ro.dcmt.data.connection.DBConnection;

public class ProdusFurnizorService {
	private static Logger logger = LoggerFactory.getLogger(ProdusFurnizorService.class);
	private static Connection conn = (Connection) DBConnection.getConnection();
	private static PreparedStatement stmt = null;
	private static ResultSet rs = null;

	public static ArrayList<ProdusFurnizor> getAllProduseFurnizori() {
		ArrayList<ProdusFurnizor> produse = new ArrayList<ProdusFurnizor>();
		try {

			stmt = conn.prepareStatement("SELECT * FROM furnizori_produse");
			

			rs = stmt.executeQuery();
			logger.info("getAllProduseFurnizori: ");
			while (rs.next()) {
			ProdusFurnizor pf = new ProdusFurnizor();
				pf.setId(rs.getInt(1));
				pf.setWebsite(rs.getString(2));
				pf.setCategory(rs.getString(3));
				pf.setName(rs.getString(4));
				pf.setPrice(rs.getString(5));
				pf.setDescription(rs.getString(6));
				pf.setLink(rs.getString(7));
				pf.setProductImage(rs.getString(8));
				produse.add(pf);
			}

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		
	}
		return produse;
	}
	
	
}
