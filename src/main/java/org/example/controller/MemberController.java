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
    public String doJoin(HttpServletRequest req, String loginId, String loginPw, String name, String nickname,
                         String cellphoneNum, String email) {

        if (Ut.isEmptyOrNull(loginId)) {
            return Ut.jsHistoryBack("F-1", "아이디를 입력해");
        }
        if (Ut.isEmptyOrNull(loginPw)) {
            return Ut.jsHistoryBack("F-2", "비밀번호를 입력해");

        }
        if (Ut.isEmptyOrNull(name)) {
            return Ut.jsHistoryBack("F-3", "이름을 입력해");

        }
        if (Ut.isEmptyOrNull(nickname)) {
            return Ut.jsHistoryBack("F-4", "닉네임을 입력해");

        }
        if (Ut.isEmptyOrNull(cellphoneNum)) {
            return Ut.jsHistoryBack("F-5", "전화번호를 입력해");

        }
        if (Ut.isEmptyOrNull(email)) {
            return Ut.jsHistoryBack("F-6", "이메일을 입력해");

        }

        ResultData joinRd = memberService.join(loginId, loginPw, name, nickname, cellphoneNum, email);

        if (joinRd.isFail()) {
            return Ut.jsHistoryBack(joinRd.getResultCode(), joinRd.getMsg());
        }

        Member member = memberService.getMemberById((int) joinRd.getData1());

        return Ut.jsReplace(joinRd.getResultCode(), joinRd.getMsg(), "../home/join");
    }

}