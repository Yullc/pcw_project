package org.example.repository;

import org.apache.ibatis.annotations.Mapper;

import org.example.vo.Member;

@Mapper
public interface MemberRepository {

    public int doJoin(String loginId, String loginPw, String loginPwCheck, String email, String name, String nickName, String phoneNumber, String bornDate, String area, String gender);

    public Member getMemberById(int id);

    public int getLastInsertId();

    public Member getMemberByLoginId(String loginId);

    public Member getMemberByNameAndEmail(String name, String email);

    public String findTeamNameByMemberId(int memberId);

    public void modifyMember(int id, String loginPw, String email, String area, String phoneNumber, String nickName, String teamNm, String intro);

    public  void modifyMemberWithoutPw(int loginedMemberId, String email, String area, String phoneNumber, String nickName, String teamNm, String intro);

    public int updateRankAndManner(int memberId, int rank, float manner);

    public Member getMemberByNickname(String nickName);
}