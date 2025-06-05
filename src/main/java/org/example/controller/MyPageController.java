package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.example.service.MemberService;
import org.example.service.MyPageService;
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

//        // 2. 최근 경기
//        List<FtArticle> recentGames = myPageService.getRecentGamesByMemberId(memberId);

        // 3. 팀 이름 (없으면 "없음")
        String teamName = myPageService.getTeamNameByMemberId(memberId);
        if (teamName == null || teamName.trim().isEmpty()) {
            teamName = "없음";
        }

        // 4. 매너온도
//        double mannerTemp = myPageService.getMannerTemperature(memberId,teamNm);

        // 5. model에 담기
        System.out.println(member.getProfileImg());
        model.addAttribute("profileImg", member.getProfileImg());
        model.addAttribute("nickName", member.getNickName());
//        model.addAttribute("recentGames", recentGames);
        model.addAttribute("teamNm", member.getTeamNm());
        model.addAttribute("rank", member.getRank());
//        model.addAttribute("intro", member.getIntro());
//        model.addAttribute("mannerTemp", mannerTemp);

        return "usr/home/myPage";
    }
}

