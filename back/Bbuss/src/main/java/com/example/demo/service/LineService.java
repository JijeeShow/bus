package com.example.demo.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.Line;
import com.example.demo.repo.LineRepo;

import jakarta.transaction.Transactional;

@Service
public class LineService {
	@Autowired
	private LineRepo lineRepo ;
	
	
	@Transactional
	public void updateBus(Line line,int pbs, Line ldata) {
		System.out.println(pbs);
		int id = line.getLine_id();
		float lati = line.getLatitude_bus() ;
		float log = line.getLongtitude_bus() ;
		String name = ldata.getLineName() ;
		 
		lineRepo.updateBus(id,name,lati,log,pbs);
	}
	
	public Optional<Line> findById(int id) {
		return  lineRepo.findById(id) ;
		
	}

}
