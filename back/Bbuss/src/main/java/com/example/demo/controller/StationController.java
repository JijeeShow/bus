package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.entity.Request;
import com.example.demo.entity.Station;
import com.example.demo.service.RequestService;
import com.example.demo.service.StationService;

@RestController
@CrossOrigin
public class StationController {

	@Autowired
	private RequestService requestService;

	@Autowired
	private StationService stationService;
	
	@PostMapping("/station/findByLineId")
	private ResponseEntity<List<Station>> findByLineId(@RequestBody Map<String, Integer> requestData) {
		 int id = requestData.get("id");
	    List<Station> stations = stationService.findByLineId(id);
	    return new ResponseEntity<List<Station>>(stations, HttpStatus.OK);
	}


}
