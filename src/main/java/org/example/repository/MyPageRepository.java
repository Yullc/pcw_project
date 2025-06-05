package org.example.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MyPageRepository {
    String findTeamNameByMemberId(int memberId);
}
