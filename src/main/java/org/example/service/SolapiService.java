package org.example.service;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class SolapiService {

    private final DefaultMessageService messageService;

    public SolapiService(
            @Value("${solapi.api-key}") String apiKey,
            @Value("${solapi.api-secret}") String apiSecret
    ) {
        this.messageService = NurigoApp.INSTANCE.initialize(
                apiKey,
                apiSecret,
                "https://api.coolsms.co.kr"
        );
    }

    public boolean sendSms(String to, String text) {
        Message message = new Message();
        message.setFrom("01033894452"); // 발신자 번호
        message.setTo(to);              // 수신자 번호
        message.setText(text);          // 메시지 내용

        try {
            SingleMessageSentResponse response = messageService.sendOne(new SingleMessageSendingRequest(message));
            System.out.println("응답 결과: " + response);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
