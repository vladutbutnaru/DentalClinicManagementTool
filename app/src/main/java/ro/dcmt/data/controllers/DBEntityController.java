package ro.dcmt.data.controllers;

import java.util.ArrayList;

public interface DBEntityController {
	public Object getById(int id);
	public ArrayList<Object> getAllByColumn(String column, String value);
	public void delete(int id);
	public void update(int id);
	
}
