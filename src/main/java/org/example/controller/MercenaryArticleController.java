package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.example.interceptor.BeforeActionInterceptor;
import org.example.service.*;
import org.example.util.RankUtil;
import org.example.util.Ut;
import org.example.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class MercenaryArticleController {
    private final BeforeActionInterceptor beforeActionInterceptor;

    @Autowired
    private Rq rq;

    @Autowired
    private MercenaryArticleService mercenaryArticleService;

    @Autowired
    private MemberService memberService;

    @Autowired
    private ReplyService replyService;

    public MercenaryArticleController(BeforeActionInterceptor beforeActionInterceptor) {
        this.beforeActionInterceptor = beforeActionInterceptor;
    }

    @RequestMapping("/usr/mercenaryArticle/modify")
    public String showModify(HttpServletRequest req, Model model, int id) {
        Rq rq = (Rq) req.getAttribute("rq");

        MercenaryArticle mercenaryArticle = mercenaryArticleService.getForPrintArticle(rq.getLoginedMemberId(), id);

        if (mercenaryArticle == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
        }

        model.addAttribute("mercenaryArticle", mercenaryArticle);
        return "usr/mercenaryArticle/findMercenary_modify";
    }


    // 로그인 체크 -> 유무 체크 -> 권한체크
    @RequestMapping("/usr/mercenaryArticle/doModify")
    @ResponseBody
    public String doModify(HttpServletRequest req, int id, String title, String body) {
        Rq rq = (Rq) req.getAttribute("rq");

        MercenaryArticle mercenaryArticle = mercenaryArticleService.getArticleById(id);

        if (mercenaryArticle == null) {
            return Ut.jsReplace("F-1", Ut.f("%d번 게시글은 없습니다", id), "../mercenaryArticle/findMercenary");
        }

        ResultData userCanModifyRd = mercenaryArticleService.userCanModify(rq.getLoginedMemberId(), mercenaryArticle);

        if (userCanModifyRd.isFail()) {
            return Ut.jsHistoryBack(userCanModifyRd.getResultCode(), userCanModifyRd.getMsg());
        }

        mercenaryArticleService.modifyArticle(id, title, body);

        return Ut.jsReplace("S-1", "수정되었습니다.", "../mercenaryArticle/findMercenary_detail?id=" + id);
    }


    @RequestMapping("/usr/mercenaryArticle/doDelete")
    @ResponseBody
    public String doDelete(HttpServletRequest req, int id) {

        Rq rq = (Rq) req.getAttribute("rq");

        MercenaryArticle mercenaryArticle = mercenaryArticleService.getArticleById(id);

        if (mercenaryArticle == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
        }

        ResultData userCanDeleteRd = mercenaryArticleService.userCanDelete(rq.getLoginedMemberId(),mercenaryArticle);

        if (userCanDeleteRd.isFail()) {
            return Ut.jsHistoryBack(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg());
        }

        if (userCanDeleteRd.isSuccess()) {
            mercenaryArticleService.deleteArticle(id);
        }

        return Ut.jsReplace(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg(), "../mercenaryArticle/findMercenary");
    }

    @RequestMapping("/usr/mercenaryArticle/findMercenary_detail")
    public String showDetail(HttpServletRequest req, Model model, int id) {
        Rq rq = (Rq) req.getAttribute("rq");

        MercenaryArticle mercenaryArticle = mercenaryArticleService.getForPrintArticle(rq.getLoginedMemberId(), id);

        // ✅ avgLevelName 설정 (teamRank → avgLevelName)
        try {
            if (mercenaryArticle.getTeamRank() != null && !mercenaryArticle.getTeamRank().isEmpty()) {
                int level = Integer.parseInt(mercenaryArticle.getTeamRank());
                mercenaryArticle.setAvgLevelName(RankUtil.getRankName(level));
            } else {
                mercenaryArticle.setAvgLevelName("미정");
            }
        } catch (NumberFormatException e) {
            mercenaryArticle.setAvgLevelName("미정");
        }

        // ✅ 댓글 목록 가져오기
        List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMemberId(), "mercenaryArticle", id);
        int repliesCount = replies.size();

        model.addAttribute("replies", replies);
        model.addAttribute("repliesCount", repliesCount);
        model.addAttribute("mercenaryArticle", mercenaryArticle);

        return "usr/mercenaryArticle/findMercenary_detail";
    }


    @RequestMapping("/usr/mercenaryArticle/findMercenary_write")
    public String showWrite(HttpServletRequest req) {

        return "usr/mercenaryArticle/findMercenary_write";
    }

    @RequestMapping("/usr/mercenaryArticle/doWrite")
    @ResponseBody
    public String doWrite(HttpServletRequest req, String title, String body, String area) {
        Rq rq = (Rq) req.getAttribute("rq");

        if (Ut.isEmptyOrNull(title)) {
            return Ut.jsHistoryBack("F-1", "제목을 입력하세요");
        }

        if (Ut.isEmptyOrNull(body)) {
            return Ut.jsHistoryBack("F-2", "내용을 입력하세요");
        }

        int loginedMemberId = rq.getLoginedMemberId();
        Member member = memberService.getMemberById(loginedMemberId); // 닉네임을 얻기 위함



        ResultData doWriteRd = mercenaryArticleService.writeArticle(loginedMemberId, title, body, area);

        int newId = (int) doWriteRd.getData1();
        return Ut.jsReplace(doWriteRd.getResultCode(), doWriteRd.getMsg(), "../mercenaryArticle/findMercenary_detail?id=" + newId);
    }


    @RequestMapping("/usr/mercenaryArticle/findMercenary")
    public String showList(HttpServletRequest req, Model model,
                           @RequestParam(defaultValue = "1") int page,
                           @RequestParam(defaultValue = "title") String searchKeywordTypeCode,
                           @RequestParam(defaultValue = "") String searchKeyword,
                           @RequestParam(defaultValue = "") String avgLevel,
                           @RequestParam(defaultValue = "") String area) throws IOException {

        Rq rq = (Rq) req.getAttribute("rq");
        System.out.println("용병 구하기 리스트 진입");

        int boardId = 4;
        int memberId = rq.getLoginedMemberId();
        Member member = memberService.getMemberById(memberId);

        int itemsInAPage = 10;


        List<MercenaryArticle> mercenaryArticles = mercenaryArticleService.getForPrintArticles(
                boardId, itemsInAPage, page, searchKeywordTypeCode, searchKeyword, area);

        // 등급명 변환
        for (MercenaryArticle t : mercenaryArticles) {
            try {
                if (t.getTeamRank() != null && !t.getTeamRank().isEmpty()) {
                    int level = Integer.parseInt(t.getTeamRank());
                    t.setAvgLevelName(RankUtil.getRankName(level));
                } else {
                    t.setAvgLevelName("미정");
                }
            } catch (NumberFormatException e) {
                t.setAvgLevelName("미정");
            }
        }

        // ✅ 필터링: avgLevel과 area 모두 반영
        List<MercenaryArticle> filteredList = new ArrayList<>();
        for (MercenaryArticle t : mercenaryArticles) {
            boolean matchLevel = avgLevel.isEmpty() || (t.getAvgLevelName() != null && t.getAvgLevelName().startsWith(avgLevel));
            boolean matchArea = area.isEmpty() || (t.getArea() != null && t.getArea().equals(area));

            if (matchLevel && matchArea) {
                filteredList.add(t);
            }
        }

        mercenaryArticles = filteredList;
        int articlesCount = mercenaryArticles.size(); // 필터링 후 개수 계산
        int pagesCount = (int) Math.ceil(articlesCount / (double) itemsInAPage);

        model.addAttribute("profileImg", member.getProfileImg());
        model.addAttribute("pagesCount", pagesCount);
        model.addAttribute("articlesCount", articlesCount);
        model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("mercenaryArticles", mercenaryArticles);
        model.addAttribute("boardId", boardId);
        model.addAttribute("page", page);
        model.addAttribute("avgLevel", avgLevel);
        model.addAttribute("area", area);

        return "usr/mercenaryArticle/findMercenary";
    }

}
