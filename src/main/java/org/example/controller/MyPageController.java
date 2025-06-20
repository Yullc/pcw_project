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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
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
    @ResponseBody
    public String uploadProfileImg(HttpServletRequest req, @RequestParam("profileImg") MultipartFile file) {
        Rq rq = (Rq) req.getAttribute("rq");
        int memberId = rq.getLoginedMemberId();

        if (file.isEmpty()) {
            System.out.println("[업로드 실패] 빈 파일입니다.");
            return Ut.jsHistoryBack("F-1", "파일이 비어있습니다.");
        }

        // UUID + 파일명 구성
        String uuid = UUID.randomUUID().toString().substring(0, 8);
        String fileName = "profile_" + memberId + "_" + uuid + ".jpg";
        String relativePath = "/img/" + fileName;
        String savePath = new File("src/main/resources/static" + relativePath).getAbsolutePath();

        // 로그로 추적할 주요 정보
        System.out.println("=====================================");
        System.out.println("▶ 회원 ID: " + memberId);
        System.out.println("▶ 생성 파일명: " + fileName);
        System.out.println("▶ 절대 저장경로: " + savePath);
        System.out.println("▶ 브라우저 접근경로: http://localhost:8080" + relativePath);
        System.out.println("=====================================");

        try {
            // 기존 파일 삭제
            File folder = new File("src/main/resources/static/img");
            File[] oldFiles = folder.listFiles((dir, name) -> name.startsWith("profile_" + memberId + "_"));
            if (oldFiles != null) {
                for (File oldFile : oldFiles) {
                    if (oldFile.delete()) {
                        System.out.println("✔ 기존 파일 삭제: " + oldFile.getName());
                    } else {
                        System.out.println("⚠ 기존 파일 삭제 실패: " + oldFile.getName());
                    }
                }
            }

            // 새 파일 저장
            file.transferTo(new File(savePath));
            System.out.println("✔ 새 프로필 이미지 저장 완료");

            // DB 업데이트
            myPageService.updateProfileImg(memberId, relativePath);
            System.out.println("✔ DB 경로 저장 완료: " + relativePath);

            return Ut.jsReplace("S-1", "프로필 이미지가 업로드되었습니다.", "/usr/home/myPage");

        } catch (IOException e) {
            System.out.println("❌ [에러] 파일 저장 중 오류: " + e.getMessage());
            return Ut.jsHistoryBack("F-2", "파일 저장 중 오류 발생");
        }
    }



}