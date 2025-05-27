package org.example;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class PublicResourceController {

    @RequestMapping("/usr/home/api")
    public String getResources(Model model) {
        String apiKey = "6cb3e79c3e7a3284b2bf0cd85bf1cd6a";
        String rsrcClsCd = "010500";
        String urlStr = "https://www.eshare.go.kr/eshare-openapi/rsrc/list/" + rsrcClsCd + "/" + apiKey;

        try {
            URL url = new URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            String jsonBody = """
                {
                    "pageNo": 1,
                    "numOfRows": 100,
                    "updBgngYmd": "20220101",
                    "updEndYmd": "20241231"
                }
            """;

            try (OutputStream os = conn.getOutputStream()) {
                os.write(jsonBody.getBytes(StandardCharsets.UTF_8));
            }

            InputStream inputStream = conn.getInputStream();
            ObjectMapper mapper = new ObjectMapper();
            PublicDataResponse response = mapper.readValue(inputStream, PublicDataResponse.class);

            // 🔍 자원명 필터링: "축구", "풋살", "경기장" 포함된 자원만
            List<PublicResource> filtered = response.getData().stream()
                    .filter(r -> {
                        String name = r.getRsrcNm();
                        return name != null && (name.contains("축구") || name.contains("풋살") || name.contains("경기장"));
                    })
                    .collect(Collectors.toList());

            model.addAttribute("resources", filtered);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "usr/home/api";
    }
}
