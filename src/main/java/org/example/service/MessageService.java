package org.example.service;

import org.example.repository.MessageRepository;
import org.example.vo.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageService {

    @Autowired
    private MessageRepository messageRepository;



    public List<Message> getReceivedMessages(int memberId) {

        return messageRepository.getReceivedMessages(memberId);
    }

    public List<Message> getSentMessages(int memberId) {

        return messageRepository.getSentMessages(memberId);
    }

    public void sendMessage(int senderId, String senderNickname, int receiverId, String receiverNickname, String content) {

        messageRepository.sendMessage(senderId, senderNickname, receiverId, receiverNickname, content);
    }

    public void send(Message msg) {
        messageRepository.send(msg); // MyBatis 쿼리 호출
    }
}