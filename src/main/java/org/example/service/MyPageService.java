package org.example.service;

import org.example.repository.MemberRepository;
import org.example.repository.MyPageRepository;
import org.example.vo.FtArticle;
import org.example.vo.ResultData;
import org.example.vo.ScArticle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MyPageService {

    @Autowired
    private MyPageRepository myPageRepository;
    @Autowired
    private MemberRepository memberRepository;

    public String getTeamNameByMemberId(int memberId) {
        return memberRepository.findTeamNameByMemberId(memberId);
    }
    public List<FtArticle> getRecentGamesByMemberId(int memberId) {
        return myPageRepository.getRecentGamesByMemberId(memberId);
    }

    public List<ScArticle> getRecentSoccerGamesByMemberId(int memberId) {
        return myPageRepository.getRecentSoccerGamesByMemberId(memberId);
    }


    public ResultData increaseGoodReactionPoint(int memberId) {
        int affectedRow = myPageRepository.increaseGoodReactionPoint(memberId);

        if (affectedRow == 0) {
            return ResultData.from("F-1", "없는 게시물");
        }

        return ResultData.from("S-1", "좋아요 증가", "affectedRow", affectedRow);
    }


    public ResultData decreaseGoodReactionPoint(int memberId) {
        int affectedRow = myPageRepository.decreaseGoodReactionPoint(memberId);

        if (affectedRow == 0) {
            return ResultData.from("F-1", "없는 게시물");
        }

        return ResultData.from("S-1", "좋아요 감소", "affectedRow", affectedRow);
    }
    public int getGoodRP(int memberId) {
        return myPageRepository.getGoodRP(memberId);
    }


//    // (예: 최근 경기 불러오는 메서드도 같이 있을 수 있음)
//    public List<FtArticle> getRecentGamesByMemberId(int memberId) {
//        return myPageRepository.findRecentGames(memberId, 3);
//    }
//
//    public double getMannerTemperature(int memberId) {
//        // TODO: 임시 값. 나중에 계산 로직으로 바꿔도 됨
//        return 36.5;
//    }
}

