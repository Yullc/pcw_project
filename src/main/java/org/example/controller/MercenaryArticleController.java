//package org.example.controller;
//
//import jakarta.servlet.http.HttpServletRequest;
//import org.example.interceptor.BeforeActionInterceptor;
//import org.example.service.*;
//import org.example.util.RankUtil;
//import org.example.util.Ut;
//import org.example.vo.*;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.List;
//
//@Controller
//public class MercenaryArticleController {
//    private final BeforeActionInterceptor beforeActionInterceptor;
//
//    @Autowired
//    private Rq rq;
//
//    @Autowired
//    private TeamArticleService teamArticleService;
//    @Autowired
//    private TeamService teamService;
//    @Autowired
//    private BoardService boardService;
//    @Autowired
//    private MemberService memberService;
//    @Autowired
//    private ReactionPointService reactionPointService;
//
//    @Autowired
//    private ReplyService replyService;
//
//    public MercenaryArticleController(BeforeActionInterceptor beforeActionInterceptor) {
//        this.beforeActionInterceptor = beforeActionInterceptor;
//    }
//
//    @RequestMapping("/usr/article/modify")
//    public String showModify(HttpServletRequest req, Model model, int id) {
//        Rq rq = (Rq) req.getAttribute("rq");
//
//        TeamArticle teamArticle = teamArticleService.getForPrintArticle(rq.getLoginedMemberId(), id);
//
//        if (teamArticle == null) {
//            return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
//        }
//
//        model.addAttribute("teamArticle", teamArticle);
//        return "usr/article/findTeam_modify";
//    }
//
//
//    // 로그인 체크 -> 유무 체크 -> 권한체크
//    @RequestMapping("/usr/article/doModify")
//    @ResponseBody
//    public String doModify(HttpServletRequest req, int id, String title, String body) {
//        Rq rq = (Rq) req.getAttribute("rq");
//
//        TeamArticle teamArticle = teamArticleService.getArticleById(id);
//
//        if (teamArticle == null) {
//            return Ut.jsReplace("F-1", Ut.f("%d번 게시글은 없습니다", id), "../article/findTeam");
//        }
//
//        ResultData userCanModifyRd = teamArticleService.userCanModify(rq.getLoginedMemberId(), teamArticle);
//
//        if (userCanModifyRd.isFail()) {
//            return Ut.jsHistoryBack(userCanModifyRd.getResultCode(), userCanModifyRd.getMsg());
//        }
//
//        teamArticleService.modifyArticle(id, title, body);
//
//        return Ut.jsReplace("S-1", "수정되었습니다.", "../article/findTeam_detail?id=" + id);
//    }
//
//
//    @RequestMapping("/usr/article/doDelete")
//    @ResponseBody
//    public String doDelete(HttpServletRequest req, int id) {
//
//        Rq rq = (Rq) req.getAttribute("rq");
//
//        TeamArticle teamArticle = teamArticleService.getArticleById(id);
//
//        if (teamArticle == null) {
//            return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
//        }
//
//        ResultData userCanDeleteRd = teamArticleService.userCanDelete(rq.getLoginedMemberId(),teamArticle);
//
//        if (userCanDeleteRd.isFail()) {
//            return Ut.jsHistoryBack(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg());
//        }
//
//        if (userCanDeleteRd.isSuccess()) {
//            teamArticleService.deleteArticle(id);
//        }
//
//        return Ut.jsReplace(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg(), "../article/findTeam");
//    }
//
//    @RequestMapping("/usr/article/findTeam_detail")
//    public String showDetail(HttpServletRequest req, Model model, int id) {
//        Rq rq = (Rq) req.getAttribute("rq");
//
//        TeamArticle teamArticle = teamArticleService.getForPrintArticle(rq.getLoginedMemberId(), id);
//
//        // ✅ avgLevelName 설정 (teamRank → avgLevelName)
//        try {
//            if (teamArticle.getTeamRank() != null && !teamArticle.getTeamRank().isEmpty()) {
//                int level = Integer.parseInt(teamArticle.getTeamRank());
//                teamArticle.setAvgLevelName(RankUtil.getRankName(level));
//            } else {
//                teamArticle.setAvgLevelName("미정");
//            }
//        } catch (NumberFormatException e) {
//            teamArticle.setAvgLevelName("미정");
//        }
//
//        // ✅ 댓글 목록 가져오기
//        List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMemberId(), "article", id);
//        int repliesCount = replies.size();
//
//        model.addAttribute("replies", replies);
//        model.addAttribute("repliesCount", repliesCount);
//        model.addAttribute("teamArticle", teamArticle);
//
//        return "usr/article/findTeam_detail";
//    }
//
//
//    @RequestMapping("/usr/article/findTeam_write")
//    public String showWrite(HttpServletRequest req) {
//
//        return "usr/article/findTeam_write";
//    }
//
//    @RequestMapping("/usr/article/doWrite")
//    @ResponseBody
//    public String doWrite(HttpServletRequest req, String title, String body) {
//        Rq rq = (Rq) req.getAttribute("rq");
//
//        if (Ut.isEmptyOrNull(title)) {
//            return Ut.jsHistoryBack("F-1", "제목을 입력하세요");
//        }
//
//        if (Ut.isEmptyOrNull(body)) {
//            return Ut.jsHistoryBack("F-2", "내용을 입력하세요");
//        }
//
//        int loginedMemberId = rq.getLoginedMemberId();
//        Member member = memberService.getMemberById(loginedMemberId); // 닉네임을 얻기 위함
//        Team team = teamService.getTeamByLeaderNickName(member.getNickName());
//        int teamId = team.getId();
//
//        ResultData doWriteRd = teamArticleService.writeArticle(loginedMemberId, title, body, teamId);
//
//        int newId = (int) doWriteRd.getData1();
//        return Ut.jsReplace(doWriteRd.getResultCode(), doWriteRd.getMsg(), "../article/findTeam_detail?id=" + newId);
//    }
//
//
//    @RequestMapping("/usr/article/findTeam")
//    public String showList(HttpServletRequest req, Model model,
//                           @RequestParam(defaultValue = "1") int page,
//                           @RequestParam(defaultValue = "title") String searchKeywordTypeCode,
//                           @RequestParam(defaultValue = "") String searchKeyword,  @RequestParam(defaultValue = "") String avgLevel,
//                           @RequestParam(defaultValue = "") String area) throws IOException {
//
//        Rq rq = (Rq) req.getAttribute("rq");
//        System.out.println("팀구하기 리스트 진입");
//
//        int boardId =3;
//
//        int articlesCount = teamArticleService.getArticleCount(boardId, searchKeywordTypeCode, searchKeyword);
//
//        // 한 페이지에 글 10개씩
//        // 글 20 -> 2page
//        // 글 25 -> 3page
//        int itemsInAPage = 10;
//
//        int pagesCount = (int) Math.ceil(articlesCount / (double) itemsInAPage);
//
//        List<TeamArticle> teamArticles = teamArticleService.getForPrintArticles(
//                boardId, itemsInAPage, page, searchKeywordTypeCode, searchKeyword, area);
//        // ✅ teamRank → avgLevelName 으로 변환
//        for (TeamArticle t : teamArticles) {
//            try {
//                if (t.getTeamRank() != null && !t.getTeamRank().isEmpty()) {
//                    int level = Integer.parseInt(t.getTeamRank()); // 숫자로 저장된 경우
//                    t.setAvgLevelName(RankUtil.getRankName(level));
//                } else {
//                    t.setAvgLevelName("미정");
//                }
//            } catch (NumberFormatException e) {
//                t.setAvgLevelName("미정");
//            }
//        }
//
//// ✅ 필터링
//        if (!avgLevel.isEmpty()) {
//            List<TeamArticle> filteredList = new ArrayList<>();
//            for (TeamArticle t : teamArticles) {
//                if (t.getAvgLevelName() != null && t.getAvgLevelName().startsWith(avgLevel)) {
//                    filteredList.add(t);
//                }
//            }
//            teamArticles = filteredList;
//        }
//        System.out.println(teamArticles);
//        model.addAttribute("pagesCount", pagesCount);
//        model.addAttribute("articlesCount", articlesCount);
//        model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
//        model.addAttribute("searchKeyword", searchKeyword);
//        model.addAttribute("teamArticles", teamArticles);
//        model.addAttribute("boardId", boardId);
//        model.addAttribute("page", page);
//        model.addAttribute("avgLevel", avgLevel);
//        model.addAttribute("area", area);
//
//
//        return "usr/article/findTeam";
//    }
//}
