package org.example.service;

import org.example.repository.TeamArticleRepository;
import org.example.repository.TeamRepository;
import org.example.vo.ResultData;
import org.example.vo.Team;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeamService {
    @Autowired
    private TeamRepository teamRepository;

    public Team getTeamByLeaderNickName(String nickName) {
        return teamRepository.getTeamByLeaderNickName(nickName);
    }

    public ResultData registerTeam(String teamName, String area, String teamLeader, String intro, int leaderRank) {
        teamRepository.registerTeam(teamName, area, teamLeader, intro, leaderRank);
        int id = teamRepository.getLastInsertId();
        return ResultData.from("S-1", "팀이 등록되었습니다.", "id", id);
    }


    public List<Team> getAllTeams(int boardId, int itemsInAPage, int page, String searchKeywordTypeCode, String searchKeyword, String area) {
        return teamRepository.getAllTeams(boardId,itemsInAPage,page,searchKeywordTypeCode,searchKeyword,area);
    }
}