package org.example.controller;

import lombok.RequiredArgsConstructor;
import org.example.vo.ChatMessage;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class ChatMessageController {

    @MessageMapping("/chat/send")
    public void sendMessage(ChatMessage message) {
        // 메시지를 해당 채팅방 구독자들에게 전송
        messagingTemplate.convertAndSend("/sub/chatroom/" + message.getTeamId(), message);
    }

    private final SimpMessageSendingOperations messagingTemplate;
}
