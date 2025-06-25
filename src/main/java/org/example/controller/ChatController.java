package org.example.controller;

import lombok.RequiredArgsConstructor;
import org.example.service.ChatService;
import org.example.vo.ChatMessage;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;

@RequiredArgsConstructor
@MessageMapping("/chat/send")
public class ChatController {

    private final SimpMessageSendingOperations messagingTemplate;
    private final ChatService chatService;

    @MessageMapping("/chat/send")
    public void receiveMessage(ChatMessage chatMessage) {
        // 1. DB에 저장
        System.out.println("ChatController 진입");
        chatService.saveMessage(chatMessage);
        System.out.println("ChatMessgae= "+chatMessage);
        // 2. 팀 채팅방에 다시 전송
        messagingTemplate.convertAndSend("/sub/chatroom/" + chatMessage.getTeamId(), chatMessage);
    }
}
