package com.user.chatappdemo.controller;

import com.user.chatappdemo.dto.CreatePostRequest;
import com.user.chatappdemo.dto.FollowerResponse;
import com.user.chatappdemo.dto.PostResponse;
import com.user.chatappdemo.entity.User;
import com.user.chatappdemo.service.FollowService;
import com.user.chatappdemo.service.PostService;
import com.user.chatappdemo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/web")
public class WebController {

    @Autowired
    private PostService postService;

    @Autowired
    private UserService userService;

    @Autowired
    private FollowService followService;

    @GetMapping("/")
    public String home(Model model) {
        try {
            List<PostResponse> posts = postService.getAllPosts();
            model.addAttribute("posts", posts);
        } catch (Exception e) {
            model.addAttribute("posts", List.of());
            model.addAttribute("error", "Không thể tải danh sách bài viết");
        }
        return "home";
    }


    @GetMapping("/users")
    public String users(Model model) {
        try {
            List<User> users = userService.getAllUsers();
            model.addAttribute("users", users);
            return "users";
        } catch (Exception e) {
            model.addAttribute("error", "Không thể tải danh sách người dùng");
            return "error";
        }
    }
}
