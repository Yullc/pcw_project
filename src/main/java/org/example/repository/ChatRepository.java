package org.example.repository;

<<<<<<< HEAD
import org.example.vo.ChatMessage;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatRepository {
    void insertMessage(ChatMessage message);
=======
import org.apache.ibatis.annotations.Mapper;
import org.example.vo.ChatMessage;

@Mapper
public interface ChatRepository {
    void saveMessage(ChatMessage chatMessage);
>>>>>>> b8940df8c34e97c7c8fc8f430e0c5804baaf738c
}
