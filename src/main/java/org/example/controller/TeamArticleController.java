package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.example.interceptor.BeforeActionInterceptor;
import org.example.service.*;
import org.example.util.MannerUtil;
import org.example.util.RankUtil;
import org.example.util.Ut;
import org.example.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Controller
public class TeamArticleController {
    private final BeforeActionInterceptor beforeActionInterceptor;

    @Autowired
    private Rq rq;

    @Autowired
    private TeamArticleService teamArticleService;
    @Autowired
    private TeamService teamService;
    @Autowired
    private BoardService boardService;
    @Autowired
    private MemberService memberService;
    @Autowired
    private ReactionPointService reactionPointService;

    @Autowired
    private ReplyService replyService;

    public TeamArticleController(BeforeActionInterceptor beforeActionInterceptor) {
        this.beforeActionInterceptor = beforeActionInterceptor;
    }

    @RequestMapping("/usr/teamArticle/modify")
    public String showModify(HttpServletRequest req, Model model, int id) {
        Rq rq = (Rq) req.getAttribute("rq");

        TeamArticle teamArticle = teamArticleService.getForPrintArticle(rq.getLoginedMemberId(), id);

        if (teamArticle == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
        }

        model.addAttribute("teamArticle", teamArticle);
        return "usr/teamArticle/findTeam_modify";
    }


    // 로그인 체크 -> 유무 체크 -> 권한체크
    @RequestMapping("/usr/teamArticle/doModify")
    @ResponseBody
    public String doModify(HttpServletRequest req, int id, String title, String body) {
        Rq rq = (Rq) req.getAttribute("rq");

        TeamArticle teamArticle = teamArticleService.getArticleById(id);

        if (teamArticle == null) {
            return Ut.jsReplace("F-1", Ut.f("%d번 게시글은 없습니다", id), "../teamArticle/findTeam");
        }

        ResultData userCanModifyRd = teamArticleService.userCanModify(rq.getLoginedMemberId(), teamArticle);

        if (userCanModifyRd.isFail()) {
            return Ut.jsHistoryBack(userCanModifyRd.getResultCode(), userCanModifyRd.getMsg());
        }

        System.out.println("🔥 modifyArticle 서비스 호출 전");
        teamArticleService.modifyArticle(id, title, body);
        System.out.println("🔥 modifyArticle 서비스 호출 후");

        System.out.println("📥 받은 ID: " + id);
        System.out.println("📥 받은 제목: " + title);
        System.out.println("📥 받은 내용: " + body);
        return Ut.jsReplace("S-1", "수정되었습니다.", "../teamArticle/findTeam_detail?id=" + id);
    }


    @RequestMapping("/usr/teamArticle/doDelete")
    @ResponseBody
    public String doDelete(HttpServletRequest req, int id) {

        Rq rq = (Rq) req.getAttribute("rq");

        TeamArticle teamArticle = teamArticleService.getArticleById(id);

        if (teamArticle == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
        }

        ResultData userCanDeleteRd = teamArticleService.userCanDelete(rq.getLoginedMemberId(),teamArticle);

        if (userCanDeleteRd.isFail()) {
            return Ut.jsHistoryBack(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg());
        }

        if (userCanDeleteRd.isSuccess()) {
            teamArticleService.deleteArticle(id);
        }

        return Ut.jsReplace(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg(), "../teamArticle/findTeam");
    }

    @RequestMapping("/usr/teamArticle/findTeam_detail")
    public String showDetail(HttpServletRequest req, Model model, int id) {
        Rq rq = (Rq) req.getAttribute("rq");

        TeamArticle teamArticle = teamArticleService.getForPrintArticle(rq.getLoginedMemberId(), id);

        // ✅ avgLevelName 설정 (teamRank → avgLevelName)
        try {
            if (teamArticle.getTeamRank() != null && !teamArticle.getTeamRank().isEmpty()) {
                int level = Integer.parseInt(teamArticle.getTeamRank());
                teamArticle.setAvgLevelName(RankUtil.getRankName(level));
            } else {
                teamArticle.setAvgLevelName("미정");
            }
        } catch (NumberFormatException e) {
            teamArticle.setAvgLevelName("미정");
        }

        // ✅ 댓글 목록 가져오기
        List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMemberId(), "teamArticle", id);
        int repliesCount = replies.size();

        model.addAttribute("replies", replies);
        model.addAttribute("repliesCount", repliesCount);
        model.addAttribute("teamArticle", teamArticle);

