package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.example.vo.FtArticle;

import java.util.List;

@Mapper
public interface MyPageRepository {
    String findTeamNameByMemberId(int memberId);

    List<FtArticle> getRecentGamesByMemberId(int memberId);
}
