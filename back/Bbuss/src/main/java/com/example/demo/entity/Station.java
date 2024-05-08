package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.annotations.Type;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "bus_station")
public class Station {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "station_id")
	@JsonProperty("station_id") 
	private Integer stationId;

	@ManyToOne
	@JsonProperty("line_id")
	@JoinColumn(name = "line_id")
	private Line line;
	
	@JsonProperty("station_name") 
	@Column(name = "station_name")
	private String stationName;

	@JsonProperty("bus_stop") 
	@Column(name = "bus_stop")
	private String busStop;

	@JsonProperty("latitude") 
	@Column(name = "latitude")
	private float latitude;

	@JsonProperty("longitude") 
	@Column(name = "longtitude")
	private float longitude;
	
	

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "station")
	private Set<Request> request = new HashSet<Request>();

	public Station() {

	}

	public Station(int stationId, Line line, String stationName, String busStop, float latitude, float longitude) {
		this.stationId = stationId;
		this.line = line;
		this.stationName = stationName;
		this.busStop = busStop;
		this.latitude = latitude;
		this.longitude = longitude;
	}

	public int getStationId() {
		return stationId;
	}

	public void setStationId(int stationId) {
		this.stationId = stationId;
	}

	public Line getLine() {
		return line;
	}

	public void setLine(Line line) {
		this.line = line;
	}

	public String getStationName() {
		return stationName;
	}

	public void setStationName(String stationName) {
		this.stationName = stationName;
	}

	public String getBusStop() {
		return busStop;
	}

	public void setBusStop(String busStop) {
		this.busStop = busStop;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(float longitude) {
		this.longitude = longitude;
	}

}
