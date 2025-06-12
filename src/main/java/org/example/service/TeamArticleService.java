package org.example.service;

import org.example.repository.TeamArticleRepository;
import org.example.util.Ut;
import org.example.vo.ResultData;
import org.example.vo.TeamArticle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

import static org.example.util.Ut.f;

@Service
public class TeamArticleService {
    @Autowired
    private TeamArticleRepository teamArticleRepository;

    public List<TeamArticle> getForPrintTeam(String teamName, String teamRank, String teamLeader) {
        return teamArticleRepository.getForPrintTeam(teamName,teamRank,teamLeader);
    }

    public TeamArticle getForPrintArticle(int loginedMemberId, int id) {
        TeamArticle teamArticle = teamArticleRepository.getForPrintArticle(id);

        controlForPrintData(loginedMemberId, teamArticle);

        return teamArticle;
    }
    private void controlForPrintData(int loginedMemberId, TeamArticle teamArticle) {
        if (teamArticle == null) {
            return;
        }

        ResultData userCanModifyRd = userCanModify(loginedMemberId, teamArticle);
        teamArticle.setUserCanModify(userCanModifyRd.isSuccess());

        ResultData userDeleteRd = userCanDelete(loginedMemberId, teamArticle);
        teamArticle.setUserCanDelete(userDeleteRd.isSuccess());
    }

    public ResultData userCanDelete(int loginedMemberId, TeamArticle teamArticle) {
        if (teamArticle.getMemberId() != loginedMemberId) {
            return ResultData.from("F-A", Ut.f("%d번 게시글에 대한 삭제 권한 없음", teamArticle.getId()));
        }

        return ResultData.from("S-1", Ut.f("%d번 게시글 삭제 가능", teamArticle.getId()));
    }

    public TeamArticle getArticleById(int id) {

        return teamArticleRepository.getArticleById(id);
    }

    public ResultData userCanModify(int loginedMemberId, TeamArticle teamArticle) {

        if (teamArticle.getMemberId() != loginedMemberId) {
            return ResultData.from("F-A", Ut.f("%d번 게시글에 대한 수정 권한 없음", teamArticle.getId()));
        }

        return ResultData.from("S-1", Ut.f("%d번 게시글 수정 가능", teamArticle.getId()));
    }

    public void modifyArticle(int id, String title, String body) {
        teamArticleRepository.modifyArticle(id, title, body);
    }

    public void deleteArticle(int id) {
        teamArticleRepository.deleteArticle(id);
    }

    public ResultData writeArticle(int memberId, String title, String body, String boardId) {
        teamArticleRepository.writeArticle(memberId, title, body, boardId);

        int id = teamArticleRepository.getLastInsertId();

        return ResultData.from("S-1", f("%d번 글이 등록되었습니다", id), "등록 된 게시글 id", id);
    }

    public int getArticleCount(int boardId, String searchKeywordTypeCode, String searchKeyword) {
        return teamArticleRepository.getArticleCount(boardId, searchKeywordTypeCode, searchKeyword);

    }

    public List<TeamArticle> getForPrintArticles(int boardId, int itemsInAPage, int page, String searchKeywordTypeCode, String searchKeyword,String area) {

        int limitFrom = (page - 1) * itemsInAPage;
        int limitTake = itemsInAPage;

        return teamArticleRepository.getForPrintArticles(boardId, limitFrom, limitTake, searchKeywordTypeCode,
                searchKeyword,area);
    }
}
