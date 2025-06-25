package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.example.vo.ChatMessage;

@Mapper
public interface ChatRepository {
    void saveMessage(ChatMessage chatMessage);
}
