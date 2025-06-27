package org.example.service;

import lombok.RequiredArgsConstructor;
import org.example.repository.TeamAlertRepository;
import org.example.vo.TeamAlert;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TeamAlertService {

    private final TeamAlertRepository teamAlertRepository;

    // 알림 목록 가져오기
    public List<TeamAlert> getAlertsByTeamId(int teamId) {
        return teamAlertRepository.getAlertsByTeamId(teamId);
    }

    // 알림 저장
    public void writeAlert(TeamAlert alert) {
        teamAlertRepository.writeAlert(alert);
    }

}
