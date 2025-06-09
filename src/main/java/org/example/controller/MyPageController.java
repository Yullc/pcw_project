package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.example.service.MemberService;
import org.example.service.MyPageService;
import org.example.util.RankUtil;
import org.example.vo.FtArticle;
import org.example.vo.Member;
import org.example.vo.Rq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
@Controller
public class MyPageController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private MyPageService myPageService;

    @RequestMapping("/usr/home/myPage")
    public String showMyPage(HttpServletRequest req, Model model) {
        Rq rq = (Rq) req.getAttribute("rq");

        if (rq == null || rq.getLoginedMemberId() == 0) {
            return "redirect:/usr/home/main";
        }

        int memberId = rq.getLoginedMemberId();

        // 1. 로그인 회원 정보
        Member member = memberService.getMemberById(memberId);

        // 2. 팀 이름 (없으면 "없음")
        String teamName = myPageService.getTeamNameByMemberId(memberId);
        if (teamName == null || teamName.trim().isEmpty()) {
            teamName = "없음";
        }


        String rankName = RankUtil.getRankName(member.getRank());

        // 4. model에 담기
        model.addAttribute("id", member.getId());
        model.addAttribute("profileImg", member.getProfileImg());
        model.addAttribute("nickName", member.getNickName());
        model.addAttribute("teamNm", teamName);
        model.addAttribute("rank", rankName);
        model.addAttribute("intro", member.getIntro());

        return "usr/home/myPage";
    }

}