package org.example.service;

import lombok.RequiredArgsConstructor;
import org.example.repository.MatchParticipantRepository;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class MatchNotificationScheduler {

    private final MatchParticipantRepository matchParticipantRepository;
    private final SolapiService solapiService;

    // ✨ 1분마다 실행되며, 1시간 후에 시작될 경기 참가자에게 문자 전송
    @Scheduled(cron = "0 0 0 * * *")  // 매 분마다 실행
    public void sendSmsToUpcomingParticipants() {
        List<Map<String, Object>> participantList = matchParticipantRepository.getParticipantsForMatchesInOneHour();

        for (Map<String, Object> row : participantList) {
            String phoneNumber = (String) row.get("phoneNumber");
            String stadiumName = (String) row.get("stadium");

            String message = "⚽ [" + stadiumName + "] 에서 경기가 1시간 후 시작됩니다! 준비해주세요!";
            solapiService.sendSms(phoneNumber, message);
        }

        System.out.println("✅ 자동 문자 전송 완료: " + participantList.size() + "명");
    }
}
