package org.example.controller;
import java.io.IOException;
import java.util.List;

import org.springframework.ui.Model;
import org.example.interceptor.BeforeActionInterceptor;
import org.example.service.BoardService;
import org.example.service.FtArticleService;
import org.example.service.ReactionPointService;
import org.example.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.example.service.MemberService;
import org.example.util.Ut;

import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@Controller
public class FtArticleController {

    private final BeforeActionInterceptor beforeActionInterceptor;

    @Autowired
    private Rq rq;

    @Autowired
    private FtArticleService ftarticleService;

    @Autowired
    private BoardService boardService;

    @Autowired
    private ReactionPointService reactionPointService;




    public FtArticleController(BeforeActionInterceptor beforeActionInterceptor) {
        this.beforeActionInterceptor = beforeActionInterceptor;
    }


//    @RequestMapping("/usr/article/detail")
//    public String showDetail(HttpServletRequest req, Model model, int id) {
//        Rq rq = (Rq) req.getAttribute("rq");
//
//        FtArticle ftArticle = FtArticleService.getForPrintArticle(rq.getLoginedMemberId(), id);
//
//        ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), "article", id);
//
//        if (usersReactionRd.isSuccess()) {
//            model.addAttribute("userCanMakeReaction", usersReactionRd.isSuccess());
//        }
//
//        return "usr/article/detail";
//    }

//    @RequestMapping("/usr/article/doIncreaseHitCountRd")
//    @ResponseBody
//    public ResultData doIncreaseHitCount(int id) {
//
//        ResultData increaseHitCountRd = ftarticleService.increaseHitCount(id);
//
//        if (increaseHitCountRd.isFail()) {
//            return increaseHitCountRd;
//        }
//
//        return ResultData.from(increaseHitCountRd.getResultCode(), increaseHitCountRd.getMsg(), "hitCount",
//                ftarticleService.getArticleHitCount(id), "articleId", id);
//    }

    @RequestMapping("/usr/home/foot_menu")
    public String showList(HttpServletRequest req, Model model,
                           @RequestParam(defaultValue = "1") int page,
                           @RequestParam(defaultValue = "") String searchKeyword,
                           @RequestParam(defaultValue = "") String area,
                           @RequestParam(defaultValue = "") String avgLevel,
                           @RequestParam(defaultValue = "") String playDate
    ){

        Rq rq = (Rq) req.getAttribute("rq");
        int itemsInAPage = 16;
        int boardId = 1;

        String searchKeywordTypeCode = "stadiumName";

        int totalCount = ftarticleService.getFtArticleCount(boardId, searchKeywordTypeCode, searchKeyword, area, avgLevel, playDate);
        int pagesCount = (int) Math.ceil(totalCount / (double) itemsInAPage);

        List<FtArticle> ftArticles = ftarticleService.getForPrintFtArticles(
                boardId, itemsInAPage, page, searchKeywordTypeCode, searchKeyword, area, avgLevel, playDate);

        model.addAttribute("ftArticles", ftArticles);
        System.out.println("ftArticles"+ftArticles);
        model.addAttribute("searchKeyword", searchKeyword);
        System.out.println("searchKeyword"+searchKeyword);
        model.addAttribute("area", area);
        System.out.println("area"+area);
        model.addAttribute("avgLevel", avgLevel);
        System.out.println("avgLevel"+avgLevel);
        model.addAttribute("playDate", playDate);
        System.out.println("playDate"+playDate);
        model.addAttribute("pagesCount", pagesCount);
        System.out.println("pagesCount"+pagesCount);
        model.addAttribute("totalCount", totalCount);
        System.out.println("totalCount"+totalCount);
        model.addAttribute("page", page);
        System.out.println("page"+page);

        return "usr/home/foot_menu";
    }
    @RequestMapping("/usr/article/foot_detail")
    public String showFootDetail(@RequestParam("id") int id,HttpServletRequest req, Model model) {
        // ftArticleService를 통해 ID로 상세 정보 가져오기
        Rq rq = (Rq) req.getAttribute("rq");
        FtArticle ftArticle = ftarticleService.getArticleById(id);

        // null 체크 (존재하지 않는 게시물일 경우 뒤로 보내기)
        if (ftArticle == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 존재하지 않습니다.", id));
        }

        // 모델에 경기장 정보 넣기
        model.addAttribute("ftArticle", ftArticle);

        // 해당 JSP로 이동
        return "usr/article/foot_detail";
    }


}