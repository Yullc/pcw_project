package org.example.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.example.util.RankUtil;
import org.example.util.Ut;
import org.example.service.*;
import org.springframework.ui.Model;
import org.example.interceptor.BeforeActionInterceptor;
import org.example.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @Autowired
    private WeatherService weatherService;

    @Autowired
    private MatchParticipantService matchParticipantService;



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
    ) {
        Rq rq = (Rq) req.getAttribute("rq");
        int itemsInAPage = 16;
        int boardId = 1;

        String searchKeywordTypeCode = "stadiumName";

        int totalCount = ftarticleService.getFtArticleCount(boardId, searchKeywordTypeCode, searchKeyword, area, avgLevel, playDate);
        int pagesCount = (int) Math.ceil(totalCount / (double) itemsInAPage);

        List<FtArticle> ftArticles = ftarticleService.getForPrintFtArticles(
                boardId, itemsInAPage, page, searchKeywordTypeCode, searchKeyword, area, avgLevel, playDate);

        // ✅ avgLevel → avgLevelName으로 변환
        for (FtArticle f : ftArticles) {
            try {
                if (f.getAvgLevel() != null && !f.getAvgLevel().isEmpty()) {
                    int level = Integer.parseInt(f.getAvgLevel());
                    f.setAvgLevelName(RankUtil.getRankName(level));
                } else {
                    f.setAvgLevelName("미정");
                }
            } catch (NumberFormatException e) {
                f.setAvgLevelName("미정");
            }
            System.out.println("avgLevel: " + f.getAvgLevel());
            System.out.println("avgLevelName: " + f.getAvgLevelName());

        }

        model.addAttribute("ftArticles", ftArticles);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("area", area);

        model.addAttribute("playDate", playDate);
        model.addAttribute("pagesCount", pagesCount);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("page", page);
        System.out.println("avgLevel"+avgLevel);
        return "usr/home/foot_menu";
    }


    @RequestMapping("/usr/article/foot_detail")
    public String showFootDetail(@RequestParam("id") int id, HttpServletRequest req, Model model) {
        Rq rq = (Rq) req.getAttribute("rq");
        FtArticle ftArticle = ftarticleService.getFtArticleById(id);
        System.out.println("detail 들어옴");
        if (ftArticle == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 존재하지 않습니다.", id));
        }

        List<Member> participants = matchParticipantService.getParticipants(id);
        int totalRank = 0;

        for (Member m : participants) {
            int rank = m.getRank();
            m.setRankName(RankUtil.getRankName(rank));
            totalRank += rank;
        }

        boolean pastMatch = LocalDateTime.now().isAfter(
                LocalDateTime.parse(ftArticle.getPlayDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
        );

        if (!participants.isEmpty()) {
            double avg = totalRank / (double) participants.size();
            ftArticle.setAvgLevelName(RankUtil.getRankName((int) Math.round(avg)));
        } else {
            ftArticle.setAvgLevelName("미정");
        }

        String area = ftArticle.getArea();
        LocalDate playDate = LocalDateTime.parse(ftArticle.getPlayDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).toLocalDate();
        List<WeatherDto> weatherList = weatherService.getWeatherByAreaAndDate(area, playDate);

        model.addAttribute("ftArticle", ftArticle);
        model.addAttribute("weatherList", weatherList);
        model.addAttribute("participants", participants);
        model.addAttribute("pastMatch", pastMatch);
        model.addAttribute("isAlreadyJoined", matchParticipantService.isAlreadyJoined(id, rq.getLoginedMemberId()));


        return "usr/article/foot_detail";
    }






    @PostMapping("/usr/article/joinMatch")
    public String joinMatch(@RequestParam("id") int id, HttpServletRequest req) {
        Rq rq = (Rq) req.getAttribute("rq");
        System.out.println("joinMatch 메서드 진입");

        FtArticle article = ftarticleService.getFtArticleById(id);
        int matchId = article.getId();
        System.out.println("matchId" + matchId);

        int memberId = rq.getLoginedMemberId();
        System.out.println("memberId" + memberId);

        if (!matchParticipantService.isAlreadyJoined(matchId, memberId)) {
            matchParticipantService.join(matchId, memberId);
        }

        // 4. 다시 상세 페이지로 리다이렉트
        return "redirect:/usr/article/foot_detail?id=" + id;
    }




}