package org.example.controller;

import lombok.RequiredArgsConstructor;
import org.example.service.ChatService;
import org.example.vo.ChatMessage;
import org.springframework.messaging.handler.annotation.MessageMapping;
<<<<<<< HEAD
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class ChatController {

    private final SimpMessagingTemplate messagingTemplate;
    private final ChatService chatService;

    @MessageMapping("/chat.sendMessage")
    public void sendMessage(ChatMessage message) {
        System.out.println("메시지 컨트로러 진입");
        System.out.println("💬 수신된 메시지:");
        System.out.println(" - teamId: " + message.getTeamId());
        System.out.println(" - memberId: " + message.getMemberId());
        System.out.println(" - nickName: " + message.getNickName());
        System.out.println(" - message: " + message.getMessage());

        // DB 저장
        ChatMessage saved = chatService.saveMessage(message);
        System.out.println("✅ DB 저장 완료:");
        System.out.println(" - id: " + saved.getMemberId());
        System.out.println(" - sendTime: " + saved.getSendTime());

        // 팀 ID 기반으로 구독자에게 전송
        messagingTemplate.convertAndSend("/topic/chat/" + message.getTeamId(), saved);
        System.out.println("📤 구독자에게 메시지 전송 완료 (teamId: " + message.getTeamId() + ")");
=======
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
>>>>>>> b8940df8c34e97c7c8fc8f430e0c5804baaf738c
    }
}
