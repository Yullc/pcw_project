package org.example.repository;
import org.apache.ibatis.annotations.Mapper;

import org.example.vo.FtArticle;
import org.example.vo.Member;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface FtArticleRepository {

    public List<FtArticle> getForPrintFtArticles(int boardId, int limitFrom, int limitTake, String searchKeywordTypeCode, String searchKeyword, String area, String avgLevel, String playDate,String code);

    public int getFtArticleCount(int boardId, String searchKeywordTypeCode, String searchKeyword, String area, String avgLevel, String playDate, String code);

    public FtArticle getFtArticleById(int id);

    public int getFtArticleMatch(int id);

    List<FtArticle> getFilteredArticles(String area, Integer minLevel, Integer maxLevel, String playDate);
}