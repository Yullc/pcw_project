package org.example.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TeamArticle {
    private int id;
    private String regDate;
    private String updateDate;
    private String teamName;
    private String teamRank;
    private String area;
    private String teamLeader;
}
