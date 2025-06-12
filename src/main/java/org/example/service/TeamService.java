package org.example.service;

import org.example.repository.TeamArticleRepository;
import org.example.repository.TeamRepository;
import org.example.vo.Team;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TeamService {
    @Autowired
    private TeamRepository teamRepository;

    public Team getTeamByLeaderNickName(String nickName) {
        return teamRepository.getTeamByLeaderNickName(nickName);
    }

}
