package org.example.service;

import lombok.RequiredArgsConstructor;
import org.example.repository.MatchParticipantRepository;
import org.example.vo.Article;
import org.example.vo.Member;
import org.example.vo.Team;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class MatchParticipantService {
    @Autowired
    private  MatchParticipantRepository matchParticipantRepository;

    public void join(int matchId, int memberId) {
        matchParticipantRepository.join(matchId, memberId);
    }

    public boolean isAlreadyJoined(int matchId, int memberId) {
        return matchParticipantRepository.isAlreadyJoined(matchId, memberId) > 0;
    }

    public List<Member> getParticipants(int id) {
        return matchParticipantRepository.getParticipants(id);
    }

    public void scJoin(int matchId, int memberId, String position) {
        matchParticipantRepository.scJoin(matchId, memberId, position);
    }

    public void cancelJoin(int matchId, int memberId) {
        matchParticipantRepository.cancelJoin(matchId,memberId);
    }

    public Article getNextMatchForMember(int memberId) {
        return matchParticipantRepository.getNextMatchForMember(memberId);
    }


    // ✅ 팀 단위 참가 신청
    public void joinTeam(int matchId, int teamId) {
        matchParticipantRepository.joinTeam(matchId, teamId);
    }

    // ✅ 팀 중복 참가 여부 확인
    public boolean isTeamAlreadyJoined(int matchId, String teamNm) {
        return matchParticipantRepository.getTeamJoinCount(matchId, teamNm) > 0;
    }


    // ✅ 해당 매치에 신청한 팀 수 반환
    public int getJoinedTeamCount(int matchId) {
        return matchParticipantRepository.getJoinedTeamCount(matchId);
    }

    // ✅ 해당 매치에 참가 신청한 팀 목록 반환
    public List<Team> getJoinedTeams(int matchId) {
        return matchParticipantRepository.getJoinedTeams(matchId);
    }

    public List<Map<String, Object>> getJoinedTeamList(int matchId) {
        return matchParticipantRepository.getJoinedTeamList(matchId);
    }

    public void teamJoin(int matchId, int memberId, int teamId, String teamNm) {
        matchParticipantRepository.teamJoin(matchId, memberId, teamId, teamNm);
    }


    public void cancelTeamJoin(int matchId, String teamNm) {
        matchParticipantRepository.cancelTeamJoin(matchId, teamNm);
    }

    public void teamScJoin(int matchId, int memberId, int teamId, String teamNm) {
        matchParticipantRepository.teamScJoin(matchId, memberId, teamId, teamNm);
    }
}
