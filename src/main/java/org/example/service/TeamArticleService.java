package org.example.service;

import org.example.repository.TeamArticleRepository;
import org.example.vo.TeamArticle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeamArticleService {
    @Autowired
    private TeamArticleRepository teamRepository;

    public List<TeamArticle> getForPrintTeam(String teamName, String teamRank, String teamLeader) {
        return teamRepository.getForPrintTeam(teamName,teamRank,teamLeader);
    }

    public TeamArticle getForPrintArticle(int loginedMemberId, int id) {
    }

    public TeamArticle getArticleById(int id) {
    }
}
