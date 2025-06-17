package org.example.controller;

import org.example.service.SolapiService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class SmsController {

    private final SolapiService solapiService;

    @GetMapping("/smsTest")
    public String showForm() {
        return "smsTest";
    }

    // ✅ GET 또는 POST 둘 다 허용
    @RequestMapping(value = "/sendSms", method = {RequestMethod.GET, RequestMethod.POST})
    public String sendSms(@RequestParam(required = false) String to,
                          @RequestParam(required = false) String text,
                          Model model) {

        // 초기 진입(GET) 시에는 전송 안 함
        if (to == null || text == null) {
            model.addAttribute("result", "📭 수신 번호와 메시지를 입력해 주세요.");
            return "smsTest";
        }

        boolean success = solapiService.sendSms(to, text);
        model.addAttribute("result", success ? "✅ 전송 성공!" : "❌ 전송 실패!");
        return "smsTest";
    }



}
