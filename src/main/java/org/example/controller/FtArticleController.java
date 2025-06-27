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
import java.util.Map;

@Controller
public class FtArticleController {

    private final BeforeActionInterceptor beforeActionInterceptor;

    @Autowired
    private Rq rq;

    @Autowired
    private FtArticleService ftarticleService;

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
    @Autowired
    private TeamService teamService;

    public FtArticleController(BeforeActionInterceptor beforeActionInterceptor) {
        this.beforeActionInterceptor = beforeActionInterceptor;
    }

    @RequestMapping("/usr/ftArticle/foot_menu")
    public String showList(HttpServletRequest req, Model model,
                           @RequestParam(defaultValue = "1") int page,
                           @RequestParam(defaultValue = "") String searchKeyword,
                           @RequestParam(defaultValue = "") String area,
                           @RequestParam(defaultValue = "") String avgLevel,
                           @RequestParam(defaultValue = "") String playDate,
                           @RequestParam(defaultValue = "") String code) {

        Rq rq = (Rq) req.getAttribute("rq");
        int itemsInAPage = 16;
        int boardId = 1;
        String searchKeywordTypeCode = "stadiumName";

        int totalCount = ftarticleService.getFtArticleCount(boardId, searchKeywordTypeCode, searchKeyword, area, "", playDate,code);
        int pagesCount = (int) Math.ceil(totalCount / (double) itemsInAPage);

        List<FtArticle> ftArticles = ftarticleService.getForPrintFtArticles(boardId, itemsInAPage, page, searchKeywordTypeCode, searchKeyword, area, "", playDate, code);
        System.out.println("ftArticles 객쳊들"+ftArticles);
        int memberId = rq.getLoginedMemberId();
        Member member = memberService.getMemberById(memberId);
        // ✅ avgLevelName 설정
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
        }

        if (!avgLevel.isEmpty()) {
            List<FtArticle> filteredList = new ArrayList<>();

            for (FtArticle f : ftArticles) {
                if (f.getAvgLevelName() != null && f.getAvgLevelName().startsWith(avgLevel)) {
                    filteredList.add(f);
                }
            }

            ftArticles = filteredList;
        }

        System.out.println(member.getProfileImg());
        model.addAttribute("profileImg", member.getProfileImg());
        model.addAttribute("ftArticles", ftArticles);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("area", area);
        model.addAttribute("avgLevel", avgLevel);
        model.addAttribute("playDate", playDate);
        model.addAttribute("pagesCount", pagesCount);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("page", page);
        model.addAttribute("code", code);

