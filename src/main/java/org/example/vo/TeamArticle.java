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
    private String title;
    private String body;
    private String teamLeader;
    private int memberId;
    private int teamId;
    private boolean userCanModify;
    private boolean userCanDelete;
    private String avgLevelName;
    private String teamName;
    private String teamRank;
    private String area;

    private String extra__writer;
}
