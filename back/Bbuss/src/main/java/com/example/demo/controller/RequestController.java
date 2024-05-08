package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.entity.Request;
import com.example.demo.entity.Station;
import com.example.demo.service.RequestService;
import com.example.demo.service.StationService;
import com.fasterxml.jackson.core.util.RequestPayload;

@RestController
@CrossOrigin
public class RequestController {

	@Autowired
	private RequestService requestService;

	@Autowired
	private StationService stationService;



	@PostMapping("/saveCallBus")
	private ResponseEntity<String> saveCallBus(@RequestBody Request request) {
	    System.out.println("in");
	    requestService.save(request);
	    return new ResponseEntity<String>("OK", HttpStatus.OK);
	}
	
	
	@GetMapping("/request/getCallBusInStation")
	private ResponseEntity<List<Object>> getCallBusInStation() {
	    System.out.println("in"); 
	    List<Object> requests =  requestService.getCallBusInStation();
	    return new ResponseEntity<List<Object>>(requests, HttpStatus.OK);
	}
	
	


}
