package org.example.controller;

import org.example.interceptor.BeforeActionInterceptor;
import org.example.service.MessageService;
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


    @Autowired
    private MessageService messageService;

    // 받은 쪽지 목록
    @RequestMapping("/usr/message/recevied")
    public String showReceivedMessages(HttpServletRequest req, Model model) {
        Rq rq = (Rq) req.getAttribute("rq");
        int memberId = rq.getLoginedMemberId();

        List<Message> receivedMessages = messageService.getReceivedMessages(memberId);
        model.addAttribute("messages", receivedMessages);
        model.addAttribute("type", "received");

        return "usr/message/list";
    }

    // 보낸 쪽지 목록
    @RequestMapping("/usr/message/sent")
    public String showSentMessages(HttpServletRequest req, Model model) {
        Rq rq = (Rq) req.getAttribute("rq");
        int memberId = rq.getLoginedMemberId();

        List<Message> sentMessages = messageService.getSentMessages(memberId);
        model.addAttribute("messages", sentMessages);
        model.addAttribute("type", "sent");

        return "usr/message/list";
    }

    // 쪽지 작성 폼
    @RequestMapping("/usr/message/write")
    public String showWriteForm(HttpServletRequest req, Model model) {
        int toId = Integer.parseInt(req.getParameter("toId"));
        String toNickname = req.getParameter("toNickname");

        model.addAttribute("toId", toId);
        model.addAttribute("toNickname", toNickname);

        return "usr/message/write";
    }

    // 쪽지 전송 처리
    @RequestMapping("/usr/message/doWrite")
    public String doWrite(HttpServletRequest req) {
        Rq rq = (Rq) req.getAttribute("rq");

        int senderId = rq.getLoginedMemberId();
        String senderNickname = rq.getLoginedMember().getNickName();

        int receiverId = Integer.parseInt(req.getParameter("receiverId"));
        String receiverNickname = req.getParameter("receiverNickname");
        String content = req.getParameter("content");

        messageService.sendMessage(senderId, senderNickname, receiverId, receiverNickname, content);

        return "redirect:/usr/message/sent";
    }
}
