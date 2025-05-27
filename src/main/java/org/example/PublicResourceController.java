package org.example;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model; // ✅ 이걸로 변경
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

@Controller
public class PublicResourceController {

    @RequestMapping("/usr/home/api")
    public String getResources(Model model) {
        String apiKey = "6cb3e79c3e7a3284b2bf0cd85bf1cd6a";
        String rsrcClsCd = "010500";
        String urlStr = "https://www.eshare.go.kr/eshare-openapi/rsrc/list/" + rsrcClsCd + "/" + apiKey;

        PublicDataResponse response = null;
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

            OutputStream os = conn.getOutputStream();
            os.write(jsonBody.getBytes("UTF-8"));
            os.flush();
            os.close();

            InputStream inputStream = conn.getInputStream();
            ObjectMapper mapper = new ObjectMapper();
            response = mapper.readValue(inputStream, PublicDataResponse.class);

            model.addAttribute("resources", response.getData());
        } catch (Exception e) {
            e.printStackTrace();
        }



        return "usr/home/api";

    }
}
