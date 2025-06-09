package org.example.vo;

import lombok.Getter;

@Getter
public class WeatherDto {
    private final String description;
    private final double temp;
    private final String iconUrl;
    private final String time; // ← 새 필드 추가

    public WeatherDto(String description, double temp, String iconUrl, String time) {
        this.description = description;
        this.temp = temp;
        this.iconUrl = iconUrl;
        this.time = time;


    }
}