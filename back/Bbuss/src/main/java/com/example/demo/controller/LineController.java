package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.entity.Line;
import com.example.demo.entity.Request;
import com.example.demo.entity.Station;
import com.example.demo.service.LineService;
import com.example.demo.service.RequestService;
import com.example.demo.service.StationService;

@RestController
@CrossOrigin
public class LineController {

	@Autowired
	private LineService lineService;

	@Autowired
	private StationService stationservice;

	@Autowired
	private RequestService requestService;

	@PostMapping("/line/updateBus")
	private ResponseEntity<String> updateBus(@RequestBody Line line) {
		System.out.println("update");
		Optional<Line> l = lineService.findById(line.getLine_id());
		int pbs = l.get().getStation_id();
		double earthRadius = 6371;
		double distance = 0.03;
		double d = distance / earthRadius;
		List<Station> stations = stationservice.findByLineId(line.getLine_id());
		System.out.println(stations.get(2).getLatitude());
		System.out.println(stations.get(2).getLongitude());
		System.out.println(stations.get(2).getLatitude() - d);
		System.out.println(stations.get(2).getLongitude() - d);
		System.out.println(stations.get(2).getLatitude() + d);
		System.out.println(stations.get(2).getLongitude() + d);
		System.out.println(line.getLatitude_bus());
		System.out.println(line.getLongtitude_bus() );
		for (int i = 0; i < stations.size(); i++) {
			if (line.getLatitude_bus() >= stations.get(i).getLatitude() - d
					&& line.getLongtitude_bus() >= stations.get(i).getLongitude() - d
					&& line.getLatitude_bus() <= stations.get(i).getLatitude() + d
					&& line.getLongtitude_bus() <= stations.get(i).getLongitude() + d) {
				pbs = stations.get(i).getStationId();

				List<Request> re = requestService.findByStationId(pbs);

				for (Request request : re) {
					requestService.deleteById(request.getCall_id());
				}

				break;

			}

		}
		lineService.updateBus(line, pbs, l.get());
		return new ResponseEntity<String>("OK", HttpStatus.OK);
	}

	@PostMapping("/line/getPersentBusStation")
	private ResponseEntity<String> getPersentBusStation(@RequestBody Map<String, Integer> requestData) {
		int id = requestData.get("id");
		Optional<Line> l = lineService.findById(id);
		String st = "หาไม่เจอ";
		int sid = l.get().getStation_id() + 1;
		if (sid > 27 && id == 1) {
			sid = 16;
		}
		if (sid > 15 && id == 2) {
			sid = 3;
		}
		if (!l.isEmpty()) {
			Optional<Station> station = stationservice.findById(sid);
			st = station.get().getBusStop() + " " + station.get().getStationName();
		}
		return new ResponseEntity<String>(st, HttpStatus.OK);
	}

	@PostMapping("/line/getPositiosBus")
	private ResponseEntity<Object> getPositiosBus(@RequestBody Map<String, Integer> requestData) {
		int id = requestData.get("id");
		Optional<Line> l = lineService.findById(id);
		List<Object> position = new ArrayList<Object>();
		position.add(l.get().getLatitude_bus());
		position.add(l.get().getLongtitude_bus());

		return new ResponseEntity<Object>(position, HttpStatus.OK);
	}

}
