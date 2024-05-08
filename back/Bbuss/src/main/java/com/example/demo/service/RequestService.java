package com.example.demo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.Request;
import com.example.demo.repo.RequestRepo;

@Service
public class RequestService {

	@Autowired
	private RequestRepo requestRepo;

	

	public List<Request> findByStationId(int id) {
		return requestRepo.findByStationId(id);
	}
	public Optional<Request> findById(int id) {
		return requestRepo.findById(id);
	}
	
	public  List<Request> findAll() {
		return requestRepo.findAll();
	}

	public Request save(Request request) {
		return requestRepo.save(request) ;
		
	}
	public List<Object> getCallBusInStation() {
		return requestRepo.getCallBusInStation() ;
	}
	public void deleteById(int pbs) {
		requestRepo.deleteById(pbs); 
		
	}

	
	

}
