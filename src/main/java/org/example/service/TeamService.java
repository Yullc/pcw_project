package org.example.service;

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


    public List<Team> getAllTeams(int boardId,int itemsInAPage, int page, String searchKeywordTypeCode, String searchKeyword, int teamRank, String area) {
        int limitForm = (page - 1) * itemsInAPage;
        int limitTake = itemsInAPage;
        return teamRepository.getAllTeams(boardId, limitTake, limitForm, searchKeywordTypeCode, searchKeyword, teamRank, area);
    }


    public int getTeamCount(int boardId, String searchKeywordTypeCode, String searchKeyword) {

        return teamRepository.getTeamCount(boardId, searchKeywordTypeCode, searchKeyword);
    }

    public void updateMemberTeamNm(String teamName, String teamLeader) {
        teamRepository.updateMemberTeamNmByNickName(teamName, teamLeader);
    }

    public boolean hasTeam(String teamLeader) {
        return teamRepository.getTeamCountByLeader(teamLeader) > 0;
    }

    public boolean hasTeamName(String teamName) {
        return teamRepository.getTeamCountByName(teamName) > 0;
    }

    public Team getTeamById(int id) {
        return teamRepository.getTeamById(id);
    }

    public void requestJoin(int teamId, int memberId, String intro) {
    }
}