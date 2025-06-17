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

    @RequestMapping("/usr/reactionPoint/doGoodReaction")
    @ResponseBody
    public ResultData doGoodReaction(int toMemberId) {
        int fromMemberId = rq.getLoginedMemberId();

        boolean alreadyLiked = reactionPointService.hasLiked(fromMemberId, toMemberId);

        if (alreadyLiked) {
            reactionPointService.deleteLike(fromMemberId, toMemberId);
            int goodRP = myPageService.getGoodRP(toMemberId);
            return ResultData.from("S-1", "좋아요 취소", "goodRP", goodRP);
        } else {
            reactionPointService.addLike(fromMemberId, toMemberId);
            int goodRP = myPageService.getGoodRP(toMemberId);
            return ResultData.from("S-1", "좋아요 완료", "goodRP", goodRP);
        }
    }

}
