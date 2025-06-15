package org.example.repository;
import org.apache.ibatis.annotations.Mapper;

import org.example.vo.FtArticle;
import org.example.vo.Member;
import org.example.vo.ScArticle;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface ScArticleRepository {

    public List<ScArticle> getForPrintScArticles(int boardId, int limitFrom, int limitTake, String searchKeywordTypeCode, String searchKeyword, String area, String avgLevel, String playDate,String code);

    public int getScArticleCount(int boardId, String searchKeywordTypeCode, String searchKeyword, String area, String avgLevel, String playDate,String code);

    public ScArticle getScArticleById(int id);

    public int getScArticleMatch(int id);

    List<ScArticle> getFilteredArticles(String area, Integer minLevel, Integer maxLevel, String playDate);
}