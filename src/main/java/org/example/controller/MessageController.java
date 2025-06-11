package org.example.controller;

import org.example.interceptor.BeforeActionInterceptor;
import org.example.service.MemberService;
import org.example.service.MessageService;
import org.example.util.Ut;
import org.example.vo.Member;
import org.example.vo.Message;
import org.example.vo.Rq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class MessageController {
    private final BeforeActionInterceptor beforeActionInterceptor;

    @Autowired
    private MessageService messageService;

    @Autowired
    private MemberService memberService;

    public MessageController(BeforeActionInterceptor beforeActionInterceptor) {
        this.beforeActionInterceptor = beforeActionInterceptor;
    }

    // 받은 쪽지 목록
    @RequestMapping("/usr/message/recevied")
    public String showReceivedMessages(HttpServletRequest req, Model model) {
        Rq rq = (Rq) req.getAttribute("rq");
        System.out.println("받은 편지함 진입");
        int memberId = rq.getLoginedMemberId();

        List<Message> receivedMessages = messageService.getReceivedMessages(memberId);
        System.out.println("receivedMess"+receivedMessages);
        model.addAttribute("receivedMessages", receivedMessages);
        model.addAttribute("type", "received");

        return "usr/home/myPage";
    }

    // 보낸 쪽지 목록
    @RequestMapping("/usr/message/sent")
    public String showSentMessages(HttpServletRequest req, Model model) {
        Rq rq = (Rq) req.getAttribute("rq");
        System.out.println("보낸 편지함 진입");
        int memberId = rq.getLoginedMemberId();

        List<Message> sentMessages = messageService.getSentMessages(memberId);
        System.out.println("sentMess"+sentMessages);
        model.addAttribute("sentMessages", sentMessages);
        model.addAttribute("type", "sent");

        return "usr/home/myPage";
    }

    // 쪽지 작성 폼
    @RequestMapping("/usr/message/write")
    public String showWriteForm(HttpServletRequest req, Model model) {
        int toId = Integer.parseInt(req.getParameter("toId"));
        String toNickname = req.getParameter("toNickname");

        model.addAttribute("toId", toId);
        model.addAttribute("toNickname", toNickname);

        return "usr/home/myPage";
    }

    // 쪽지 전송 처리
    @RequestMapping("/usr/message/doWriteMsg")
    public String doWrite(HttpServletRequest req, @RequestParam String nickName, Model model) {
        System.out.println("doWrite 진입");

        Rq rq = (Rq) req.getAttribute("rq");
        System.out.println(rq);
        System.out.println(rq.getLoginedMemberId());
        System.out.println(rq.getLoginedMember().getNickName());
        System.out.println(rq.getLoginedMember().getManner());
        System.out.println(rq.getLoginedMember().getRank());

        int senderId = rq.getLoginedMemberId();
        System.out.println("senderId = " + senderId);

        String senderNickname = rq.getLoginedMember().getNickName();
        System.out.println("senderNickname = " + senderNickname);

        Member member = memberService.getMemberByNickname(nickName);
        if (member == null) {
            // 닉네임에 해당하는 회원이 없을 경우 처리
            System.out.println("받는 사람 없음");
            return Ut.jsHistoryBack("F-1", "해당 닉네임의 사용자가 없습니다.");
        }
        int receiverId = member.getId();
        System.out.println(receiverId);
        String receiverNickname = member.getNickName();
        System.out.println("receiverNickname = " + receiverNickname);

        String content = req.getParameter("content");
        System.out.println(content);

        messageService.sendMessage(senderId, senderNickname, receiverId, receiverNickname, content);

        return "redirect:/usr/home/myPage";
    }

}
