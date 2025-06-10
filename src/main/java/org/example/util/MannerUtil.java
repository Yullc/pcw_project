package org.example.util;

public class MannerUtil {

    public static String getMannerEmoji(Float temperature) {
        if (temperature >= 25 && temperature <= 30) {
            return "😡";
        } else if (temperature >= 31 && temperature <= 35) {
            return "😐";
        } else if (temperature >= 36 && temperature <= 40) {
            return "😀";
        } else if (temperature >= 41 && temperature <= 45) {
            return "😍";
        } else {
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
