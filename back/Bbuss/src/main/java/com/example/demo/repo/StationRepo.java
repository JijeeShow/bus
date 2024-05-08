package com.example.demo.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.Station;

@Repository
public interface StationRepo  extends JpaRepository<Station, Integer>{

	@Query("select s from Station s inner join s.line l where l.line_id = :id")
	public List<Station> findByLineId(@Param("id")int id);

}