        return "usr/teamArticle/findTeam_detail";
    }


    @RequestMapping("/usr/teamArticle/findTeam_write")
    public String showWrite(HttpServletRequest req) {

        return "usr/teamArticle/findTeam_write";
    }

    @RequestMapping("/usr/teamArticle/doWrite")
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
        Team team = teamService.getTeamByLeaderNickName(member.getNickName());

        int teamId = team.getId();

        ResultData doWriteRd = teamArticleService.writeArticle(loginedMemberId, title, body, teamId, area);

        int newId = (int) doWriteRd.getData1();
        return Ut.jsReplace(doWriteRd.getResultCode(), doWriteRd.getMsg(), "../teamArticle/findTeam_detail?id=" + newId);
    }
    @RequestMapping("/usr/teamArticle/teamRegister")
    public String showRegister(HttpServletRequest req) {

        return "usr/teamArticle/teamRegister";
    }
    @RequestMapping("/usr/teamArticle/doRegister")
    @ResponseBody
    public String doRegister(HttpServletRequest req, String teamName, String area, String teamLeader, String intro,
                             Model model) {
        Rq rq = (Rq) req.getAttribute("rq");
        System.out.println("팀 등록 진입");
        if (Ut.isEmptyOrNull(teamName)) {
            return Ut.jsHistoryBack("F-1", "팀 이름을 입력해주세요.");
        }

        if (Ut.isEmptyOrNull(area)) {
            return Ut.jsHistoryBack("F-2", "지역을 선택해주세요.");
        }

        if (Ut.isEmptyOrNull(teamLeader)) {
            return Ut.jsHistoryBack("F-3", "팀 리더를 입력해주세요.");
        }
        Member member = memberService.getMemberById(rq.getLoginedMemberId());
        int leaderRank = member.getRank();
        if (teamService.hasTeam(teamLeader)) {
            return Ut.jsHistoryBack("F-1", "이미 등록한 팀이 있습니다.");
        }
        if (teamService.hasTeamName(teamName)) {
            return Ut.jsHistoryBack("F-2", "이미 존재하는 팀 이름입니다.");
        }
        // 팀 등록
        ResultData doRegisterRd = teamService.registerTeam(teamName, area, teamLeader, intro,leaderRank);
        int teamId = (int) doRegisterRd.getData1();






        // 팀 리더의 nickName 기준으로 member 테이블의 teamNm 컬럼 업데이트
        teamService.updateMemberTeamNm(teamName, teamLeader);


        return Ut.jsReplace(doRegisterRd.getResultCode(), doRegisterRd.getMsg(), "/usr/teamArticle/findTeam");
    }
