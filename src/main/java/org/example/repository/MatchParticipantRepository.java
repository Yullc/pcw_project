package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.example.vo.Article;
import org.example.vo.Member;
import org.example.vo.Team;

import java.util.List;
import java.util.Map;

@Mapper
public interface MatchParticipantRepository {

    // 참가자 추가
    void join(int matchId, int memberId);
    void scJoin(int matchId, int memberId, String position);
    // 중복 체크
    int isAlreadyJoined(int matchId, int memberId);

    // 게시글(articleId) 기준 참가자 목록 조회
    List<Member> getParticipants(int id);

    void cancelJoin(int matchId, int memberId);

    Article getNextMatchForMember(int memberId);

    List<Map<String, Object>> getParticipantsForMatchesInOneHour();

    void joinTeam(int matchId, int teamId);

    int isTeamAlreadyJoined(int matchId, int myTeamNm);

    int getJoinedTeamCount(int matchId);

    List<Team> getJoinedTeams(int matchId);

    int getTeamJoinCount(int matchId, String teamNm);

    List<Map<String, Object>> getJoinedTeamList(int matchId);

    void teamJoin(int matchId, int memberId, int teamId, String teamNm);

    void cancelTeamJoin(int matchId, String teamNm);

    void teamScJoin(int matchId, int memberId, int teamId, String teamNm);

    int getParticipantsWithEvaluation(@Param("matchId") int matchId, @Param("memberId") int memberId);

    boolean hasUserEvaluated(int matchId, int memberId, int evaluatorId);

    void markEvaluationComplete(int matchId, int memberId, int evaluatorId);
}