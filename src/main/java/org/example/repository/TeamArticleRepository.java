package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.example.vo.TeamArticle;

import java.util.List;
import java.util.Map;

@Mapper
public interface TeamArticleRepository {

    List<TeamArticle> getForPrintTeam(String teamName, String teamRank, String teamLeader);

    int getLastInsertId();

    void writeArticle(int memberId, String title, String body, int teamId, String area);

    TeamArticle getArticleById(int id);

    int getArticleCount(int boardId, String searchKeywordTypeCode, String searchKeyword);

    List<TeamArticle> getForPrintArticles(int boardId, int limitFrom, int limitTake, String searchKeywordTypeCode, String searchKeyword,String area);

    TeamArticle getForPrintArticle(int id);

    void modifyArticle(int id, String title, String body);

    void deleteArticle(int id);

    void modifyArticle(Map<String, Object> param);
}