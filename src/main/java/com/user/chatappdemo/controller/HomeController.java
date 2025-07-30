package com.user.chatappdemo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.time.LocalDateTime;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("message", "Chào mừng đến với Chat App!");
        model.addAttribute("description", "Spring MVC đã được cấu hình thành công");
        model.addAttribute("currentTime", LocalDateTime.now());
        return "home";
    }

    @GetMapping("/test")
    public String test(Model model) {
        model.addAttribute("message", "Spring MVC đang hoạt động tốt!");
        model.addAttribute("timestamp", LocalDateTime.now());
        return "test";
    }
}
