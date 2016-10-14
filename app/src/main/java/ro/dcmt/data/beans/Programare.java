package ro.dcmt.data.beans;

import java.io.Serializable;

import java.sql.Timestamp;

public class Programare implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -742310032991520269L;
	private int id;
	private int idDoctor;
	private int idUser;
	private Timestamp data;
	private String idOperatii;
	private boolean aprobat;
	private String comentariu;
	private String canal;
	private boolean respins;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdDoctor() {
		return idDoctor;
	}

	public void setIdDoctor(int idDoctor) {
		this.idDoctor = idDoctor;
	}

	public int getIdUser() {
		return idUser;
	}

	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}

	public Timestamp getData() {
		return data;
	}

	public void setData(Timestamp data) {
		this.data = data;
	}

	public String getIdOperatii() {
		return idOperatii;
	}

	public void setIdOperatii(String idOperatii) {
		this.idOperatii = idOperatii;
	}

	public boolean isAprobat() {
		return aprobat;
	}

	public void setAprobat(boolean aprobat) {
		this.aprobat = aprobat;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getCanal() {
		return canal;
	}

	public void setCanal(String canal) {
		this.canal = canal;
	}

	public String getComentariu() {
		return comentariu;
	}

	public void setComentariu(String comentariu) {
		this.comentariu = comentariu;
	}

	public boolean isRespins() {
		return respins;
	}

	public void setRespins(boolean respins) {
		this.respins = respins;
	}

}
