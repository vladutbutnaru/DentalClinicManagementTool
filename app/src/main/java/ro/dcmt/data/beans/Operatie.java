package ro.dcmt.data.beans;

import java.io.Serializable;

public class Operatie implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5063057458375188151L;
	private int id;
	private String titlu;
	private String descriere;
	private int idCabinet;
	private double pret;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitlu() {
		return titlu;
	}

	public void setTitlu(String titlu) {
		this.titlu = titlu;
	}

	public String getDescriere() {
		return descriere;
	}

	public void setDescriere(String descriere) {
		this.descriere = descriere;
	}

	public int getIdCabinet() {
		return idCabinet;
	}

	public void setIdCabinet(int idCabinet) {
		this.idCabinet = idCabinet;
	}

	public double getPret() {
		return pret;
	}

	public void setPret(double pret) {
		this.pret = pret;
	}

}
