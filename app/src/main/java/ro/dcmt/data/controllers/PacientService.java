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

import ro.dcmt.data.beans.Pacient;
import ro.dcmt.data.connection.DBConnection;

public class PacientService implements DBEntityController{
    private static Logger logger = LoggerFactory.getLogger(PacientService.class);
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
        Pacient p = new Pacient();
        try {

            stmt = conn.prepareStatement("SELECT * FROM pacienti WHERE ID = ?");
            stmt.setInt(1, id);

            rs = stmt.executeQuery();
            if (rs.next()) {
                logger.info("Patient Information Fetch: " + id);
                p.setId(id);
                p.setEmail(rs.getString(6));
                p.setPassword(rs.getString(7));
                p.setFirstName(rs.getString(2));
                p.setLastName(rs.getString(3));
               // u.setDateRegistered(rs.getDate(6));
                p.setCity(rs.getString(5));

                Blob imageBlob = (rs.getBlob(9));
                InputStream binaryStream = imageBlob.getBinaryStream(1, imageBlob.length());


                File f = new File(getPath() + "pacient" + p.getId() + ".jpg");
                OutputStream out = new FileOutputStream(f);
                byte[] buff = new byte[4096];
                int len = 0;

                while ((len = binaryStream.read(buff)) != -1) {
                    out.write(buff, 0, len);
                }
                p.setImagine(f);
                out.close();
                return p;

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
        return null;
    }

    public void delete(int id) {

    }

    public void update(int id) {

    }
}