package org.example.repository;

import org.apache.ibatis.annotations.Mapper;

import org.example.vo.Member;

@Mapper
public interface MemberRepository {

    public int doJoin(String loginId, String loginPw, String name, String nickName, String poneNm, String email);

    public Member getMemberById(int id);

    public int getLastInsertId();

    public Member getMemberByLoginId(String loginId);

    public Member getMemberByNameAndEmail(String name, String email);

}