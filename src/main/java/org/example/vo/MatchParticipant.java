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

    private boolean hasEvaluated;

    // ✅ 프론트 출력을 위한 확장 필드
    private Member member;

    // ✅ 직접 만든 생성자
    public MatchParticipant(Member member, boolean hasEvaluated) {
        this.member = member;
        this.hasEvaluated = hasEvaluated;
    }
}
