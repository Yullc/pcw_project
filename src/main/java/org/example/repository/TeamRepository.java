package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.example.vo.Team;

import java.util.List;

@Mapper
public interface TeamRepository {

    List<Team> getForPrintTeam(String teamName, String teamRank, String teamLeader);
}
