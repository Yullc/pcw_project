package org.example.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Article {

    private int id;
    private String title;
    private String playDate;
    private String img;
    private String stadium;
    private String type;
}
