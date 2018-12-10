package model;

import java.sql.Date;

public class Location {
	private int location_id, in_use;
	private String name, location;
	private Date deployment_date, activation_date, deactivation_date;
	
	public Location() {
		super();
	}

	public int getLocation_id() {
		return location_id;
	}

	public void setLocation_id(int location_id) {
		this.location_id = location_id;
	}

	public int getIn_use() {
		return in_use;
	}

	public void setIn_use(int in_use) {
		this.in_use = in_use;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Date getDeployment_date() {
		return deployment_date;
	}

	public void setDeployment_date(Date deployment_date) {
		this.deployment_date = deployment_date;
	}

	public Date getActivation_date() {
		return activation_date;
	}

	public void setActivation_date(Date activation_date) {
		this.activation_date = activation_date;
	}

	public Date getDeactivation_date() {
		return deactivation_date;
	}

	public void setDeactivation_date(Date deactivation_date) {
		this.deactivation_date = deactivation_date;
	}

	@Override
	public String toString() {
		return "Location [location_id=" + location_id + ", in_use=" + in_use + ", name=" + name + ", location="
				+ location + ", deployment_date=" + deployment_date + ", activation_date=" + activation_date
				+ ", deactivation_date=" + deactivation_date + "]";
	}
}