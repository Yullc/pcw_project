package org.example.service;

import lombok.RequiredArgsConstructor;
import org.example.repository.ChatRepository;
import org.example.vo.ChatMessage;
import org.springframework.stereotype.Service;

<<<<<<< HEAD
@Service
@RequiredArgsConstructor
=======
@RequiredArgsConstructor
@Service
>>>>>>> b8940df8c34e97c7c8fc8f430e0c5804baaf738c
public class ChatService {

    private final ChatRepository chatRepository;

<<<<<<< HEAD
    public ChatMessage saveMessage(ChatMessage message) {
        chatRepository.insertMessage(message);
        return message;
    }


}
=======
    public void saveMessage(ChatMessage chatMessage) {
        chatRepository.saveMessage(chatMessage);
    }
}
>>>>>>> b8940df8c34e97c7c8fc8f430e0c5804baaf738c
