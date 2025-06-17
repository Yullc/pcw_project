package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.example.vo.Team;

import java.util.List;

@Mapper
public interface TeamRepository {

    Team getTeamByLeaderNickName(String nickName);

    void registerTeam(String teamName, String area, String teamLeader, String intro, int leaderRank);

    int getLastInsertId();

    // TeamRepository.java
    List<Team> getAllTeams(
            @Param("boardId") int boardId,
            @Param("limitTake") int limitTake,
            @Param("limitFrom") int limitFrom,
            @Param("searchKeywordTypeCode") String searchKeywordTypeCode,
            @Param("searchKeyword") String searchKeyword,
            @Param("avgLevel") String avgLevel,
            @Param("area") String area
    );

}
