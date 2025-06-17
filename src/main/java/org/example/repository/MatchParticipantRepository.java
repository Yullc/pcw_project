package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.example.vo.Article;
import org.example.vo.Member;

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
}