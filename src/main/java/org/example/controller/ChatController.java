package org.example.controller;

import lombok.RequiredArgsConstructor;
import org.example.service.ChatService;
import org.example.vo.ChatMessage;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController // ✅ @Controller + @ResponseBody
@RequiredArgsConstructor
public class ChatController {

    private final ChatService chatService;
    private final SimpMessageSendingOperations messagingTemplate;
    // WebSocket용 메시지 수신
    @MessageMapping("/chat/send")
    public void receiveMessage(ChatMessage chatMessage) {
        System.out.println("✅ [ChatController] 메시지 수신: " + chatMessage);
        chatService.saveMessage(chatMessage);
        // 팀별 채널로 메시지 전송
        messagingTemplate.convertAndSend("/sub/chatroom/" + chatMessage.getTeamId(), chatMessage);
    }

    // ✅ 채팅 기록 조회용 REST API
    @GetMapping("/chat/history")
    @ResponseBody
    public List<ChatMessage> getChatHistory(@RequestParam("teamId") int teamId) {
        return chatService.getMessagesByTeamId(teamId);
    }
}
