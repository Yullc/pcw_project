package org.example.repository;


import org.example.vo.ChatMessage;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatRepository {
    void insertMessage(ChatMessage message);



}
