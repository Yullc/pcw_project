package org.example.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.example.PublicDataResponse;
import org.example.repository.FootballStadiumRepository;
import org.example.repository.SoccerStadiumRepository;
import org.example.vo.PublicResource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;

@Controller
public class PublicResourceController {

    @Autowired
    private FootballStadiumRepository footballStadiumRepository;

    @Autowired
    private SoccerStadiumRepository soccerStadiumRepository;

    @RequestMapping("/usr/home/api/save")
    public String saveResourcesToDB(Model model) {
        String apiKey = "6cb3e79c3e7a3284b2bf0cd85bf1cd6a";
        String rsrcClsCd = "010500";
        String baseUrl = "https://www.eshare.go.kr/eshare-openapi/rsrc/list/" + rsrcClsCd + "/" + apiKey;

        int footballCount = 0;
        int soccerCount = 0;
        int page = 1;

        try {
            while (true) {
                URL url = new URL(baseUrl);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("POST");
                conn.setRequestProperty("Content-Type", "application/json");
                conn.setDoOutput(true);

                // 현재 페이지 번호 포함한 JSON 요청 본문
                String jsonBody = "{"
                        + "\"pageNo\": " + page + ","
                        + "\"numOfRows\": 100,"
                        + "\"updBgngYmd\": \"20220101\","
                        + "\"updEndYmd\": \"20251231\""
                        + "}";

                try (OutputStream os = conn.getOutputStream()) {
                    os.write(jsonBody.getBytes(StandardCharsets.UTF_8));
                }

                InputStream inputStream = conn.getInputStream();
                ObjectMapper mapper = new ObjectMapper();
                PublicDataResponse response = mapper.readValue(inputStream, PublicDataResponse.class);

                List<PublicResource> data = response.getData();
                if (data == null || data.isEmpty()) break; // 더 이상 데이터 없음 → 반복 종료

                for (PublicResource resource : data) {
                    String name = resource.getRsrcNm();
                    if (name == null) continue;

                    if (name.contains("풋살")) {
                        footballStadiumRepository.save(resource);
                        footballCount++;
                    } else if (name.contains("축구")) {
                        soccerStadiumRepository.save(resource);
                        soccerCount++;
                    }
                }

                page++; // 다음 페이지로 이동
            }

            model.addAttribute("footballCount", footballCount);
            model.addAttribute("soccerCount", soccerCount);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "저장 실패: " + e.getMessage());
        }

        return "usr/home/save_result";
    }
}
