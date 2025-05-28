package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.example.vo.PublicResource;

@Mapper
public interface FootballStadiumRepository {
    void save(PublicResource resource);
}