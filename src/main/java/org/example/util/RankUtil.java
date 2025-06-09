package org.example.util;

public class RankUtil {
    public static String getRankName(int level) {
        return switch (level) {
            case 1 -> "루키1";
            case 2 -> "루키2";
            case 3 -> "루키3";
            case 4 -> "아마추어1";
            case 5 -> "아마추어2";
            case 6 -> "아마추어3";
            case 7 -> "세미프로1";
            case 8 -> "세미프로2";
            case 9 -> "세미프로3";
            case 10 -> "프로1";
            case 11 -> "프로2";
            case 12 -> "프로3";
            default -> "미정";
        };
    }
}
