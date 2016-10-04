package ro.dcmt.data.beans;

import java.io.File;
import java.io.Serializable;
import java.sql.Date;

public class Pacient implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7082787047795445806L;
	private int id;
	private String firstName;
	private String lastName;
	private Date dateOfBirth;
	private String city;
	private String email;
	private String password;
	private int numOfLogins;
	private File imagine;

	public File getImagine() {
		return imagine;
	}

	public void setImagine(File imagine) {
		this.imagine = imagine;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getNumOfLogins() {
		return numOfLogins;
	}

	public void setNumOfLogins(int numOfLogins) {
		this.numOfLogins = numOfLogins;
	}

}
