package org.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.example.repository.MemberRepository;
import org.example.util.Ut;
import org.example.vo.Member;
import org.example.vo.ResultData;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MemberService {

    @Autowired
    private MemberRepository memberRepository;

    public MemberService(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    public ResultData<Integer> join(String loginId, String loginPw, String loginPwCheck, String email, String name, String nickName, String phoneNumber, String bornDate, String area, String gender) {

        Member existsMember = getMemberByLoginId(loginId);

        if (existsMember != null) {
            return ResultData.from("F-7", Ut.f("이미 사용중인 아이디(%s)입니다", loginId));
        }

        existsMember = getMemberByNameAndEmail(name,email);

        if (existsMember != null) {
            return ResultData.from("F-8", Ut.f("이미 사용중인 이름(%s)과 이메일(%s)입니다", name, email));
        }

        memberRepository.doJoin(loginId, loginPw, loginPwCheck, email, name, nickName, phoneNumber, bornDate, area, gender);

        int id = memberRepository.getLastInsertId();

        return ResultData.from("S-1", "회원가입 성공", "가입 성공 id", id);
    }

    private Member getMemberByNameAndEmail(String name, String email) {
        return memberRepository.getMemberByNameAndEmail(name, email);

    }

    public Member getMemberByLoginId(String loginId) {
        return memberRepository.getMemberByLoginId(loginId);
    }

    public Member getMemberById(int id) {
        return memberRepository.getMemberById(id);
    }
    public ResultData  modifyMember(int id, String loginPw,  String emaill,  String area,String phoneNumber, String nickName, String teamNm, String intro) {
        memberRepository.modifyMember(id, loginPw, emaill, area, phoneNumber, nickName, teamNm, intro);
        return ResultData.from("S-1", "회원정보가 수정되었습니다.");
    }

    public ResultData modifyMemberWithoutPw(int loginedMemberId, String email, String area, String phoneNumber, String nickName, String teamNm, String intro) {
        memberRepository.modifyMemberWithoutPw(loginedMemberId, email, area, phoneNumber, nickName, teamNm, intro);

        return ResultData.from("S-1", "회원정보 수정 완료");
    }

    public int updateRankAndManner(int memberId, int rank, float manner) {
        return memberRepository.updateRankAndManner(memberId, rank, manner);
    }

    public Member getMemberByNickname(String nickName) {
        System.out.println("getMemberByNickname 서비스 진입");
        return memberRepository.getMemberByNickname(nickName);
    }


    public List<Member> getMembersByTeamId(int teamId) {
        return memberRepository.getMembersByTeamId(teamId);
    }


    public Member getMemberByNickName(String teamLeader) {
        return memberRepository.getMemberByNickName(teamLeader);
    }

    public void updateProfileImg(int memberId, String imageUrl) {
        Map<String, Object> param = new HashMap<>();
        param.put("id", memberId);
        param.put("profileImgUrl", imageUrl);
        memberRepository.updateProfileImgUrl(param);
    }
}