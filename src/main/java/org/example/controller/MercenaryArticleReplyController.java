package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.example.service.ReactionPointService;
import org.example.service.ReplyService;
import org.example.service.TeamArticleService;
import org.example.util.Ut;
import org.example.vo.Reply;
import org.example.vo.ResultData;
import org.example.vo.Rq;
import org.example.vo.TeamArticle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MercenaryArticleReplyController {
    @Autowired
    private Rq rq;

    @Autowired
    private ReactionPointService reactionPointService;

    @Autowired
    private ReplyService replyService;
    @Autowired
    private TeamArticleService teamArticleService;

    @RequestMapping("/usr/mercenaryReply/doWrite")
    @ResponseBody
    public String doWrite(HttpServletRequest req, String relTypeCode, int relId, String body) {

        Rq rq = (Rq) req.getAttribute("rq");

        if (Ut.isEmptyOrNull(body)) {
            return Ut.jsHistoryBack("F-2", "내용을 입력해주세요");
        }

        ResultData writeReplyRd = replyService.writeReply(rq.getLoginedMemberId(), body, relTypeCode, relId);

        int id = (int) writeReplyRd.getData1();

        return Ut.jsReplace(writeReplyRd.getResultCode(), writeReplyRd.getMsg(), "../mercenaryArticle/findMercenary_detail?id=" + relId);
    }

    @RequestMapping("/usr/mercenaryReply/doModify")
    @ResponseBody
    public String doModify(HttpServletRequest req, int id, String body) {
        System.err.println(id);
        System.err.println(body);
        Rq rq = (Rq) req.getAttribute("rq");

        Reply reply = replyService.getReply(id);

        if (reply == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 댓글은 존재하지 않습니다", id));
        }

        ResultData loginedMemberCanModifyRd = replyService.userCanModify(rq.getLoginedMemberId(), reply);

        if (loginedMemberCanModifyRd.isSuccess()) {
            replyService.modifyReply(id, body);
        }

        reply = replyService.getReply(id);

        return reply.getBody();
    }



    @RequestMapping("/usr/mercenaryReply/doDelete")
    @ResponseBody
    public String doDelete(HttpServletRequest req, int id) {
        Rq rq = (Rq) req.getAttribute("rq");

        // 1. 댓글 먼저 가져오기
        Reply reply = replyService.getReply(id);

        if (reply == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 댓글은 존재하지 않습니다", id));
        }

        // ✅ 2. 댓글이 달린 게시글 ID 꺼내기
        int mercenaryArticleId = reply.getRelId(); // relId가 팀 게시글 ID라고 가정

        // 3. 권한 체크
        ResultData userCanDeleteRd = replyService.userCanDelete(rq.getLoginedMemberId(), reply);
        if (userCanDeleteRd.isFail()) {
            return Ut.jsHistoryBack(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg());
        }

        // 4. 삭제 수행
        replyService.deleteReply(id);

        // 5. 해당 게시글 상세 페이지로 리디렉션
        return Ut.jsReplace(
                userCanDeleteRd.getResultCode(),
                userCanDeleteRd.getMsg(),
                "../mercenaryArticle/findMercenary_detail?id=" + mercenaryArticleId
        );
    }

}
