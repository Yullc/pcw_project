package org.example.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TeamAlert {
    private int id;
    private int teamId;
    private int memberId;
    private String content;
    private String regDate;

    private String nickName; // JOIN용
}