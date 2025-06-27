package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface TrophyRepository {
    String findSvgByRank(@Param("rank") int rank);
}
