package com.example.demo.entity;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "bus_line")
public class Line {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "line_id")
	@JsonProperty("line_id")
	private Integer line_id;

	@JsonProperty("line_name")
	@Column(name = "line_name")
	private String lineName;

	@JsonProperty("latitude_bus")
	@Column(name = "latitude_bus")
	private float latitude_bus;

	@JsonProperty("longtitude_bus")
	@Column(name = "longtitude_bus")
	private float longtitude_bus;

	@JsonProperty("station_id")
	@Column(name = "station_id")
	private Integer station_id;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "line")
	@JsonSerialize(using = ToStringSerializer.class)
	private Set<Station> station = new HashSet<Station>();

	public Line() {

	}

	public Line(@JsonProperty("line_id") Integer line_id, @JsonProperty("line_name") String lineName,
			@JsonProperty("latitude_bus") float latitude_bus, @JsonProperty("longtitude_bus") float longtitude_bus,
			@JsonProperty("station_id") Integer station_id) {
		this.line_id = line_id;
		this.lineName = lineName;
		this.latitude_bus = latitude_bus;
		this.longtitude_bus = longtitude_bus;
		this.station_id = station_id;
	}

	public Integer getLine_id() {
		return line_id;
	}

	public void setLine_id(Integer line_id) {
		this.line_id = line_id;
	}

	public String getLineName() {
		return lineName;
	}

	public void setLineName(String lineName) {
		this.lineName = lineName;
	}

	public float getLatitude_bus() {
		return latitude_bus;
	}

	public void setLatitude_bus(float latitude_bus) {
		this.latitude_bus = latitude_bus;
	}

	public float getLongtitude_bus() {
		return longtitude_bus;
	}

	public void setLongtitude_bus(float longtitude_bus) {
		this.longtitude_bus = longtitude_bus;
	}

	public Integer getStation_id() {
		return station_id;
	}

	public void setStation_id(Integer station_id) {
		this.station_id = station_id;
	}

	public Set<Station> getStation() {
		return station;
	}

	public void setStation(Set<Station> station) {
		this.station = station;
	}
}