        return "usr/ftArticle/foot_menu";
    }




    @RequestMapping("/usr/ftArticle/foot_detail")
    public String showFootDetail(@RequestParam("id") int id, HttpServletRequest req, Model model) {
        Rq rq = (Rq) req.getAttribute("rq");
        FtArticle ftArticle = ftarticleService.getFtArticleById(id);

        if (ftArticle == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 존재하지 않습니다.", id));
        }

        List<Member> participants = matchParticipantService.getParticipants(id);
        memberService.attachTrophySvg(participants);

        int totalRank = 0;
        for (Member m : participants) {
            m.setRankName(RankUtil.getRankName(m.getRank()));
            m.setMannerEmoji(MannerUtil.getMannerEmoji(m.getManner()));
            totalRank += m.getRank();
        }

        // 평균 랭크 설정
        if (!participants.isEmpty()) {
            double avg = totalRank / (double) participants.size();
            ftArticle.setAvgLevelName(RankUtil.getRankName((int) Math.round(avg)));
        } else {
            ftArticle.setAvgLevelName("미정");
        }

        // 과거 경기 여부 판단
        boolean pastMatch = LocalDateTime.now().isAfter(
                LocalDateTime.parse(ftArticle.getPlayDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
        );

        // 날씨 정보 불러오기
        String area = ftArticle.getArea();
        LocalDate playDate = LocalDateTime.parse(ftArticle.getPlayDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).toLocalDate();
        List<WeatherDto> weatherList = weatherService.getWeatherByAreaAndDate(area, playDate);

        // 각 참가자에 대한 평가 여부 포함한 리스트 구성
        int matchId = id;
        int evaluatorId = rq.getLoginedMember().getId();

        List<MatchParticipant> participantInfos = new ArrayList<>();
        for (Member m : participants) {
            boolean hasEvaluated = matchParticipantService.hasUserEvaluated(matchId, m.getId(), evaluatorId);
            System.out.println("[평가 체크] evaluatorId=" + evaluatorId + ", targetMemberId=" + m.getId() + ", hasEvaluated=" + hasEvaluated);
            participantInfos.add(new MatchParticipant(m, hasEvaluated));
        }

        // 모델에 필요한 값만 전달
        model.addAttribute("participantInfos", participantInfos);
        model.addAttribute("participantCount", participants.size());
        model.addAttribute("ftArticle", ftArticle);
        model.addAttribute("weatherList", weatherList);
        model.addAttribute("pastMatch", pastMatch);
        model.addAttribute("boardId", 1); // 풋살 게시판
        model.addAttribute("isAlreadyJoined", matchParticipantService.isAlreadyJoined(id, rq.getLoginedMemberId()));

        return "usr/ftArticle/foot_detail";
    }

    @RequestMapping("/usr/ftArticle/footTeam_detail")
    public String showFootTeamDetail(@RequestParam("id") int id, HttpServletRequest req, Model model) {
        Rq rq = (Rq) req.getAttribute("rq");
        FtArticle ftArticle = ftarticleService.getFtArticleById(id);
        System.out.println("[footTeam_detail] 진입");

        if (ftArticle == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 존재하지 않습니다.", id));
        }



        boolean pastMatch = LocalDateTime.now().isAfter(
                LocalDateTime.parse(ftArticle.getPlayDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
        );



        String area = ftArticle.getArea();
        LocalDate playDate = LocalDateTime.parse(ftArticle.getPlayDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).toLocalDate();
        List<WeatherDto> weatherList = weatherService.getWeatherByAreaAndDate(area, playDate);

        int teamCount = matchParticipantService.getJoinedTeamCount(id);


        String myTeamNm = rq.getLoginedMember().getTeamNm();

        System.out.println("myTeamNm"+myTeamNm);

        boolean alreadyJoined = matchParticipantService.isTeamAlreadyJoined(id, myTeamNm);

        List<Map<String, Object>> joinedTeams = matchParticipantService.getJoinedTeamList(id);


// 평균 랭크 이름 추가 변환 (예: 3.4 → 아마추어1)
        for (Map<String, Object> team : joinedTeams) {
            int avgRank = ((Number) team.get("avgRank")).intValue();
            team.put("avgRankName", RankUtil.getRankName(avgRank));
        }
        System.out.println("joinedTeams: " + joinedTeams);
        model.addAttribute("joinedTeams", joinedTeams); // 기존에 participants 쓰고 있으니 그대로 활용

        model.addAttribute("teamCount", teamCount);
        model.addAttribute("alreadyJoined", alreadyJoined);
        model.addAttribute("myTeamNm", myTeamNm);

        model.addAttribute("boardId", 1);
        model.addAttribute("ftArticle", ftArticle);
        model.addAttribute("weatherList", weatherList);

        model.addAttribute("pastMatch", pastMatch);
        model.addAttribute("teamCount", teamCount);
        model.addAttribute("alreadyJoined", alreadyJoined);

        return "usr/ftArticle/footTeam_detail";
    }



    @PostMapping("/usr/ftArticle/joinMatch")
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
        return "redirect:/usr/ftArticle/foot_detail?id=" + id;
    }

    @PostMapping("/usr/ftArticle/teamJoinMatch")
    public String teamJoinMatch(@RequestParam("id") int id, HttpServletRequest req) {
        Rq rq = (Rq) req.getAttribute("rq");
        System.out.println("teamJoinMatch 메서드 진입");

        FtArticle article = ftarticleService.getFtArticleById(id);
        int matchId = article.getId();

        String teamNm = rq.getLoginedMember().getTeamNm();
        int memberId = rq.getLoginedMemberId();

        // 팀 이름이 없으면 참가 불가
        if (teamNm == null || teamNm.isBlank()) {
            return Ut.jsHistoryBack("F-1", "소속된 팀이 없습니다. 팀 먼저 가입해주세요.");
        }

        int teamId = teamService.getTeamIdByName(teamNm);
        // 이미 참가한 팀인지 확인
        if (!matchParticipantService.isTeamAlreadyJoined(matchId, teamNm)) {
            matchParticipantService.teamJoin(matchId, memberId, teamId, teamNm);
        }

        return "redirect:/usr/ftArticle/footTeam_detail?id=" + id;
    }



    @PostMapping("/usr/ftArticle/cancelJoin")
    public String cancelJoin(@RequestParam("id") int id, HttpServletRequest req) {
        Rq rq = (Rq) req.getAttribute("rq");
        int memberId = rq.getLoginedMemberId();
        FtArticle article = ftarticleService.getFtArticleById(id);
        int matchId = article.getId();
        matchParticipantService.cancelJoin(matchId, memberId);
        return "redirect:/usr/ftArticle/foot_detail?id=" + id;
    }

    @PostMapping("/usr/ftArticle/cancelTeamJoin")
    public String cancelTeamJoin(@RequestParam("id") int id, HttpServletRequest req) {
        Rq rq = (Rq) req.getAttribute("rq");
        int matchId = id;
        String teamNm = rq.getLoginedMember().getTeamNm();
        matchParticipantService.cancelTeamJoin(matchId, teamNm);
        return "redirect:/usr/ftArticle/footTeam_detail?id=" + id;
    }


}