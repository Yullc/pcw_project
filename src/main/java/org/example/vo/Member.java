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
    private String regDate;
    private String updateDate;
    private String loginId;
    private String loginPw;
    private String loginPwCheck;
    private String email;
    private int poneNm;
    private String bornDate;
    private String area;
    private String gender;
    private String name;
    private String nickName;
    private String authLevel;
    private String rank;
    private int delStatus;
    private String delDate;
    private Float manner;
    private String teamNm;
    private String profileImg;
    private String intro;
}