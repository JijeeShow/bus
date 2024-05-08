package com.example.demo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.Station;
import com.example.demo.repo.StationRepo;

@Service
public class StationService {
	
	@Autowired
	private StationRepo stationRepo ;
	
	public Optional<Station> findById(int id) {
		return stationRepo.findById(id);
	}

	public List<Station> findByLineId(int id) {
		
		return stationRepo.findByLineId(id);
	}

}
