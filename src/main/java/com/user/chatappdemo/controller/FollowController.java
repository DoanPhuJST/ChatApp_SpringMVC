package com.user.chatappdemo.controller;

import com.user.chatappdemo.dto.FollowerResponse;
import com.user.chatappdemo.service.FollowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/follows")
@CrossOrigin(origins = "*")
public class FollowController {

    @Autowired
    private FollowService followService;

    @GetMapping("/followers/{userId}")
    public ResponseEntity<List<FollowerResponse>> getUserFollowers(@PathVariable int userId) {
        List<FollowerResponse> followers = followService.getUserFollowers(userId);
        return new ResponseEntity<>(followers, HttpStatus.OK);
    }

    @GetMapping("/followings/{userId}")
    public ResponseEntity<List<FollowerResponse>> getUserFollowings(@PathVariable int userId) {
        List<FollowerResponse> followings = followService.getUserFollowings(userId);
        return new ResponseEntity<>(followings, HttpStatus.OK);
    }
}
