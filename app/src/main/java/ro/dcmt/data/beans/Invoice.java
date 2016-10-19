package ro.dcmt.data.beans;

import java.sql.Timestamp;

public class Invoice {
private int id;
private int programareID;
private Timestamp data;
private double price;
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public int getProgramareID() {
	return programareID;
}
public void setProgramareID(int programareID) {
	this.programareID = programareID;
}
public Timestamp getData() {
	return data;
}
public void setData(Timestamp data) {
	this.data = data;
}
public double getPrice() {
	return price;
}
public void setPrice(double price) {
	this.price = price;
}

}
