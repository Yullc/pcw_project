package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.example.service.MatchParticipantService;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;

import java.io.IOException;
import java.util.List;
@Controller
public class MyPageController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private MyPageService myPageService;

    @Autowired
    private MessageService messageService;
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

    @PostMapping("/usr/home/uploadProfileImg")
    public String uploadProfileImg(HttpServletRequest req, @RequestParam("profileImg") MultipartFile file) {
        Rq rq = (Rq) req.getAttribute("rq");
        int memberId = rq.getLoginedMemberId();

        if (file.isEmpty()) {
            return Ut.jsHistoryBack("F-1", "파일이 비어있습니다.");
        }

        // 저장 경로 예시
        String fileName = "profile_" + memberId + ".jpg";
        String savePath = new File("src/main/resources/static/img/" + fileName).getAbsolutePath();

        try {
            file.transferTo(new File(savePath));
        } catch (IOException e) {
            return Ut.jsHistoryBack("F-2", "파일 저장 중 오류 발생");
        }

        // DB에 경로 업데이트
        String relativePath = "/img/" + fileName;
        myPageService.updateProfileImg(memberId, relativePath);
        savePath = new File("src/main/resources/static/img/" + fileName).getAbsolutePath();

        return Ut.jsReplace("S-1", "프로필 이미지가 업로드되었습니다.", "/usr/home/myPage");
    }


}