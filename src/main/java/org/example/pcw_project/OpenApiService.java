package org.example.pcw_project;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class OpenApiService {

    private final RestTemplate restTemplate = new RestTemplate();

    public String getResourceList() {
        String apiKey = "6cb3e79c3e7a3284b2bf0cd85bf1cd6a";
        String url = "https://www.eshare.go.kr/eshare-openapi/rsrc/list/" + apiKey;
        return restTemplate.getForObject(url, String.class);
    }
}