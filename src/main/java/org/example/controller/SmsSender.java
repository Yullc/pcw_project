package org.example.controller;

import okhttp3.*;
import org.json.JSONObject;

public class SmsSender {

    public static void main(String[] args) throws Exception {
        String apiKey = "";       // 쿨에스엠에스에서 발급 받은 API Key
        String apiSecret = ""; // API Secret

        OkHttpClient client = new OkHttpClient();

        JSONObject json = new JSONObject();
        json.put("to", "01012345678");        // 수신자 번호
        json.put("from", "01033894452");      // 발신자 번호 (쿨SMS에서 인증된 번호)
        json.put("text", "경기가 1시간 뒤에 시작 합니다.");
        json.put("type", "SMS");

        RequestBody body = RequestBody.create(
                json.toString(),
                MediaType.parse("application/json; charset=utf-8")
        );

        Request request = new Request.Builder()
                .url("https://api.coolsms.co.kr/messages/v4/send")
                .addHeader("Authorization", Credentials.basic(apiKey, apiSecret))
                .post(body)
                .build();

        try (Response response = client.newCall(request).execute()) {
            System.out.println("응답 코드: " + response.code());
            System.out.println("응답 본문: " + response.body().string());
        }
    }
}
