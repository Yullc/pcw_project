package org.example;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
    @RequestMapping("/usr/home/main")
    public String showMain() {
        System.out.println("UsrHomeController.showMain");

        return "/usr/home/main";
    }


    @RequestMapping("/usr/home/foot_menu")
    public String showfoot_menu() {
        System.out.println("풋살메뉴");

        return "/usr/home/foot_menu";
    }

    @RequestMapping("/usr/home/APITest")
    public String showAPITest() {
        return "/usr/home/APITest";
    }


    @RequestMapping("/")
    public String showMain2() {
        return "redirect:/usr/home/main";
    }
}