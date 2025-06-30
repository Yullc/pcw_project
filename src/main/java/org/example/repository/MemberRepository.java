package org.example.repository;

import org.apache.ibatis.annotations.Mapper;

import org.apache.ibatis.annotations.Param;
import org.example.vo.Member;

import java.util.List;
import java.util.Map;

@Mapper
public interface MemberRepository {

    public int doJoin(String loginId, String loginPw, String loginPwCheck, String email, String name, String nickName, String phoneNumber, String bornDate, String area, String gender);

    public Member getMemberById(int id);

    public int getLastInsertId();

    public Member getMemberByLoginId(String loginId);

    public Member getMemberByNameAndEmail(String name, String email);

    public String findTeamNameByMemberId(int memberId);

    public void modifyMember(int id, String loginPw, String email, String area, String phoneNumber, String nickName, String teamNm, String intro);

    public void modifyMemberWithoutPw(int loginedMemberId, String email, String area, String phoneNumber, String nickName, String teamNm, String intro);

    public int updateRankAndManner(@Param("memberId") int memberId,
                                   @Param("rank") int rank,
                                   @Param("manner") float manner);


    public Member getMemberByNickname(String nickName);


    public List<Member> getMembersByTeamId(@Param("teamId") int teamId);

    public  Member getMemberByNickName(String teamLeader);

    void updateProfileImg(int memberId, String profileImgPath);

    void updateProfileImgUrl(Map<String, Object> param);



    void leaveTeam(int memberId);
    Integer getTeamIdByMemberId(int memberId);


}