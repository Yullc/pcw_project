package org.example.controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import jakarta.servlet.http.HttpServletRequest;
import org.example.service.*;
import org.example.util.MannerUtil;
import org.example.util.RankUtil;
import org.example.util.Ut;
import org.example.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
public class MyPageController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private MyPageService myPageService;

    @Autowired
    private MessageService messageService;
    @Autowired
    private TeamService teamService;

    @Autowired
    private MatchParticipantService matchParticipantService;

    @RequestMapping("/usr/home/myPage")
    public String showMyPage(HttpServletRequest req, Model model) {
        Rq rq = (Rq) req.getAttribute("rq");
        System.out.println("마이페이지 진입");
        if (rq == null || rq.getLoginedMemberId() == 0) {
            return "redirect:/usr/home/main";
        }

        int memberId = rq.getLoginedMemberId();

        Member member = memberService.getMemberById(memberId);

        //  매너온도 이모지 설정
        String emoji = MannerUtil.getMannerEmoji(member.getManner());
        member.setMannerEmoji(emoji);

        String teamName = myPageService.getTeamNameByMemberId(memberId);
        if (teamName == null || teamName.trim().isEmpty()) teamName = "없음";

        String rankName = RankUtil.getRankName(member.getRank());

        //  최근 경기 목록 가져오기
        List<FtArticle> recentGames = myPageService.getRecentGamesByMemberId(memberId);
        List<ScArticle>  recentSoccerGames = myPageService.getRecentSoccerGamesByMemberId(memberId);
        // 다음경기 가져오기
        Article nextMatch = matchParticipantService.getNextMatchForMember(memberId);

        for (FtArticle game : recentGames) {
            System.out.println("▶ 최근경기 img: " + game.getImg());
        }
        for (ScArticle scGame : recentSoccerGames) {
            System.out.println("▶ 축구 !!!최근경기 img: " + scGame.getImg());
        }
        int loginedMemberId = rq.getLoginedMemberId();
        int likeCount = myPageService.getGoodRP(loginedMemberId);

        Integer teamId = myPageService.getTeamIdByMemberId(memberId);
        model.addAttribute("teamId", teamId != null ? teamId : 0);

        model.addAttribute("teamId", teamId);
        model.addAttribute("likeCount", likeCount);
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
        List<Message> receivedMessages = messageService.getReceivedMessages(rq.getLoginedMemberId());
        List<Message> sentMessages = messageService.getSentMessages(rq.getLoginedMemberId());
        model.addAttribute("receivedMessages", receivedMessages);
        model.addAttribute("sentMessages", sentMessages);
        model.addAttribute("nextMatch", nextMatch);


        return "usr/home/myPage";
    }




}