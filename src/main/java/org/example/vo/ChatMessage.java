package org.example.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor

@NoArgsConstructor

@Builder
public class ChatMessage {
    private int teamId;
    private int memberId;
    private String sender;
    private String message;
    private String nickName;
    private String sendTime;

}
