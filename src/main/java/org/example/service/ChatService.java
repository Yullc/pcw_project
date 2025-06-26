package org.example.service;

import lombok.RequiredArgsConstructor;
import org.example.repository.ChatRepository;
import org.example.vo.ChatMessage;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class ChatService {

    private final ChatRepository chatRepository;

    public void saveMessage(ChatMessage chatMessage) {
        chatRepository.saveMessage(chatMessage);
    }

    public List<ChatMessage> getMessagesByTeamId(int teamId) {
        return chatRepository.getMessagesByTeamId(teamId);
    }
}