package org.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import org.example.service.MemberService;
import org.example.util.Ut;
import org.example.vo.Member;
import org.example.vo.ResultData;
import org.example.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

import java.time.LocalDateTime;

@Controller
public class MemberController {

    @Autowired
    private Rq rq;

    @Autowired
    private MemberService memberService;

    @RequestMapping("/usr/member/doLogout")
    @ResponseBody
    public String doLogin(HttpServletRequest req) {

        Rq rq = (Rq) req.getAttribute("rq");

        rq.logout();

        return Ut.jsReplace("S-1", "로그아웃 성공", "/");
    }

    @RequestMapping("/usr/home/login")
    public String showLogin(HttpServletRequest req) {
        return "/usr/home/main";
    }

    @RequestMapping("/usr/home/doLogin")
    @ResponseBody
    public String doLogin(HttpServletRequest req, String loginId, String loginPw) {
        System.out.println("아이디 받아옴 아이디 받아옴 아이디 받아옴 아이디 받아옴 아이디 받아옴 "+loginId);
        System.out.println("비밀번호 받아옴 비밀번호 받아옴 비밀번호 받아옴 비밀번호 받아옴 "+loginPw);
        System.out.println("아이디 받아옴 아이디 받아옴 아이디 받아옴 아이디 받아옴 아이디 받아옴 "+loginId);
        System.out.println("비밀번호 받아옴 비밀번호 받아옴 비밀번호 받아옴 비밀번호 받아옴 "+loginPw);
        Rq rq = (Rq) req.getAttribute("rq");
        System.out.println("controller Rq = " +rq);

        if (Ut.isEmptyOrNull(loginId)) {
            return Ut.jsHistoryBack("F-1", "아이디를 입력해");
        }
        if (Ut.isEmptyOrNull(loginPw)) {
            return Ut.jsHistoryBack("F-2", "비밀번호를 입력해");
        }

        Member member = memberService.getMemberByLoginId(loginId);

        if (member == null) {
            return Ut.jsHistoryBack("F-3", Ut.f("%s는(은) 없는 아이디야", loginId));
        }

        if (member.getLoginPw().equals(loginPw) == false) {
            return Ut.jsHistoryBack("F-4", "비밀번호가 일치하지 않습니다");
        }

        rq.login(member);

        return Ut.jsReplace("S-1", Ut.f("%s님 환영합니다", member.getNickName()), "/");
    }

    @RequestMapping("/usr/home/join")
    public String showJoin(HttpServletRequest req) {
        return "/usr/home/join";
    }

    @RequestMapping("/usr/home/doJoin")
    @ResponseBody
    public String doJoin(HttpServletRequest req, String loginId, String loginPw, String loginPwCheck, String email, String name, String nickName, String poneNm, String bornDate, String area, String gender) {
        System.out.println(loginId);
        System.out.println(loginPw);
        System.out.println(loginPwCheck);
        System.out.println(email);
        System.out.println(name);
        System.out.println(nickName);
        System.out.println(poneNm);
        System.out.println(bornDate);
        System.out.println(area);
        System.out.println(gender);
        System.out.println(1);
        if (Ut.isEmptyOrNull(loginId)) {
            System.out.println(2);
            return Ut.jsHistoryBack("F-1", "아이디를 입력해");
        } else System.out.println("aa");
        System.out.println(3);
        if (Ut.isEmptyOrNull(loginPw)) {
            System.out.println(loginId);
            System.out.println(4);
            return Ut.jsHistoryBack("F-2", "비밀번호를 입력해");
        }

        if (Ut.isEmptyOrNull(loginPwCheck)) {
            return Ut.jsHistoryBack("F-2", "비밀번호허ㅣㄱㅇ;ㄴ를 입력해");

        }
        if (Ut.isEmptyOrNull(email)) {
            return Ut.jsHistoryBack("F-2", "비밀번호를 입력해");

        }
        if (Ut.isEmptyOrNull(name)) {
            return Ut.jsHistoryBack("F-3", "이름을 입력해");

        }
        if (Ut.isEmptyOrNull(nickName)) {
            return Ut.jsHistoryBack("F-4", "닉네임을 입력해");

        }
        if (Ut.isEmptyOrNull(poneNm)) {
            return Ut.jsHistoryBack("F-5", "전화번호를 입력해");

        }
        if (Ut.isEmptyOrNull(String.valueOf(bornDate))) {
            return Ut.jsHistoryBack("F-5", "생년월일 입력해");

        }
        if (Ut.isEmptyOrNull(area)) {
            return Ut.jsHistoryBack("F-5", "지역을 입력해");

        }


        ResultData joinRd = memberService.join(loginId, loginPw, loginPwCheck, email, name, nickName, poneNm, bornDate, area, gender);

        if (joinRd.isFail()) {
            return Ut.jsHistoryBack(joinRd.getResultCode(), joinRd.getMsg());
        }

        Member member = memberService.getMemberById((int) joinRd.getData1());

        return Ut.jsReplace(joinRd.getResultCode(), joinRd.getMsg(), "../home/join");
    }

}