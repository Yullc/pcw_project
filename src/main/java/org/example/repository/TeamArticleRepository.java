package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.example.vo.TeamArticle;

import java.util.List;

@Mapper
public interface TeamArticleRepository {

    List<TeamArticle> getForPrintTeam(String teamName, String teamRank, String teamLeader);
}