//    @RequestMapping("/usr/teamArticle/findTeam_detail")
//    public String showTeamDetail(@RequestParam("id") int teamId, Model model) {
//        // 팀 정보
//        Team team = teamService.getTeamById(teamId);
//        model.addAttribute("team", team);
//
//        // 팀원 정보
//        List<Member> participants = teamMemberService.getMembersByTeamId(teamId);
//        model.addAttribute("participants", participants);
//
//        // 평균 랭크 계산
//        int total = 0;
//        for (Member m : participants) {
//            total += m.getRank(); // DB에서 가져온 숫자 랭크
//            m.setRankName(RankUtil.getRankName(m.getRank())); // 각 멤버도 세팅
//        }
//
//        String avgLevelName = "없음";
//        if (!participants.isEmpty()) {
//            float avg = (float) total / participants.size();
//            int rounded = Math.round(avg); // 반올림
//            avgLevelName = RankUtil.getRankName(rounded);
//        }
//
//        model.addAttribute("avgLevelName", avgLevelName);
//
//        return "usr/teamArticle/findTeam_detail";
//    }


    @RequestMapping("/usr/teamArticle/findTeam")
    public String showList(HttpServletRequest req, Model model,
                           @RequestParam(defaultValue = "1") int page,
                           @RequestParam(defaultValue = "title") String searchKeywordTypeCode,
                           @RequestParam(defaultValue = "") String searchKeyword,  @RequestParam(defaultValue = "") String avgLevel,
                           @RequestParam(defaultValue = "") String area) throws IOException {

        Rq rq = (Rq) req.getAttribute("rq");
        System.out.println("팀구하기 리스트 진입");

        int boardId =3;
        int articlesCount = teamArticleService.getArticleCount(boardId, searchKeywordTypeCode, searchKeyword);
        int memberId = rq.getLoginedMemberId();
        Member member = memberService.getMemberById(memberId);
        // 한 페이지에 글 10개씩
        // 글 20 -> 2page
        // 글 25 -> 3page
        int itemsInAPage = 10;

        int pagesCount = (int) Math.ceil(articlesCount / (double) itemsInAPage);

        List<TeamArticle> teamArticles = teamArticleService.getForPrintArticles(boardId, itemsInAPage, page, searchKeywordTypeCode, searchKeyword, area);
        // ✅ teamRank → avgLevelName 으로 변환
        for (TeamArticle t : teamArticles) {
            try {
                if (t.getTeamRank() != null && !t.getTeamRank().isEmpty()) {
                    int level = Integer.parseInt(t.getTeamRank()); // 숫자로 저장된 경우
                    t.setAvgLevelName(RankUtil.getRankName(level));
                } else {
                    t.setAvgLevelName("미정");
                }
            } catch (NumberFormatException e) {
                t.setAvgLevelName("미정");
            }
        }

// ✅ 필터링
        if (!avgLevel.isEmpty()) {
            List<TeamArticle> filteredList = new ArrayList<>();
            for (TeamArticle t : teamArticles) {
                if (t.getAvgLevelName() != null && t.getAvgLevelName().startsWith(avgLevel)) {
                    filteredList.add(t);
                }
            }
            teamArticles = filteredList;
        }
        System.out.println(teamArticles);
        model.addAttribute("profileImg", member.getProfileImg());
        model.addAttribute("pagesCount", pagesCount);
        model.addAttribute("articlesCount", articlesCount);
        model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("teamArticles", teamArticles);
        model.addAttribute("boardId", boardId);
        model.addAttribute("page", page);
        model.addAttribute("avgLevel", avgLevel);
        model.addAttribute("area", area);


        return "usr/teamArticle/findTeam";
    }

    @RequestMapping("/usr/teamArticle/teamList")
    public String showTeamList(HttpServletRequest req, Model model,
                               @RequestParam(defaultValue = "1") int page,
                               @RequestParam(defaultValue = "teamName") String searchKeywordTypeCode,
                               @RequestParam(defaultValue = "") String searchKeyword,
                               @RequestParam(defaultValue = "") String avgLevel,
                               @RequestParam(defaultValue = "") String area) throws IOException {

        Rq rq = (Rq) req.getAttribute("rq");
        System.out.println("팀 목록 진입");
        int boardId = 5;
        int memberId = rq.getLoginedMemberId();
        Member member = memberService.getMemberById(memberId);

        int itemsInAPage = 10;
        int articlesCount = teamService.getTeamCount(boardId, searchKeywordTypeCode, searchKeyword);
        int pagesCount = (int) Math.ceil(articlesCount / (double) itemsInAPage);

        List<Team> teams = teamService.getAllTeams(boardId, itemsInAPage, page, searchKeywordTypeCode, searchKeyword, 0, area);

        // ✅ avgLevelName 설정
        for (Team t : teams) {
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

        // ✅ avgLevel 필터링 (루키 / 아마추어 / 세미프로 / 프로)
        if (avgLevel != null && !avgLevel.isEmpty()) {
            List<Team> filteredList = new ArrayList<>();

            for (Team t : teams) {
                if (t.getAvgLevelName() != null && t.getAvgLevelName().startsWith(avgLevel)) {
                    filteredList.add(t);
                }
            }

            teams = filteredList;
        }

        model.addAttribute("profileImg", member.getProfileImg());
        model.addAttribute("pagesCount", pagesCount);
        model.addAttribute("articlesCount", articlesCount);
        model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("teams", teams);
        model.addAttribute("page", page);
        model.addAttribute("avgLevel", avgLevel); // ✅ avgLevel 그대로 넘김
        model.addAttribute("area", area);

        return "usr/teamArticle/teamList";
    }

//    @RequestMapping("/usr/teamArticle/teamDetail")
//    public String showTeamDetail(@RequestParam("id") int id, HttpServletRequest req, Model model) {
//        Rq rq = (Rq) req.getAttribute("rq");
//        System.out.println("detail 들어옴");
//
//        List<Member> participants = matchParticipantService.getParticipants(id);
//        for (Member m : participants) {
//            System.out.println("참가자: " + m.getNickName() + " / id=" + m.getId());
//        }
//
//        int totalRank = 0;
//
//        for (Member m : participants) {
//            int rank = m.getRank();
//            m.setRankName(RankUtil.getRankName(rank));
//            totalRank += rank;
//
//            // 매너온도 이모지 설정
//            String emoji = MannerUtil.getMannerEmoji(m.getManner());
//            m.setMannerEmoji(emoji);
//        }
//
//        boolean pastMatch = LocalDateTime.now().isAfter(
//                LocalDateTime.parse(ftArticle.getPlayDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
//        );
//
//        if (!participants.isEmpty()) {
//            double avg = totalRank / (double) participants.size();
//            ftArticle.setAvgLevelName(RankUtil.getRankName((int) Math.round(avg)));
//        } else {
//            ftArticle.setAvgLevelName("미정");
//        }
//
//        String area = ftArticle.getArea();
//        LocalDate playDate = LocalDateTime.parse(ftArticle.getPlayDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).toLocalDate();
//        List<WeatherDto> weatherList = weatherService.getWeatherByAreaAndDate(area, playDate);
//        model.addAttribute("boardId", 1); // 1 = 풋살 게시판
//
//        model.addAttribute("ftArticle", ftArticle);
//        model.addAttribute("weatherList", weatherList);
//        model.addAttribute("participants", participants);
//        model.addAttribute("pastMatch", pastMatch);
//        model.addAttribute("isAlreadyJoined", matchParticipantService.isAlreadyJoined(id, rq.getLoginedMemberId()));
//
//
//        return "usr/ftArticle/foot_detail";
//    }


}