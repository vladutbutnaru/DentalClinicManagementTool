package ro.dcmt.data.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ro.dcmt.data.beans.Programare;
import ro.dcmt.data.beans.User;
import ro.dcmt.data.connection.DBConnection;

public class ProgramariService implements DBEntityController {
	private static Logger logger = LoggerFactory.getLogger(ProgramariService.class);
	private static Connection conn = (Connection) DBConnection.getConnection();
	private static PreparedStatement stmt = null;
	private static ResultSet rs = null;
	private UserService us = new UserService();

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

	public static void insertAppointment(Programare p) {

		try {

			stmt = conn.prepareStatement(
					"INSERT INTO programari(IDDoctor,IDUser,Data,IDOperatii,Aprobat,Canal,Comentariu,Respins,"
							+ "Notification_SMS,Notification_Mobile,Notification_Email)"
							+ " VALUES (?,?,?,?,?,?,?,?,?,?,?)");
			stmt.setInt(1, p.getIdDoctor());
			stmt.setInt(2, p.getIdUser());
			stmt.setTimestamp(3, p.getData());
			stmt.setString(4, p.getIdOperatii());
			if (p.isAprobat())
				stmt.setInt(5, 1);
			else
				stmt.setInt(5, 0);
			
			stmt.setString(6, p.getCanal());
			
			stmt.setString(7, p.getComentariu());
			
			if (p.isRespins())
				stmt.setInt(8, 1);
			else
				stmt.setInt(8, 0);
			
			if (p.isNotificationSMS())
				stmt.setInt(9, 1);
			else
				stmt.setInt(9, 0);
			
			if (p.isNotificationMobile())
				stmt.setInt(10, 1);
			else
				stmt.setInt(10, 0);
			
			if (p.isNotificationEmail())
				stmt.setInt(11, 1);
			else
				stmt.setInt(11, 0);

			stmt.executeUpdate();
			logger.info("insertAppointment: " + p.getCanal());

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}

	}

	public static int getCountofPacientsForDoctor(int id) {
		int number = 0;
		try {

			stmt = conn.prepareStatement(
					"SELECT COUNT(DISTINCT IDUser) AS total FROM programari WHERE IDDoctor = ? AND Respins = 0");
			stmt.setInt(1, id);

			rs = stmt.executeQuery();
			rs.next();
			number = rs.getInt("total");
		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}
		return number;

	}

	public static int getCountofAppointmentsForDoctor(int id) {
		int number = 0;
		try {

			stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM programari WHERE IDDoctor = ? AND Respins = 0");
			stmt.setInt(1, id);

			rs = stmt.executeQuery();
			rs.next();
			number = rs.getInt("total");
		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}
		return number;

	}

	public static ArrayList<Programare> getNewAppointmentsForDoctor(int idDoctor) {
		ArrayList<Programare> programari = new ArrayList<Programare>();
		try {

			stmt = conn.prepareStatement("SELECT * FROM programari WHERE IDDoctor = ? AND Aprobat = 0 AND Respins = 0");
			stmt.setInt(1, idDoctor);

			rs = stmt.executeQuery();
			logger.info("getNewAppointmentsForDoctor: " + idDoctor);
			while (rs.next()) {
				Programare p = new Programare();
				p.setId(rs.getInt(1));
				p.setIdDoctor(rs.getInt(2));
				p.setIdUser(rs.getInt(3));
				p.setData(rs.getTimestamp(4));
				p.setIdOperatii(rs.getString(5));
				p.setAprobat(rs.getInt(6) == 1);
				p.setCanal(rs.getString(7));
				p.setComentariu(rs.getString(8));
				p.setRespins(rs.getInt(9) == 1);
				p.setNotificationSMS(rs.getInt(10) == 1);
				p.setNotificationMobile(rs.getInt(11) == 1);
				p.setNotificationEmail(rs.getInt(12) == 1);
				programari.add(p);
			}
		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}
		return programari;

	}

	public static ArrayList<Programare> getFutureAppointments(int idDoctor) {
		ArrayList<Programare> programari = new ArrayList<Programare>();
		try {
			Date date = new Date();
			Timestamp timestamp = new Timestamp(date.getTime());

			stmt = conn.prepareStatement("SELECT * FROM programari WHERE Data > ? AND Respins = 0");
			stmt.setTimestamp(1, timestamp);

			rs = stmt.executeQuery();
			logger.info("getFutureAppointments: " + idDoctor);
			while (rs.next()) {
				Programare p = new Programare();
				p.setId(rs.getInt(1));
				p.setIdDoctor(rs.getInt(2));
				p.setIdUser(rs.getInt(3));
				p.setData(rs.getTimestamp(4));
				p.setIdOperatii(rs.getString(5));
				p.setAprobat(rs.getInt(6) == 1);
				p.setCanal(rs.getString(7));

				p.setComentariu(rs.getString(8));
				p.setRespins(rs.getInt(9) == 1);
				p.setNotificationSMS(rs.getInt(10) == 1);
				p.setNotificationMobile(rs.getInt(11) == 1);
				p.setNotificationEmail(rs.getInt(12) == 1);
				programari.add(p);
			}
		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}
		return programari;

	}

