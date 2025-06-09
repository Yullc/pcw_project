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


        Member member = memberService.getMemberById(memberId);
        String teamName = myPageService.getTeamNameByMemberId(memberId);
        if (teamName == null || teamName.trim().isEmpty()) teamName = "없음";

        String rankName = RankUtil.getRankName(member.getRank());

        // ✅ 최근 경기 목록 가져오기
        List<FtArticle> recentGames = myPageService.getRecentGamesByMemberId(memberId);
        for (FtArticle game : recentGames) {
            System.out.println("▶ 최근경기 img: " + game.getImg());
        }

        model.addAttribute("id", member.getId());
        model.addAttribute("profileImg", member.getProfileImg());
        model.addAttribute("nickName", member.getNickName());
        model.addAttribute("teamNm", teamName);
        model.addAttribute("rank", rankName);
        model.addAttribute("intro", member.getIntro());
        model.addAttribute("recentGames", recentGames);

        return "usr/home/myPage";
    }


}