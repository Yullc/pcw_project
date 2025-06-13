package org.example.service;

import org.example.repository.MercenaryArticleRepository;
import org.example.repository.TeamArticleRepository;
import org.example.util.Ut;
import org.example.vo.MercenaryArticle;
import org.example.vo.ResultData;
import org.example.vo.TeamArticle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

import static org.example.util.Ut.f;

@Service
public class MercenaryArticleService {
    @Autowired
    private MercenaryArticleRepository mercenaryArticleRepository;

//    public List<MercenaryArticle> getForPrintTeam(String teamName, String teamRank, String teamLeader) {
//        return mercenaryArticleRepository.getForPrintTeam(teamName,teamRank,teamLeader);
//    }

    public MercenaryArticle getForPrintArticle(int loginedMemberId, int id) {
        MercenaryArticle mercenaryArticle = mercenaryArticleRepository.getForPrintArticle(id);

        controlForPrintData(loginedMemberId, mercenaryArticle);

        return mercenaryArticle;
    }
    private void controlForPrintData(int loginedMemberId, MercenaryArticle mercenaryArticle) {
        if (mercenaryArticle == null) {
            return;
        }

        ResultData userCanModifyRd = userCanModify(loginedMemberId, mercenaryArticle);
        mercenaryArticle.setUserCanModify(userCanModifyRd.isSuccess());

        ResultData userDeleteRd = userCanDelete(loginedMemberId, mercenaryArticle);
        mercenaryArticle.setUserCanDelete(userDeleteRd.isSuccess());
    }

    public ResultData userCanDelete(int loginedMemberId, MercenaryArticle mercenaryArticle) {
        if (mercenaryArticle.getMemberId() != loginedMemberId) {
            return ResultData.from("F-A", Ut.f("%d번 게시글에 대한 삭제 권한 없음", mercenaryArticle.getId()));
        }

        return ResultData.from("S-1", Ut.f("%d번 게시글 삭제 완료", mercenaryArticle.getId()));
    }

    public MercenaryArticle getArticleById(int id) {

        return mercenaryArticleRepository.getArticleById(id);
    }

    public ResultData userCanModify(int loginedMemberId, MercenaryArticle mercenaryArticle) {

        if (mercenaryArticle.getMemberId() != loginedMemberId) {
            return ResultData.from("F-A", Ut.f("%d번 게시글에 대한 수정 권한 없음", mercenaryArticle.getId()));
        }

        return ResultData.from("S-1", Ut.f("%d번 게시글 수정 완료", mercenaryArticle.getId()));
    }

    public void modifyArticle(int id, String title, String body) {
        mercenaryArticleRepository.modifyArticle(id, title, body);
    }

    public void deleteArticle(int id) {
        mercenaryArticleRepository.deleteArticle(id);
    }

    public ResultData writeArticle(int memberId, String title, String body, String area) {
        mercenaryArticleRepository.writeArticle(memberId, title, body, area);

        int id = mercenaryArticleRepository.getLastInsertId();

        return ResultData.from("S-1", f("%d번 글이 등록되었습니다", id), "등록 된 게시글 id", id);
    }

    public int getArticleCount(int boardId, String searchKeywordTypeCode, String searchKeyword) {
        return mercenaryArticleRepository.getArticleCount(boardId, searchKeywordTypeCode, searchKeyword);

    }

    public List<MercenaryArticle> getForPrintArticles(int boardId, int itemsInAPage, int page, String searchKeywordTypeCode, String searchKeyword,String area) {

        int limitFrom = (page - 1) * itemsInAPage;
        int limitTake = itemsInAPage;

        return mercenaryArticleRepository.getForPrintArticles(boardId, limitFrom, limitTake, searchKeywordTypeCode,
                searchKeyword,area);
    }
}
