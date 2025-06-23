package org.example.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MercenaryArticle {
    private int id;
    private String regDate;
    private String updateDate;
    private String title;
    private String body;
    private int memberId;
    private boolean userCanModify;
    private boolean userCanDelete;
    private String area;
    private String avgLevelName;
    private String teamName;
    private String teamRank;
    private String extra__writer;
    private String rankName;
}
