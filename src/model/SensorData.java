package model;

import java.sql.Timestamp;

public class SensorData {
	private int sensor_data_id, device_placement_id, sensor_data;
	private Timestamp sensor_data_time;
	private String location, locationName;	
	
	public SensorData() {
		super();		
	}

	public int getSensor_data_id() {
		return sensor_data_id;
	}

	public void setSensor_data_id(int sensor_data_id) {
		this.sensor_data_id = sensor_data_id;
	}

	public int getDevice_placement_id() {
		return device_placement_id;
	}

	public void setDevice_placement_id(int device_placement_id) {
		this.device_placement_id = device_placement_id;
	}

	public int getSensor_data() {
		return sensor_data;
	}

	public void setSensor_data(int sensor_data) {
		this.sensor_data = sensor_data;
	}

	public Timestamp getSensor_data_time() {
		return sensor_data_time;
	}

	public void setSensor_data_time(Timestamp sensor_data_time) {
		this.sensor_data_time = sensor_data_time;
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

	@Override
	public String toString() {
		return "SensorData [sensor_data_id=" + sensor_data_id + ", device_placement_id=" + device_placement_id
				+ ", sensor_data=" + sensor_data + ", sensor_data_time=" + sensor_data_time + ", location=" + location
				+ ", locationName=" + locationName + "]";
	}
}