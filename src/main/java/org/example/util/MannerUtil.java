package org.example.util;

public class MannerUtil {

    public static String getMannerEmoji(Float temperature) {
        if (temperature >= 25 && temperature <= 30) {
            return "😠";
        } else if (temperature >= 31 && temperature <= 35) {
            return "😐";
        } else if (temperature >= 36 && temperature <= 40) {
            return "😀";
        } else if (temperature >= 41 && temperature <= 45) {
            return "🤣";
        } else {
            return "❓"; // 범위 밖인 경우
        }
    }
}
