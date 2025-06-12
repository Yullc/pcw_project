package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.example.vo.TeamArticle;

import java.util.List;

@Mapper
public interface TeamArticleRepository {

    List<TeamArticle> getForPrintTeam(String teamName, String teamRank, String teamLeader);

    int getLastInsertId();

    void writeArticle(int memberId, String title, String body, String boardId);

    TeamArticle getArticleById(int id);

    int getArticleCount(int boardId, String searchKeywordTypeCode, String searchKeyword);

    List<TeamArticle> getForPrintArticles(int boardId, int limitFrom, int limitTake, String searchKeywordTypeCode, String searchKeyword,String area);

    TeamArticle getForPrintArticle(int id);

    void modifyArticle(int id, String title, String body);

    void deleteArticle(int id);
}
