package ro.dcmt.data.beans;

public class Produs {
private int ID;
private String numeProdus;
private String UM;
private double cantitateProdus;
private int idCabinet;
private int idDoctor;
private double maxValue;

public int getID() {
	return ID;
}
public void setID(int iD) {
	ID = iD;
}
public String getNumeProdus() {
	return numeProdus;
}
public void setNumeProdus(String numeProdus) {
	this.numeProdus = numeProdus;
}
public String getUM() {
	return UM;
}
public void setUM(String uM) {
	UM = uM;
}
public double getCantitateProdus() {
	return cantitateProdus;
}
public void setCantitateProdus(double cantitateProdus) {
	this.cantitateProdus = cantitateProdus;
}
public int getIdCabinet() {
	return idCabinet;
}
public void setIdCabinet(int idCabinet) {
	this.idCabinet = idCabinet;
}
public int getIdDoctor() {
	return idDoctor;
}
public void setIdDoctor(int idDoctor) {
	this.idDoctor = idDoctor;
}
public double getMaxValue() {
	return maxValue;
}
public void setMaxValue(double maxValue) {
	this.maxValue = maxValue;
}


}