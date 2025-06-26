package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.example.vo.TeamAlert;

import java.util.List;

@Mapper
public interface TeamAlertRepository {
    List<TeamAlert> getAlertsByTeamId(int teamId);

    void writeAlert(TeamAlert alert);

}
