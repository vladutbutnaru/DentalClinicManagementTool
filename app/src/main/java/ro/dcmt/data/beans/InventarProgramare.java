package ro.dcmt.data.beans;

public class InventarProgramare {
private int ID;
private int programareID;
private int produsID;
private double cantitate;

public int getID() {
	return ID;
}
public void setID(int iD) {
	ID = iD;
}
public int getProgramareID() {
	return programareID;
}
public void setProgramareID(int programareID) {
	this.programareID = programareID;
}
public int getProdusID() {
	return produsID;
}
public void setProdusID(int produsID) {
	this.produsID = produsID;
}
public double getCantitate() {
	return cantitate;
}
public void setCantitate(double cantitate) {
	this.cantitate = cantitate;
}

}
