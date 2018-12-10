CREATE TABLE LT_Devices(
  device_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  uid VARCHAR(10) NOT NULL,
  in_use INT NOT NULL,
  deployment_date DATE NOT NULL,
  activation_date DATE NULL,
  deactivation_date DATE NULL,
  decommission_date DATE NULL
);

CREATE TABLE LT_Locations(
  location_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  location VARCHAR(100) NOT NULL,
  in_use INT NOT NULL,
  deployment_date DATE NOT NULL,
  activation_date DATE NULL,
  deactivation_date DATE NULL,
  decommission_date DATE NULL
);

CREATE TABLE LT_Device_placements(
  device_placement_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  location_id INT NOT NULL,
  FOREIGN KEY (location_id) REFERENCES LT_Locations(location_id)
  ON UPDATE CASCADE
  ON DELETE NO ACTION,
  device_id INT NOT NULL,
  FOREIGN KEY (device_id) REFERENCES LT_Devices(device_id)
  ON UPDATE CASCADE
  ON DELETE NO ACTION,
  in_use INT NOT NULL,
  placement_date DATE NULL,
  removal_date DATE NULL
);

CREATE TABLE LT_Sensor_data(
  sensor_data_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  device_placement_id INT NOT NULL,
  FOREIGN KEY (device_placement_id) REFERENCES LT_Device_placements(device_placement_id)
  ON UPDATE CASCADE
  ON DELETE NO ACTION,
  sensor_data INT NOT NULL,
  sensor_data_time TIMESTAMP NOT NULL
);

CREATE TABLE LT_Users(
  user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  user_name VARCHAR(100) NOT NULL,
  psswd VARCHAR(100) NOT NULL,
  in_use INT NOT NULL
);
