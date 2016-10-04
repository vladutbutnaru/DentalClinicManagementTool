package ro.dcmt.data.beans;

import java.io.File;
import java.io.Serializable;
import java.sql.Date;

public class User implements Serializable {

	/**
	 * Generated version ID
	 */
	private static final long serialVersionUID = 1L;

	private int id;
	private String email;
	private String firstName;
	private String lastName;
	private boolean isMedic;
	private String phoneNumber;
	private int numberOfLogins;
	private String address;
	private String password;
	private Date dateRegistered;
	private String city;
	private int idCabinet;
	private String oraInceput;
	private String oraSfarsit;
	private File imagine;
	
	
	
	public File getImagine() {
		return imagine;
	}

	public void setImagine(File imagine) {
		this.imagine = imagine;
	}

	public Date getDateRegistered() {
		return dateRegistered;
	}

	public void setDateRegistered(Date dateRegistered) {
		this.dateRegistered = dateRegistered;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public int getIdCabinet() {
		return idCabinet;
	}

	public void setIdCabinet(int idCabinet) {
		this.idCabinet = idCabinet;
	}

	public String getOraInceput() {
		return oraInceput;
	}

	public void setOraInceput(String oraInceput) {
		this.oraInceput = oraInceput;
	}

	public String getOraSfarsit() {
		return oraSfarsit;
	}

	public void setOraSfarsit(String oraSfarsit) {
		this.oraSfarsit = oraSfarsit;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public boolean isMedic() {
		return isMedic;
	}

	public void setMedic(boolean isMedic) {
		this.isMedic = isMedic;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public int getNumberOfLogins() {
		return numberOfLogins;
	}

	public void setNumberOfLogins(int numberOfLogins) {
		this.numberOfLogins = numberOfLogins;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

}
