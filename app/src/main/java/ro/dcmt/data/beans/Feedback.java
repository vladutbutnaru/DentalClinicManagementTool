package ro.dcmt.data.beans;

import java.io.Serializable;
import java.sql.Timestamp;

public class Feedback implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2151408540781210301L;

	private int id;
	private int idUser;
	private int idCabinet;
	private int idPacient;
	private int rating;
	private String comentariu;
	private Timestamp data;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIdUser() {
		return idUser;
	}
	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}
	public int getIdCabinet() {
		return idCabinet;
	}
	public void setIdCabinet(int idCabinet) {
		this.idCabinet = idCabinet;
	}
	public int getIdPacient() {
		return idPacient;
	}
	public void setIdPacient(int idPacient) {
		this.idPacient = idPacient;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getComentariu() {
		return comentariu;
	}
	public void setComentariu(String comentariu) {
		this.comentariu = comentariu;
	}
	public Timestamp getData() {
		return data;
	}
	public void setData(Timestamp data) {
		this.data = data;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
