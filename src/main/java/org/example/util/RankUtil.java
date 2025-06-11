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
            default -> "루키1";
        };
    }

    public static int getNameToRank(String rankName) {
        return switch (rankName) {
            case "루키1" -> 1;
            case "루키2" -> 2;
            case "루키3" -> 3;
            case "아마추어1" -> 4;
            case "아마추어2" -> 5;
            case "아마추어3" -> 6;
            case "세미프로1" -> 7;
            case "세미프로2" -> 8;
            case "세미프로3" -> 9;
            case "프로1" -> 10;
            case "프로2" -> 11;
            case "프로3" -> 12;
            default -> 1;
        };
    }
    public static int[] getRangeByCategory(String category) {
        return switch (category) {
            case "루키" -> new int[]{1, 3};
            case "아마추어" -> new int[]{4, 6};
            case "세미프로" -> new int[]{7, 9};
            case "프로" -> new int[]{10, 12};
            default -> null;
        };
    }


}
