package org.example.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MatchParticipant {

    private int id;
    private int matchId;
    private int memberId;
    private String position;
    private String teamId;
    private String regDate;
}