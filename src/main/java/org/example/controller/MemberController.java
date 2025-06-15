package org.example.controller;

import org.example.repository.MemberRepository;
import org.example.service.FtArticleService;
import org.example.util.MannerUtil;
import org.example.util.RankUtil;
import org.example.vo.FtArticle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.example.service.MemberService;
import org.example.util.Ut;
import org.example.vo.Member;
import org.example.vo.ResultData;
import org.example.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Controller
public class MemberController {

    @Autowired
    private Rq rq;

    @Autowired
    private FtArticleService ftarticleService;
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

        if (!member.getLoginPw().equals(loginPw)) {
            return Ut.jsHistoryBack("F-4", "비밀번호가 일치하지 않습니다");
        }

        rq.login(member);
        rq.setLoginedMember(member);
        System.out.println("member 객체 저장"+member);
        return Ut.jsReplace("S-1", Ut.f("%s님 환영합니다", member.getNickName()), "/");
    }

    @RequestMapping("/usr/home/join")
    public String showJoin(HttpServletRequest req) {
        return "/usr/home/join";
    }

    @RequestMapping("/usr/home/doJoin")
    @ResponseBody
    public String doJoin(HttpServletRequest req, String loginId, String loginPw, String loginPwCheck, String email, String name, String nickName, String phoneNumber, String bornDate, String area, String gender) {
        System.out.println(loginId);
        System.out.println(loginPw);
        System.out.println(loginPwCheck);
        System.out.println(email);
        System.out.println(name);
        System.out.println(nickName);
        System.out.println(phoneNumber);
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
        if (Ut.isEmptyOrNull(phoneNumber)) {
            return Ut.jsHistoryBack("F-5", "전화번호를 입력해");

        }
        if (Ut.isEmptyOrNull(String.valueOf(bornDate))) {
            return Ut.jsHistoryBack("F-5", "생년월일 입력해");

        }
        if (Ut.isEmptyOrNull(area)) {
            return Ut.jsHistoryBack("F-5", "지역을 입력해");

        }


        ResultData joinRd = memberService.join(loginId, loginPw, loginPwCheck, email, name, nickName, phoneNumber, bornDate, area, gender);

        if (joinRd.isFail()) {
            return Ut.jsHistoryBack(joinRd.getResultCode(), joinRd.getMsg());
        }

        Member member = memberService.getMemberById((int) joinRd.getData1());

        return Ut.jsReplace(joinRd.getResultCode(), joinRd.getMsg(), "../home/main");
    }

    @RequestMapping("/usr/member/modify")
    public String showModify(HttpServletRequest req, Model model) {
        Rq rq = (Rq) req.getAttribute("rq");


        req.setAttribute("rq", rq);

        return "usr/member/modify";
    }
    @RequestMapping("/usr/member/doModify")
    @ResponseBody
    public String doModify(HttpServletRequest req,
                           String loginPw,
                           String email,
                           String area,
                           String phoneNumber,
                           String nickName,
                           String teamNm,
                           String intro) {

        System.out.println("doModify");

        Rq rq = (Rq) req.getAttribute("rq");
        int loginedMemberId = rq.getLoginedMemberId();

        Member member = memberService.getMemberById(loginedMemberId);

        if (member == null) {
            return Ut.jsReplace("F-1", "회원이 존재하지 않습니다.", "/");
        }
        System.out.println(loginedMemberId);
        System.out.println(email);
        System.out.println(phoneNumber);
        // 필수값 검증

        if (Ut.isEmptyOrNull(email)) {
            return Ut.jsHistoryBack("F-2", "이메일을 입력하세요.");
        }
        if (Ut.isEmptyOrNull(area)) {
            return Ut.jsHistoryBack("F-3", "지역을 선택하세요.");
        }
        if (Ut.isEmptyOrNull(phoneNumber)) {
            return Ut.jsHistoryBack("F-4", "전화번호를 입력하세요.");
        }
        if (Ut.isEmptyOrNull(nickName)) {
            return Ut.jsHistoryBack("F-5", "닉네임을 입력하세요.");
        }

        ResultData rd;

        // 비밀번호 변경 여부에 따라 처리 분기
        if (Ut.isEmptyOrNull(loginPw)) {
            rd = memberService.modifyMemberWithoutPw(loginedMemberId, email, area, phoneNumber, nickName, teamNm, intro);
        } else {
            rd = memberService.modifyMember(loginedMemberId, loginPw, email, area, phoneNumber, nickName, teamNm, intro);
        }

        return Ut.jsReplace(rd.getResultCode(), rd.getMsg(), "../home/myPage");
    }


    @RequestMapping("/usr/member/checkPw")
    public String showCheckPw() {
        return "usr/member/checkPw";
    }

    @RequestMapping("/usr/member/doCheckPw")
    @ResponseBody
    public String doCheckPw(String loginPw) {
        if (Ut.isEmptyOrNull(loginPw)) {
            return Ut.jsHistoryBack("F-1", "비번 써");
        }

        if (!rq.getLoginedMember().getLoginPw().equals(loginPw)) {
            return Ut.jsHistoryBack("F-2", "비번 틀림");
        }

        return Ut.jsReplace("S-1", Ut.f("비밀번호 확인 성공"), "modify");
    }
    @PostMapping("/usr/member/updatePlayerInfo")
    public String updatePlayerInfo(@RequestParam int memberId,
                                   @RequestParam("id") int id,
                                   @RequestParam int boardId,
                                   @RequestParam String rankName,
                                   @RequestParam String mannerEmoji,
                                   RedirectAttributes redirectAttrs) {

        // 매너 & 랭크 변환
        int rank = RankUtil.getNameToRank(rankName);
        float manner = MannerUtil.getTemperatureFromEmoji(mannerEmoji);

        memberService.updateRankAndManner(memberId, rank, manner);

        // 리다이렉트 파라미터 전달
        redirectAttrs.addAttribute("id", id);

        String redirectUrl;
        if (boardId == 1) {
            redirectUrl = "/usr/ftArticle/foot_detail";
        } else if (boardId == 2) {
            redirectUrl = "/usr/scArticle/soccer_detail";
        } else {
            redirectUrl = "/usr/home/main";
        }

        return "redirect:" + redirectUrl;
    }


}