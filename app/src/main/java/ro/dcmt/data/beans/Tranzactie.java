package ro.dcmt.data.beans;

import java.io.Serializable;
import java.sql.Date;

public class Tranzactie implements Serializable {
	/**
		 * 
		 */
	private static final long serialVersionUID = 3008683299923612963L;
	private int id;
	private int idDoctor;
	private int idUser;
	private Date data;
	private double pret;
	private int idOperatie;

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

	public double getPret() {
		return pret;
	}

	public void setPret(double pret) {
		this.pret = pret;
	}

	public int getIdOperatie() {
		return idOperatie;
	}

	public void setIdOperatie(int idOperatie) {
		this.idOperatie = idOperatie;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
