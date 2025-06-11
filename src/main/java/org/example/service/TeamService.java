package org.example.service;

import org.example.repository.TeamRepository;
import org.example.vo.Team;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeamService {
    @Autowired
    private TeamRepository teamRepository;

    public List<Team> getForPrintTeam(String teamName, String teamRank, String teamLeader) {
        return teamRepository.getForPrintTeam(teamName,teamRank,teamLeader);
    }
}
