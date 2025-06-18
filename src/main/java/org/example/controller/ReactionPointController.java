package org.example.controller;

import org.example.service.MyPageService;
import org.example.service.ReactionPointService;
import org.example.util.Ut;
import org.example.vo.ResultData;
import org.example.vo.Rq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ReactionPointController {

    @Autowired
    private Rq rq;

    @Autowired
    private ReactionPointService reactionPointService;

    @Autowired
    private MyPageService myPageService;

    @PostMapping("/usr/reactionPoint/doGoodReaction")
    @ResponseBody
    public ResultData doGoodReaction(int toMemberId) {
        int fromMemberId = rq.getLoginedMemberId();

        System.out.println("👍 좋아요 요청 도착");
        System.out.println("▶ fromMemberId: " + fromMemberId);
        System.out.println("▶ toMemberId: " + toMemberId);

        boolean alreadyLiked = reactionPointService.hasLiked(fromMemberId, toMemberId);
        System.out.println("▶ 이미 좋아요 했는지 여부: " + alreadyLiked);

        if (alreadyLiked) {
            reactionPointService.deleteLike(fromMemberId, toMemberId);
            System.out.println("❌ 좋아요 취소 완료");

            int goodRP = myPageService.getGoodRP(toMemberId);
            System.out.println("📊 현재 좋아요 수 (취소 후): " + goodRP);
            return ResultData.from("S-1", "좋아요 취소", "goodRP", goodRP);
        } else {
            reactionPointService.addLike(fromMemberId, toMemberId);
            System.out.println("✅ 좋아요 추가 완료");

            int goodRP = myPageService.getGoodRP(toMemberId);
            System.out.println("📊 현재 좋아요 수 (추가 후): " + goodRP);
            return ResultData.from("S-1", "좋아요 완료", "goodRP", goodRP);
        }
    }


}
