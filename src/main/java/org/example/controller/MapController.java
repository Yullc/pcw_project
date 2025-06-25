package org.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MapController {

    @GetMapping("/usr/map")
    public String showMapPage() {
        return "usr/map"; // /WEB-INF/jsp/usr/map.jsp를 의미
    }
}