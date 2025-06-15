package org.example.service;


import org.example.repository.FtArticleRepository;
import org.example.vo.FtArticle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FtArticleService {
    @Autowired
    private FtArticleRepository ftArticleRepository;

    public FtArticleService(FtArticleRepository ftArticleRepository) {
        this.ftArticleRepository = ftArticleRepository;
    }


    //    public FtArticle getForPrintFtArticle(int loginedMemberId, int id) {
//
//        FtArticle ftArticle = ftArticleRepository.getForPrintFtArticle(id);
//
//        controlForPrintData(loginedMemberId, ftArticle);
//
//        return ftArticle;
//    }
//
//
//
    public FtArticle getFtArticleById(int id) {
        return ftArticleRepository.getFtArticleById(id);
    }
//
//    public List<FtArticle> getFtArticles() {
//        return ftArticleRepository.getFtArticles();
//    }

    public List<FtArticle> getForPrintFtArticles(int boardId, int itemsInAPage, int page, String searchKeywordTypeCode, String searchKeyword, String area, String avgLevel,String playDate, String code) {
        // SELECT * FROM article WHERE boardId = 1 ORDER BY id DESC LIMIT 0, 10;
        // --> 1page
        // SELECT * FROM article WHERE boardId = 1 ORDER BY id DESC LIMIT 10, 10;
        // --> 2page

        int limitFrom = (page - 1) * itemsInAPage;
        int limitTake = itemsInAPage;

        return ftArticleRepository.getForPrintFtArticles(boardId, limitFrom, limitTake, searchKeywordTypeCode, searchKeyword, area, avgLevel, playDate, code);
    }

    public int getFtArticleCount(int boardId, String searchKeywordTypeCode, String searchKeyword, String area, String avgLevel, String playDate, String code) {
        return ftArticleRepository.getFtArticleCount(boardId, searchKeywordTypeCode, searchKeyword, area, avgLevel, playDate, code);
    }

    public int getFtArticleMatch(int id) {
        System.out.println("서비스 진입");
        return ftArticleRepository.getFtArticleMatch(id);
    }

    public List<FtArticle> getFilteredArticles(String area, Integer minLevel, Integer maxLevel, String playDate) {

        return ftArticleRepository.getFilteredArticles(area, minLevel, maxLevel, playDate);
    }

//    public ResultData increaseHitCount(int id) {
//        int affectedRow = ftArticleRepository.increaseHitCount(id);
//
//        if (affectedRow == 0) {
//            return ResultData.from("F-1", "해당 게시글 없음", "id", id);
//        }
//
//        return ResultData.from("S-1", "조회수 증가", "id", id);
//    }
//
//    public Object getFtArticleHitCount(int id) {
//        return ftArticleRepository.getFtArticleHitCount(id);
//    }
//
//    public ResultData increaseGoodReactionPoint(int relId) {
//        int affectedRow = ftArticleRepository.increaseGoodReactionPoint(relId);
//
//        if (affectedRow == 0) {
//            return ResultData.from("F-1", "없는 게시물");
//        }
//
//        return ResultData.from("S-1", "좋아요 증가", "affectedRow", affectedRow);
//    }
//
//    public ResultData increaseBadReactionPoint(int relId) {
//        int affectedRow = ftArticleRepository.increaseBadReactionPoint(relId);
//
//        if (affectedRow == 0) {
//            return ResultData.from("F-1", "없는 게시물");
//        }
//
//        return ResultData.from("S-1", "싫어요 증가", "affectedRow", affectedRow);
//    }
//
//    public ResultData decreaseGoodReactionPoint(int relId) {
//        int affectedRow = ftArticleRepository.decreaseGoodReactionPoint(relId);
//
//        if (affectedRow == 0) {
//            return ResultData.from("F-1", "없는 게시물");
//        }
//
//        return ResultData.from("S-1", "좋아요 감소", "affectedRow", affectedRow);
//    }
//
//    public ResultData decreaseBadReactionPoint(int relId) {
//        int affectedRow = ftArticleRepository.decreaseBadReactionPoint(relId);
//
//        if (affectedRow == 0) {
//            return ResultData.from("F-1", "없는 게시물");
//        }
//
//        return ResultData.from("S-1", "싫어요 감소", "affectedRow", affectedRow);
//    }
//
//    public int getGoodRP(int relId) {
//        return ftArticleRepository.getGoodRP(relId);
//    }
//
//    public int getBadRP(int relId) {
//        return ftArticleRepository.getBadRP(relId);
//   }

}