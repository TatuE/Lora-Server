package model;

import java.sql.Date;

public class Device {
	private int device_id, in_use;
	private String uid;
	private Date deployment_date, activation_date, deactivation_date;
	
	public Device() {
		super();	
	}

	public int getDevice_id() {
		return device_id;
	}

	public void setDevice_id(int device_id) {
		this.device_id = device_id;
	}

	public int getIn_use() {
		return in_use;
	}

	public void setIn_use(int in_use) {
		this.in_use = in_use;
	}
	
	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
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
		return "Device [device_id=" + device_id + ", in_use=" + in_use + ", uid=" + uid + ", deployment_date="
				+ deployment_date + ", activation_date=" + activation_date + ", deactivation_date=" + deactivation_date
				+ "]";
	}	
}