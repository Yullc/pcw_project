package org.example.service;

import org.example.vo.WeatherDto;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
public class WeatherService {
    private final String API_KEY = "acd92a9832f723c9fd085366c7196fd5";

    public List<WeatherDto> getWeatherByAreaAndDate(String area, LocalDate date) {
        System.out.println("🛰️ WeatherService 진입");
        System.out.println("🎯 경기 날짜 (playDate): " + date);  // date는 LocalDate

        String cityName = "Seoul"; // 일단 서울만 고정

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
                LocalDateTime dateTime = LocalDateTime.parse(dt_txt, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

                if (dateTime.toLocalDate().equals(date)) {
                    double temp = item.getJSONObject("main").getDouble("temp");
                    String description = item.getJSONArray("weather").getJSONObject(0).getString("description");
                    String iconCode = item.getJSONArray("weather").getJSONObject(0).getString("icon");
                    String iconUrl = "https://openweathermap.org/img/wn/" + iconCode + "@2x.png";

                    System.out.printf("🌤️ %s → %.1f°C, %s (%s)%n", dt_txt, temp, description, iconUrl);  // 로그!

                    weatherList.add(new WeatherDto(description, temp, iconUrl, dt_txt));
                }
            }


        } catch (HttpClientErrorException e) {
            System.err.println("🌧️ OpenWeather API 오류: " + e.getResponseBodyAsString());
        }

        return weatherList;
    }
    private String convertAreaToCity(String area) {
        return switch (area) {
            case "서울" -> "Seoul";
            case "경기" -> "Suwon";
            case "부산" -> "Busan";
            case "인천" -> "Incheon";
            case "대전" -> "Daejeon";
            case "대구" -> "Daegu";
            case "광주" -> "Gwangju";
            case "울산" -> "Ulsan";
            case "제주" -> "Jeju";
            case "세종" -> "Sejong";
            case "강원도" -> "Gangneung";
            case "충청북도" -> "Cheongju";
            case "충청남도" -> "Cheonan";
            case "경상북도" -> "Pohang";
            case "경상남도" -> "Changwon";
            case "전라북도" -> "Jeonju";
            case "전라남도" -> "Yeosu";
            default -> "Seoul";
        };
    }
}