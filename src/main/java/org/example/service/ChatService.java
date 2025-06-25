package org.example.service;

import lombok.RequiredArgsConstructor;
import org.example.repository.ChatRepository;
import org.example.vo.ChatMessage;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ChatService {

    private final ChatRepository chatRepository;

    public ChatMessage saveMessage(ChatMessage message) {
        chatRepository.insertMessage(message);
        return message;
    }


}
