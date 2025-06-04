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
                           @RequestParam(defaultValue = "") String searchKeyword) {

        Rq rq = (Rq) req.getAttribute("rq");
        System.out.println("foot_menu 컨트롤러 실행");

        int itemsInAPage = 16;
        int boardId = 1;

        // stadiumName으로만 검색하도록 고정
        String searchKeywordTypeCode = "stadiumName";
        System.out.println(searchKeywordTypeCode);
        int totalCount = ftarticleService.getFtArticleCount(boardId, searchKeywordTypeCode, searchKeyword);
        int pagesCount = (int) Math.ceil(totalCount / (double) itemsInAPage);

        List<FtArticle> ftArticles = ftarticleService.getForPrintFtArticles(
                boardId, itemsInAPage, page, searchKeywordTypeCode, searchKeyword);

        model.addAttribute("ftArticles", ftArticles);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("pagesCount", pagesCount);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("page", page);

        return "usr/home/foot_menu";
    }

}