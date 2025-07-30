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

    @GetMapping("/posts")
    public String posts(Model model) {
        try {
            List<PostResponse> posts = postService.getAllPosts();
            model.addAttribute("posts", posts);
            return "posts";
        } catch (Exception e) {
            model.addAttribute("error", "Không thể tải danh sách bài viết");
            return "error";
        }
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

    @GetMapping("/profile/{userId}")
    public String profile(@PathVariable int userId, Model model) {
        try {
            User user = userService.getUserById(userId);
            if (user == null) {
                model.addAttribute("error", "Không tìm thấy người dùng với ID: " + userId);
                return "error";
            }

            List<PostResponse> userPosts = postService.getUserPosts(userId);
            List<FollowerResponse> followers = followService.getUserFollowers(userId);
            List<FollowerResponse> followings = followService.getUserFollowings(userId);

            model.addAttribute("user", user);
            model.addAttribute("posts", userPosts);
            model.addAttribute("followers", followers);
            model.addAttribute("followings", followings);
            return "profile";
        } catch (Exception e) {
            model.addAttribute("error", "Không thể tải thông tin người dùng: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/create-post")
    public String createPostForm(@RequestParam(value = "userId", required = false) Integer userId, Model model) {
        CreatePostRequest request = new CreatePostRequest();
        if (userId != null) {
            request.setUserId(userId);
        }
        model.addAttribute("request", request);
        return "create-post";
    }

    @PostMapping("/create-post")
    public String createPost(@RequestParam("userId") int userId,
                             @ModelAttribute CreatePostRequest request,
                             RedirectAttributes redirectAttributes) {
        try {
            postService.createPost(userId, request);
            redirectAttributes.addFlashAttribute("success", "Tạo bài viết thành công!");
            return "redirect:/web/profile/" + userId;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Không thể tạo bài viết: " + e.getMessage());
            return "redirect:/web/create-post?userId=" + userId;
        }
    }

    @GetMapping("/test")
    public String test(Model model) {
        model.addAttribute("message", "Spring MVC đã được cấu hình thành công!");
        return "test";
    }

    @GetMapping("/posts/user/{userId}")
    public String showUserPosts(@PathVariable int userId, Model model) {
        try {
            List<PostResponse> posts = postService.getUserPosts(userId);
            User user = userService.getUserById(userId);
            model.addAttribute("posts", posts);
            model.addAttribute("user", user);
            return "posts";
        } catch (Exception e) {
            model.addAttribute("error", "Không thể tải bài viết của người dùng");
            return "error";
        }
    }

    @GetMapping("/user/edit/{userId}")
    public String editUserForm(@PathVariable int userId, Model model) {
        try {
            User user = userService.getUserById(userId);
            if (user == null) {
                model.addAttribute("error", "Không tìm thấy người dùng với ID: " + userId);
                return "error";
            }
            model.addAttribute("user", user);
            return "edit-user";
        } catch (Exception e) {
            model.addAttribute("error", "Không thể tải thông tin người dùng: " + e.getMessage());
            return "error";
        }
    }

    @PostMapping("/user/edit/{userId}")
    public String updateUser(@PathVariable int userId,
                           @RequestParam("userName") String userName,
                           @RequestParam("role") String role,
                           RedirectAttributes redirectAttributes) {
        try {
            User user = userService.getUserById(userId);
            if (user == null) {
                redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng");
                return "redirect:/web/users";
            }

            user.setUserName(userName);
            user.setRole(role);
            userService.update(user);

            redirectAttributes.addFlashAttribute("success", "Cập nhật thông tin người dùng thành công!");
            return "redirect:/web/profile/" + userId;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Không thể cập nhật người dùng: " + e.getMessage());
            return "redirect:/web/user/edit/" + userId;
        }
    }

    @PostMapping("/user/delete/{userId}")
    public String deleteUser(@PathVariable int userId, RedirectAttributes redirectAttributes) {
        try {
            User user = userService.getUserById(userId);
            if (user == null) {
                redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng");
                return "redirect:/web/users";
            }

            userService.delete(userId);
            redirectAttributes.addFlashAttribute("success", "Đã xóa người dùng " + user.getUserName() + " thành công!");
            return "redirect:/web/users";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Không thể xóa người dùng: " + e.getMessage());
            return "redirect:/web/profile/" + userId;
        }
    }
}
