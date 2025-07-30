package com.user.chatappdemo.service.impl;

import com.user.chatappdemo.dto.FollowerResponse;
import com.user.chatappdemo.entity.Follow;
import com.user.chatappdemo.entity.User;
import com.user.chatappdemo.repository.FollowRepository;
import com.user.chatappdemo.service.FollowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class FollowServiceImpl implements FollowService {

    @Autowired
    private FollowRepository followRepository;

    @Override
    public List<FollowerResponse> getUserFollowers(int userId) {
        try {
            System.out.println("Getting followers for user ID: " + userId);
            List<Follow> followers = followRepository.findFollowersByUserId(userId);
            System.out.println("Found " + followers.size() + " followers");

            return followers.stream()
                    .map(follow -> {
                        FollowerResponse response = convertToFollowerResponse(follow.getFollower(), follow.getCreatedAt());
                        System.out.println("Follower: " + response.getUsername() + " (ID: " + response.getUserId() + ")");
                        return response;
                    })
                    .collect(Collectors.toList());
        } catch (Exception e) {
            System.err.println("Error getting followers for user " + userId + ": " + e.getMessage());
            e.printStackTrace();
            return List.of();
        }
    }

    @Override
    public List<FollowerResponse> getUserFollowings(int userId) {
        try {
            System.out.println("Getting followings for user ID: " + userId);
            List<Follow> followings = followRepository.findFollowingsByUserId(userId);
            System.out.println("Found " + followings.size() + " followings");

            return followings.stream()
                    .map(follow -> {
                        FollowerResponse response = convertToFollowerResponse(follow.getFollowed(), follow.getCreatedAt());
                        System.out.println("Following: " + response.getUsername() + " (ID: " + response.getUserId() + ")");
                        return response;
                    })
                    .collect(Collectors.toList());
        } catch (Exception e) {
            System.err.println("Error getting followings for user " + userId + ": " + e.getMessage());
            e.printStackTrace();
            return List.of();
        }
    }

    private FollowerResponse convertToFollowerResponse(User user, LocalDateTime followedAt) {
        FollowerResponse response = new FollowerResponse();
        response.setUserId(user.getId());
        response.setUsername(user.getUserName());
        response.setRole(user.getRole());
        response.setFollowedAt(followedAt);
        return response;
    }
}
