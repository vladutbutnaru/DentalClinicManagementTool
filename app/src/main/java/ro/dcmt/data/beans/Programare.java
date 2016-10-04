package ro.dcmt.data.beans;

import java.io.Serializable;
import java.sql.Date;

public class Programare implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -742310032991520269L;
	private int id;
	private int idDoctor;
	private int idUser;
	private Date data;
	private int idOperatii;
	private boolean aprobat;

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

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public int getIdOperatii() {
		return idOperatii;
	}

	public void setIdOperatii(int idOperatii) {
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

}
