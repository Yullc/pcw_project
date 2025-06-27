package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.example.vo.ChatMessage;

import java.util.List;

@Mapper
public interface ChatRepository {
    void saveMessage(ChatMessage chatMessage);

    List<ChatMessage> getMessagesByTeamId(int teamId);
}
