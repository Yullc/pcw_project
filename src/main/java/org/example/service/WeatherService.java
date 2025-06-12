package org.example.service;

import org.example.vo.WeatherDto;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
public class WeatherService {
    private final String API_KEY = "acd92a9832f723c9fd085366c7196fd5";

    public List<WeatherDto> getWeatherByAreaAndDate(String area, LocalDate date) {
        System.out.println("🛰️ WeatherService 진입");
        System.out.println("🎯 경기 날짜 (playDate): " + date);

        String cityName = convertAreaToCity(area);
        System.out.println("📍 변환된 도시 이름: " + cityName);

        String url = String.format(
                "https://api.openweathermap.org/data/2.5/forecast?q=%s,KR&appid=%s&units=metric",
                cityName, API_KEY
        );

        RestTemplate restTemplate = new RestTemplate();
        List<WeatherDto> weatherList = new ArrayList<>();

        try {
            String response = restTemplate.getForObject(url, String.class);
            JSONObject json = new JSONObject(response);
            JSONArray list = json.getJSONArray("list");

            for (int i = 0; i < list.length(); i++) {
                JSONObject item = list.getJSONObject(i);
                String dt_txt = item.getString("dt_txt");

                // 1. UTC 시간 파싱
                LocalDateTime utcDateTime = LocalDateTime.parse(dt_txt, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                ZonedDateTime koreaTime = utcDateTime.atZone(ZoneId.of("UTC")).withZoneSameInstant(ZoneId.of("Asia/Seoul"));

                // 2. 날짜 비교 (KST 기준)
                if (koreaTime.toLocalDate().equals(date)) {
                    double temp = item.getJSONObject("main").getDouble("temp");
                    String description = item.getJSONArray("weather").getJSONObject(0).getString("description");
                    String iconCode = item.getJSONArray("weather").getJSONObject(0).getString("icon");
                    String iconUrl = "https://openweathermap.org/img/wn/" + iconCode + "@2x.png";

                    // 3. 표시용 시간 포맷
                    String displayTime = koreaTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

                    System.out.printf("🌤️ %s → %.1f°C, %s (%s)%n", displayTime, temp, description, iconUrl);

                    weatherList.add(new WeatherDto(description, temp, iconUrl, displayTime));
                }
            }

        } catch (HttpClientErrorException e) {
            System.err.println("🌧️ OpenWeather API 오류: " + e.getResponseBodyAsString());
        }

        return weatherList;
    }

    private String convertAreaToCity(String area) {
        if (area.contains("서울")) return "Seoul";
        if (area.contains("경기")) return "Suwon";
        if (area.contains("부산")) return "Busan";
        if (area.contains("인천")) return "Incheon";
        if (area.contains("대전")) return "Daejeon";
        if (area.contains("대구")) return "Daegu";
        if (area.contains("광주")) return "Gwangju";
        if (area.contains("울산")) return "Ulsan";
        if (area.contains("제주")) return "Jeju";
        if (area.contains("세종")) return "Sejong";
        if (area.contains("강원")) return "Gangneung";
        if (area.contains("충북")) return "Cheongju";
        if (area.contains("충남")) return "Cheonan";
        if (area.contains("경북")) return "Pohang";
        if (area.contains("경남")) return "Changwon";
        if (area.contains("전북")) return "Jeonju";
        if (area.contains("전남")) return "Yeosu";
        return "Seoul";
    }
}
