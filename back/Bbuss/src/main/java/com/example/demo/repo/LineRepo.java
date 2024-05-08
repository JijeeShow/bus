package com.example.demo.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.Line;
import com.example.demo.entity.Request;

@Repository
public interface LineRepo extends JpaRepository<Line, Integer> {

	@Modifying
	@Query("UPDATE Line l SET l.station_id = :pbs,l.lineName=:name,l.latitude_bus = :lati, l.longtitude_bus = :log WHERE l.line_id = :id")
	void updateBus(@Param("id") int id, @Param("name") String name, @Param("lati") float lati, @Param("log") float log,
			@Param("pbs") int pbs);

}
