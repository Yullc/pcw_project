package org.example.service;

import lombok.RequiredArgsConstructor;
import org.example.repository.MatchParticipantRepository;
import org.example.vo.Article;
import org.example.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
}
