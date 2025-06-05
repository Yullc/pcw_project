package org.example.repository;

import org.apache.ibatis.annotations.Mapper;

import org.example.vo.Member;

import java.time.LocalDateTime;

@Mapper
public interface MemberRepository {

    public int doJoin(String loginId, String loginPw, String loginPwCheck, String email, String name, String nickName, String poneNm, String bornDate, String area, String gender);

    public Member getMemberById(int id);

    public int getLastInsertId();

    public Member getMemberByLoginId(String loginId);

    public Member getMemberByNameAndEmail(String name, String email);

    String findTeamNameByMemberId(int memberId);
}