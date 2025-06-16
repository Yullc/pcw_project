package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.example.vo.Team;

@Mapper
public interface TeamRepository {

    Team getTeamByLeaderNickName(String nickName);

    void registerTeam(String teamName, String area, String teamLeader, String introk, int leaderRank);

    int getLastInsertId();
}
