package model;

import java.sql.Date;

public class DevicePlacement {
	private int device_placement_id, location_id, device_id, in_use;
	private String location, locationName, deviceUid;
	private Date placement_date;
	
	public DevicePlacement() {
		super();
	}

	public int getDevice_placement_id() {
		return device_placement_id;
	}

	public void setDevice_placement_id(int device_placement_id) {
		this.device_placement_id = device_placement_id;
	}

	public int getLocation_id() {
		return location_id;
	}

	public void setLocation_id(int location_id) {
		this.location_id = location_id;
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

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getLocationName() {
		return locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}

	public String getDeviceUid() {
		return deviceUid;
	}

	public void setDeviceUid(String deviceUid) {
		this.deviceUid = deviceUid;
	}

	public Date getPlacement_date() {
		return placement_date;
	}

	public void setPlacement_date(Date placement_date) {
		this.placement_date = placement_date;
	}

	@Override
	public String toString() {
		return "DevicePlacement [device_placement_id=" + device_placement_id + ", location_id=" + location_id
				+ ", device_id=" + device_id + ", in_use=" + in_use + ", location=" + location + ", locationName="
				+ locationName + ", deviceUid=" + deviceUid + ", placement_date=" + placement_date + "]";
	}	
}