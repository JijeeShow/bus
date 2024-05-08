package com.example.demo.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.Request;

@Repository
public interface RequestRepo extends JpaRepository<Request, Integer> {

	@Query("SELECT r FROM Request r INNER JOIN r.station s WHERE s.stationId = :id")
	public List<Request> findByStationId(@Param("id") int id);
	
	@Query("SELECT s.stationId,IFNULL(COUNT(r.call_id),0) from Request r RIGHT JOIN r.station s GROUP BY s.stationId")
	public List<Object> getCallBusInStation();
	

}
