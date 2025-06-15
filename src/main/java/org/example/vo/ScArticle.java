package org.example.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ScArticle {
    private int id;
    private String regDate;
    private String playDate;
    private String title;
    private String body;
    private String area;
    private String stadium;
    private String address;
    private String avgLevel;
    private String img;
    private int matchId;
    private String avgLevelName;
    private String code;
}
