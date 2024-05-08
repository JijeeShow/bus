package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "bus_call")
public class Request {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @JsonProperty("call_id") 
    private Integer call_id;
    
    @ManyToOne
    @JoinColumn(name = "station_id") 
    @JsonProperty("station") 
    private Station station;

    @JsonProperty("calling")
    private Integer calling;
    
   

	public Integer getCall_id() {
		return call_id;
	}

	public void setCall_id(Integer call_id) {
		this.call_id = call_id;
	}

	public Station getStation() {
		return station;
	}

	public void setStation(Station station) {
		this.station = station;
	}

	public Integer getCalling() {
		return calling;
	}

	public void setCalling(Integer calling) {
		this.calling = calling;
	} 

	

}
