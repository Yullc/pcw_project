package org.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
    @RequestMapping("/usr/home/main")
    public String showMain() {
        System.out.println("UsrHomeController.showMain");

        return "/usr/home/main";
    }

    @RequestMapping("/")
    public String showMain2() {
        return "redirect:/usr/home/main";
    }
}