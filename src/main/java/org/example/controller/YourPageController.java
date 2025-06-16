package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.example.service.MemberService;
import org.example.service.MessageService;
import org.example.service.MyPageService;
import org.example.util.MannerUtil;
import org.example.util.RankUtil;
import org.example.util.Ut;
import org.example.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
@Controller
public class YourPageController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private MyPageService myPageService;

    @Autowired
    private MessageService messageService;



    @RequestMapping("/usr/home/yourPage")
    public String showYourPage(@RequestParam("nickName") String nickName, HttpServletRequest req, Model model) {
        Rq rq = (Rq) req.getAttribute("rq");
        System.out.println("YOur 진입");
        if (rq == null || rq.getLoginedMemberId() == 0) {
            return "redirect:/usr/home/main";
        }
        Member member = memberService.getMemberByNickname(nickName);
        int targetMemberId = member.getId();
        if (member == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("'%s' 닉네임을 가진 회원은 존재하지 않습니다.", nickName));
        }
        int memberId = rq.getLoginedMemberId();
        System.out.println("그 사람 memberId: " + memberId);
        //  매너온도 이모지 설정
        String emoji = MannerUtil.getMannerEmoji(member.getManner());
        member.setMannerEmoji(emoji);

        String teamName = myPageService.getTeamNameByMemberId(memberId);
        if (teamName == null || teamName.trim().isEmpty()) teamName = "없음";
        System.out.println("그 사람 팀 이름"+teamName);
        String rankName = RankUtil.getRankName(member.getRank());

        //  최근 경기 목록 가져오기
        List<FtArticle> recentGames = myPageService.getRecentGamesByMemberId(targetMemberId);
        List<ScArticle>  recentSoccerGames = myPageService.getRecentSoccerGamesByMemberId(targetMemberId);

        for (FtArticle game : recentGames) {
            System.out.println("▶ 그사람 최근경기 img: " + game.getImg());
        }
        for (ScArticle scGame : recentSoccerGames) {
            System.out.println("▶ 그 사람 축구 !!!최근경기 img: " + scGame.getImg());
        }
        model.addAttribute("id", member.getId());
        model.addAttribute("profileImg", member.getProfileImg());
        model.addAttribute("nickName", member.getNickName());
        model.addAttribute("teamNm", teamName);
        model.addAttribute("rank", rankName);
        model.addAttribute("intro", member.getIntro());
        model.addAttribute("recentGames", recentGames);
        model.addAttribute("recentSoccerGames", recentSoccerGames);
        //  manner 온도와 이모지도 모델에 추가
        model.addAttribute("manner", member.getManner());
        model.addAttribute("mannerEmoji", member.getMannerEmoji());

        return "usr/home/yourPage";
    }



}