	@SuppressWarnings("deprecation")
	public static int getNumberOfNewPatients(int idDoctor) {
		int newPatients = 0;
		ArrayList<Programare> programariVechi = new ArrayList<Programare>();

		try {
			Date date = new Date();
			date.setDate(1);

			Timestamp timestamp = new Timestamp(date.getTime());

			stmt = conn.prepareStatement("SELECT * FROM programari WHERE Data < ?");
			stmt.setTimestamp(1, timestamp);

			rs = stmt.executeQuery();
			logger.info("getNumberOfNewPatients: " + idDoctor);
			while (rs.next()) {
				Programare p = new Programare();
				p.setIdUser(rs.getInt(3));
				programariVechi.add(p);

			}
		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}

		try {
			Date date = new Date();
			date.setDate(1);

			Timestamp timestamp = new Timestamp(date.getTime());

			stmt = conn.prepareStatement("SELECT * FROM programari WHERE Data > ?");
			stmt.setTimestamp(1, timestamp);

			rs = stmt.executeQuery();
			logger.info("getNumberOfNewPatients: " + idDoctor);
			while (rs.next()) {
				for (Programare pVeche : programariVechi) {
					if (pVeche.getIdUser() == rs.getInt(3)) {
						break;

					}
					newPatients++;

				}

			}
		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}

		return newPatients;
	}

	public static int getProgramariFromApp(int idDoctor) {
		int number = 0;
		try {

			stmt = conn.prepareStatement("SELECT * FROM programari WHERE Canal = 'Mobile'");

			rs = stmt.executeQuery();
			logger.info("getProgramariFromApp: " + idDoctor);
			while (rs.next()) {
				number++;

			}
		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}

		return number;
	}

	public static ArrayList<Programare> getAppointmentsForPatient(int idPatient) {
		ArrayList<Programare> programari = new ArrayList<Programare>();
		try {

			stmt = conn.prepareStatement("SELECT * FROM programari WHERE IDUser = ? AND Respins = 0 AND Aprobat=1");
			stmt.setInt(1, idPatient);

			rs = stmt.executeQuery();
			logger.info("getAppointmentsForPatient: " + idPatient);
			while (rs.next()) {
				Programare p = new Programare();
				p.setId(rs.getInt(1));
				p.setIdDoctor(rs.getInt(2));
				p.setIdUser(rs.getInt(3));
				p.setData(rs.getTimestamp(4));
				p.setIdOperatii(rs.getString(5));
				p.setAprobat(rs.getInt(6) == 1);
				p.setCanal(rs.getString(7));

				p.setComentariu(rs.getString(8));
				p.setRespins(rs.getInt(9) == 1);
				p.setNotificationSMS(rs.getInt(10) == 1);
				p.setNotificationMobile(rs.getInt(11) == 1);
				p.setNotificationEmail(rs.getInt(12) == 1);
				programari.add(p);
			}
		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}
		return programari;

	}

	public ArrayList<User> getDoctorsForPatient(int idPatient) {
		ArrayList<User> doctors = new ArrayList<User>();
		try {

			stmt = conn.prepareStatement("SELECT DISTINCT(IDDoctor) FROM programari WHERE IDUser = ?");
			stmt.setInt(1, idPatient);

			rs = stmt.executeQuery();
			logger.info("getDoctorsForPatient: " + idPatient);
			while (rs.next()) {
				User doctor = (User) us.getById(rs.getInt(1));
				doctors.add(doctor);

			}
		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}
		return doctors;

	}

	public static void approveAppointment(int idProgramare) {

		try {

			stmt = conn.prepareStatement("UPDATE programari SET Aprobat = 1 WHERE ID = ?");
			stmt.setInt(1, idProgramare);

			stmt.executeUpdate();
			logger.info("approveAppointment: " + idProgramare);

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}

	}

	public static void rejectAppointment(int idProgramare) {

		try {

			stmt = conn.prepareStatement("UPDATE programari SET Respins = 1 WHERE ID = ?");
			stmt.setInt(1, idProgramare);

			stmt.executeUpdate();
			logger.info("approveAppointment: " + idProgramare);

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}

	}

	public static ArrayList<Programare> getAllAppointmentsForDoctor(int idDoctor) {
		ArrayList<Programare> programari = new ArrayList<Programare>();
		try {

			stmt = conn.prepareStatement("SELECT * FROM programari WHERE IDDoctor = ? AND Aprobat = 1");
			stmt.setInt(1, idDoctor);

			rs = stmt.executeQuery();
			logger.info("getAllAppointmentsForDoctor: " + idDoctor);
			while (rs.next()) {
				Programare p = new Programare();
				p.setId(rs.getInt(1));
				p.setIdDoctor(rs.getInt(2));
				p.setIdUser(rs.getInt(3));
				p.setData(rs.getTimestamp(4));
				p.setIdOperatii(rs.getString(5));
				p.setAprobat(rs.getInt(6) == 1);
				p.setCanal(rs.getString(7));
				p.setComentariu(rs.getString(8));
				p.setRespins(rs.getInt(9) == 1);
				p.setNotificationSMS(rs.getInt(10) == 1);
				p.setNotificationMobile(rs.getInt(11) == 1);
				p.setNotificationEmail(rs.getInt(12) == 1);
				programari.add(p);
			}
		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			logger.error(ex.getMessage());
		}
		return programari;

	}

}
