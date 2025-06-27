package org.example.util;

public class MannerUtil {

    public static String getMannerEmoji(Float temperature) {
        if (temperature == null) return "❓"; // 기본 이모지 또는 처리
        if (temperature >= 25 && temperature <= 30) {
            return "😡";
        } else if (temperature >= 30.0001f && temperature <= 34.9999f) {
            return "😐";
        } else if (temperature >= 35 && temperature <= 39.9999f) {
            return "😀";
        } else if (temperature >= 40 && temperature <= 45) {
            return "😍";
        } else {
            System.out.println("temperature: " + temperature);
            return "❓"; // 범위 밖인 경우
        }
    }

    public static float getTemperatureFromEmoji(String emoji) {
        return switch (emoji) {
            case "😡" -> 28.0f;
            case "😐" -> 33.0f;
            case "😊" -> 38.0f;
            case "😍" -> 43.0f;
            default -> 36.5f; // 기본값
        };
    }

}
