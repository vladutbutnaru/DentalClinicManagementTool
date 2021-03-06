package ro.dcmt.data.beans;

public class CalendarFEEntry {
	public int id;
	public String title;
	public String start;
	public String end;
	public String color;
	public String description;
	public String pacientName;
	public int idProgramare;
	public boolean allDay;
	
	public boolean isAllDay() {
		return allDay;
	}
	public void setAllDay(boolean allDay) {
		this.allDay = allDay;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getPacientName() {
		return pacientName;
	}
	public void setPacientName(String pacientName) {
		this.pacientName = pacientName;
	}
	public int getIdProgramare() {
		return idProgramare;
	}
	public void setIdProgramare(int idProgramare) {
		this.idProgramare = idProgramare;
	}
	
	

}
