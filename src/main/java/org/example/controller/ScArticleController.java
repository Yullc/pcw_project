package org.example.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.example.util.MannerUtil;
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
public class ScArticleController {

    private final BeforeActionInterceptor beforeActionInterceptor;

    @Autowired
    private Rq rq;

    @Autowired
    private ScArticleService scArticleService;

    @Autowired
    private MemberService memberService;

    @Autowired
    private BoardService boardService;

    @Autowired
    private ReactionPointService reactionPointService;

    @Autowired
    private WeatherService weatherService;

    @Autowired
    private MatchParticipantService matchParticipantService;



    public ScArticleController(BeforeActionInterceptor beforeActionInterceptor) {
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

    @RequestMapping("/usr/scArticle/soccer_menu")
    public String showList(HttpServletRequest req, Model model,
                           @RequestParam(defaultValue = "1") int page,
                           @RequestParam(defaultValue = "") String searchKeyword,
                           @RequestParam(defaultValue = "") String area,
                           @RequestParam(defaultValue = "") String avgLevel,
                           @RequestParam(defaultValue = "") String playDate,
                           @RequestParam(defaultValue = "") String code) {

        Rq rq = (Rq) req.getAttribute("rq");
        int itemsInAPage = 16;
        int boardId = 2;
        String searchKeywordTypeCode = "stadiumName";
        System.out.println("scController");
        int totalCount = scArticleService.getScArticleCount(boardId, searchKeywordTypeCode, searchKeyword, area, "", playDate,code);
        int pagesCount = (int) Math.ceil(totalCount / (double) itemsInAPage);

        List<ScArticle> scArticles = scArticleService.getForPrintScArticles(
                boardId, itemsInAPage, page, searchKeywordTypeCode, searchKeyword, area, "", playDate,code);
        System.out.println("scArticles 객쳊들"+scArticles);
        int memberId = rq.getLoginedMemberId();
        Member member = memberService.getMemberById(memberId);
        // ✅ avgLevelName 설정
        for (ScArticle f : scArticles) {
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
        }

        if (!avgLevel.isEmpty()) {
            List<ScArticle> filteredList = new ArrayList<>();

            for (ScArticle f : scArticles) {
                if (f.getAvgLevelName() != null && f.getAvgLevelName().startsWith(avgLevel)) {
                    filteredList.add(f);
                }
            }

            scArticles = filteredList;
        }
        System.out.println(member.getProfileImg());
        model.addAttribute("profileImg", member.getProfileImg());
        model.addAttribute("scArticles", scArticles);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("area", area);
        model.addAttribute("avgLevel", avgLevel);
        model.addAttribute("playDate", playDate);
        model.addAttribute("pagesCount", pagesCount);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("page", page);
        model.addAttribute("code", code);
        return "usr/scArticle/soccer_menu";
    }



    @RequestMapping("/usr/scArticle/soccer_detail")
    public String showFootDetail(@RequestParam("id") int id, HttpServletRequest req, Model model) {
        Rq rq = (Rq) req.getAttribute("rq");
        ScArticle scArticle = scArticleService.getScArticleById(id);
        System.out.println("detail 들어옴");
        if (scArticle == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 존재하지 않습니다.", id));
        }

        List<Member> participants = matchParticipantService.getParticipants(id);
        int totalRank = 0;

        for (Member m : participants) {
            int rank = m.getRank();
            m.setRankName(RankUtil.getRankName(rank));
            totalRank += rank;

            // 매너온도 이모지 설정
            String emoji = MannerUtil.getMannerEmoji(m.getManner());
            m.setMannerEmoji(emoji);
        }

        boolean pastMatch = LocalDateTime.now().isAfter(
                LocalDateTime.parse(scArticle.getPlayDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
        );

        if (!participants.isEmpty()) {
            double avg = totalRank / (double) participants.size();
            scArticle.setAvgLevelName(RankUtil.getRankName((int) Math.round(avg)));
        } else {
            scArticle.setAvgLevelName("미정");
        }

        String area = scArticle.getArea();
        LocalDate playDate = LocalDateTime.parse(scArticle.getPlayDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).toLocalDate();
        List<WeatherDto> weatherList = weatherService.getWeatherByAreaAndDate(area, playDate);

        model.addAttribute("scArticle", scArticle);
        model.addAttribute("weatherList", weatherList);
        model.addAttribute("participants", participants);
        model.addAttribute("pastMatch", pastMatch);
        model.addAttribute("isAlreadyJoined", matchParticipantService.isAlreadyJoined(id, rq.getLoginedMemberId()));
        model.addAttribute("boardId", 2);


        return "usr/scArticle/soccer_detail";
    }

    @PostMapping("/usr/scArticle/joinMatch")
    public String joinMatch(@RequestParam("id") int id,
                            @RequestParam("position") String position,
                            HttpServletRequest req) {
        Rq rq = (Rq) req.getAttribute("rq");
        int memberId = rq.getLoginedMemberId();
        System.out.println("scJOinMatch 진입");
        ScArticle article = scArticleService.getScArticleById(id);
        int matchId = article.getId();

        if (!matchParticipantService.isAlreadyJoined(matchId, memberId)) {
            matchParticipantService.scJoin(matchId, memberId, position);
        }
        System.out.println("position"+position);

        return "redirect:/usr/scArticle/soccer_detail?id=" + id;
    }

    @PostMapping("/usr/scArticle/cancelJoin")
    public String cancelJoin(@RequestParam("id") int id, HttpServletRequest req) {
        Rq rq = (Rq) req.getAttribute("rq");
        int memberId = rq.getLoginedMemberId();
        ScArticle article = scArticleService.getScArticleById(id);
        int matchId = article.getId();
        matchParticipantService.cancelJoin(matchId, memberId);
        return "redirect:/usr/scArticle/soccer_detail?id=" + id;
    }

}