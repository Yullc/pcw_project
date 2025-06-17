package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.example.vo.Team;
import org.example.vo.TeamArticle;

import java.util.List;

@Mapper
public interface TeamRepository {

    Team getTeamByLeaderNickName(String nickName);

    void registerTeam(String teamName, String area, String teamLeader, String intro, int leaderRank);

    int getLastInsertId();

    List<Team> getAllTeams(int boardId, int limitTake, int limitForm, String searchKeywordTypeCode, String searchKeyword,  int teamRank,String area);

    int getTeamCount(int boardId,String searchKeywordTypeCode, String searchKeyword);
}
