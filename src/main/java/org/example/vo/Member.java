package org.example.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Member {
    private int id;
    private LocalDateTime regDate;
    private LocalDateTime updateDate;
    private String loginId;
    private String loginPw;
    private int poneNm;
    private LocalDateTime bornDate;
    private String area;
    private String gender;
    private String name;
    private String nickName;
    private String authLevel;
    private String rank;
    private int delStatus;
    private LocalDateTime delDate;
    private Float manner;
    private String teamNm;
}