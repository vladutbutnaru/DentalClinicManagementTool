package ro.dcmt.data.controllers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ro.dcmt.data.beans.Cabinet;
import ro.dcmt.data.connection.DBConnection;

public class CabinetService implements DBEntityController {
	private static Logger logger = LoggerFactory.getLogger(CabinetService.class);
	private static Connection conn = (Connection) DBConnection.getConnection();
	private static PreparedStatement stmt = null;
	private static ResultSet rs = null;
	public String getPath() throws UnsupportedEncodingException {
		String path = this.getClass().getClassLoader().getResource("").getPath();
		String fullPath = URLDecoder.decode(path, "UTF-8");
		String pathArr[] = fullPath.split("/WEB-INF/classes/");
		
		fullPath = pathArr[0];

		String reponsePath = "";
		// to read a file from webcontent
		reponsePath = fullPath + File.separatorChar;
		return reponsePath;
	}
	public Object getById(int id) {
		Cabinet c = new Cabinet();
		try {

			stmt = conn.prepareStatement("SELECT * FROM cabinete WHERE ID = ?");
			stmt.setInt(1, id);

			rs = stmt.executeQuery();
			if (rs.next()) {
				logger.info("Cabinet Information Fetch: " + id);
				c.setId(id);
				c.setNume(rs.getString(2));
				c.setDescriere(rs.getString(3));
				c.setLocationLat(rs.getDouble(4));
				c.setLocationLong(rs.getDouble(5));
				c.setOras(rs.getString(7));
				c.setOperatii(rs.getString(8));
				c.setPhoneNumber(rs.getString(9));
			
				Blob imageBlob = (rs.getBlob(6));
				InputStream binaryStream = imageBlob.getBinaryStream(1, imageBlob.length());

				
				File f = new File(getPath() + "cabinet" + c.getId() + ".jpg");
				OutputStream out = new FileOutputStream(f);
				byte[] buff = new byte[4096];
				int len = 0;

				while ((len = binaryStream.read(buff)) != -1) {
					out.write(buff, 0, len);
				}
				c.setImage(f);
				out.close();
				return c;

			}

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		} catch (FileNotFoundException e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		} catch (IOException e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		}
		return null;
	
	}

	public ArrayList<Object> getAllByColumn(String column, String value) {
		ArrayList<Object> list= new ArrayList<Object>();
		try {

			stmt = conn.prepareStatement("SELECT * FROM cabinete WHERE "+column+" = ?");
			stmt.setString(1, value);

			rs = stmt.executeQuery();
			if (rs.next()) {
				Cabinet c = new Cabinet();
				logger.info("Cabinet Information Fetch: " + value);
				c.setId(rs.getInt(1));
				c.setNume(rs.getString(2));
				c.setDescriere(rs.getString(3));
				c.setLocationLat(rs.getDouble(4));
				c.setLocationLong(rs.getDouble(5));
				c.setOras(rs.getString(7));
				c.setOperatii(rs.getString(8));
				c.setPhoneNumber(rs.getString(9));
			
				Blob imageBlob = (rs.getBlob(6));
				InputStream binaryStream = imageBlob.getBinaryStream(1, imageBlob.length());

				
				File f = new File(getPath() + "cabinet" + c.getId() + ".jpg");
				OutputStream out = new FileOutputStream(f);
				byte[] buff = new byte[4096];
				int len = 0;

				while ((len = binaryStream.read(buff)) != -1) {
					out.write(buff, 0, len);
				}
				c.setImage(f);
				out.close();
				list.add(c);

			}

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		} catch (FileNotFoundException e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		} catch (IOException e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		}
		return list;
	
	}

	public void delete(int id) {
		// TODO Auto-generated method stub

	}

	public void update(int id) {
		// TODO Auto-generated method stub

	}
	
	
		

}
