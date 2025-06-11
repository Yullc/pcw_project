package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.example.interceptor.BeforeActionInterceptor;
import org.example.service.BoardService;
import org.example.service.ReactionPointService;
import org.example.service.TeamArticleService;
import org.example.util.Ut;
import org.example.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.List;

@Controller
public class TeamArticleController {
    private final BeforeActionInterceptor beforeActionInterceptor;

    @Autowired
    private Rq rq;

    @Autowired
    private TeamArticleService teamArticleService;

    @Autowired
    private BoardService boardService;

    @Autowired
    private ReactionPointService reactionPointService;


    public TeamArticleController(BeforeActionInterceptor beforeActionInterceptor) {
        this.beforeActionInterceptor = beforeActionInterceptor;
    }

    @RequestMapping("/usr/team/modify")
    public String showModify(HttpServletRequest req, Model model, int id) {

        Rq rq = (Rq) req.getAttribute("rq");

        TeamArticle teamArticle = teamArticleService.getForPrintArticle(rq.getLoginedMemberId(), id);

        if (teamArticle == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
        }

        model.addAttribute("article", teamArticle);

        return "/usr/article/modify";
    }

    // 로그인 체크 -> 유무 체크 -> 권한체크
    @RequestMapping("/usr/article/doModify")
    @ResponseBody
    public String doModify(HttpServletRequest req, int id, String title, String body) {

        Rq rq = (Rq) req.getAttribute("rq");

        TeamArticle teamArticle = teamArticleService.getArticleById(id);

        if (teamArticle == null) {
            return Ut.jsReplace("F-1", Ut.f("%d번 게시글은 없습니다", id), "../article/list");
        }

        ResultData userCanModifyRd = teamArticleService.userCanModify(rq.getLoginedMemberId(), teamArticle);

        if (userCanModifyRd.isFail()) {
            return Ut.jsHistoryBack(userCanModifyRd.getResultCode(), userCanModifyRd.getMsg());
        }

        if (userCanModifyRd.isSuccess()) {
            teamArticleService.modifyArticle(id, title, body);
        }

        teamArticle = teamArticleService.getArticleById(id);

        return Ut.jsReplace(userCanModifyRd.getResultCode(), userCanModifyRd.getMsg(), "../article/detail?id=" + id);
    }

    @RequestMapping("/usr/article/doDelete")
    @ResponseBody
    public String doDelete(HttpServletRequest req, int id) {

        Rq rq = (Rq) req.getAttribute("rq");

        TeamArticle teamArticle = teamArticleService.getArticleById(id);

        if (teamArticle == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
        }

        ResultData userCanDeleteRd = teamArticleService.userCanModify(rq.getLoginedMemberId(),teamArticle);

        if (userCanDeleteRd.isFail()) {
            return Ut.jsHistoryBack(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg());
        }

        if (userCanDeleteRd.isSuccess()) {
            teamArticleService.deleteArticle(id);
        }

        return Ut.jsReplace(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg(), "../article/list");
    }

    @RequestMapping("/usr/article/detail")
    public String showDetail(HttpServletRequest req, Model model, int id) {
        Rq rq = (Rq) req.getAttribute("rq");

        TeamArticle teamArticle = teamArticleService.getForPrintArticle(rq.getLoginedMemberId(), id);







        model.addAttribute("article", teamArticle);

        return "usr/article/detail";
    }


    @RequestMapping("/usr/article/write")
    public String showWrite(HttpServletRequest req) {

        return "usr/article/write";
    }

    @RequestMapping("/usr/article/doWrite")
    @ResponseBody
    public String doWrite(HttpServletRequest req, String title, String body, String boardId) {

        Rq rq = (Rq) req.getAttribute("rq");

        if (Ut.isEmptyOrNull(title)) {
            return Ut.jsHistoryBack("F-1", "제목을 입력하세요");
        }

        if (Ut.isEmptyOrNull(body)) {
            return Ut.jsHistoryBack("F-2", "내용을 입력하세요");
        }

        if (Ut.isEmptyOrNull(boardId)) {
            return Ut.jsHistoryBack("F-3", "게시판을 선택하세요");
        }

        ResultData doWriteRd = teamArticleService.writeArticle(rq.getLoginedMemberId(), title, body, boardId);

        int id = (int) doWriteRd.getData1();

        TeamArticle teamArticle = teamArticleService.getArticleById(id);

        return Ut.jsReplace(doWriteRd.getResultCode(), doWriteRd.getMsg(), "../article/detail?id=" + id);
    }

    @RequestMapping("/usr/article/list")
    public String showList(HttpServletRequest req, Model model, @RequestParam(defaultValue = "1") int boardId,
                           @RequestParam(defaultValue = "1") int page,
                           @RequestParam(defaultValue = "title") String searchKeywordTypeCode,
                           @RequestParam(defaultValue = "") String searchKeyword) throws IOException {

        Rq rq = (Rq) req.getAttribute("rq");

        Board board = boardService.getBoardById(boardId);

        if (board == null) {
            return rq.historyBackOnView("존재하지 않는 게시판");
        }

        int articlesCount = teamArticleService.getArticleCount(boardId, searchKeywordTypeCode, searchKeyword);

        // 한 페이지에 글 10개씩
        // 글 20 -> 2page
        // 글 25 -> 3page
        int itemsInAPage = 10;

        int pagesCount = (int) Math.ceil(articlesCount / (double) itemsInAPage);

        List<TeamArticle> teamArticles = teamArticleService.getForPrintArticles(boardId, itemsInAPage, page, searchKeywordTypeCode,
                searchKeyword);

        model.addAttribute("pagesCount", pagesCount);
        model.addAttribute("articlesCount", articlesCount);
        model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("teamArticles", teamArticles);
        model.addAttribute("boardId", boardId);
        model.addAttribute("board", board);
        model.addAttribute("page", page);

        return "usr/article/list";
    }
}