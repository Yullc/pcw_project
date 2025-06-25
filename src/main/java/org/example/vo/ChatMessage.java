package org.example.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
<<<<<<< HEAD
=======
@NoArgsConstructor
>>>>>>> b8940df8c34e97c7c8fc8f430e0c5804baaf738c
@Builder
public class ChatMessage {
    private int teamId;
    private int memberId;
    private String message;
<<<<<<< HEAD
    private String nickName;
    private String sendTime;
=======
    private String sendTime;

>>>>>>> b8940df8c34e97c7c8fc8f430e0c5804baaf738c
}
