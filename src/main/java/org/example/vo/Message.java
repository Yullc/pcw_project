package org.example.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Message {
    private int id;
    private int senderId;
    private String senderNickname;
    private int receiverId;
    private String receiverNickname;
    private String content;
    private String sendDate;

    private int teamId;
}
