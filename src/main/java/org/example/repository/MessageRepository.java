package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.example.vo.Message;

import java.util.List;

@Mapper
public interface MessageRepository {


    public void sendMessage(int senderId, String senderNickname, int receiverId, String receiverNickname, String content);


    public List<Message> getSentMessages(int memberId);


    public List<Message> getReceivedMessages(int memberId);

    public void send(Message msg);
}
