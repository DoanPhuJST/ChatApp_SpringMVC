package com.user.chatappdemo.service;

import com.user.chatappdemo.dto.FollowerResponse;

import java.util.List;

public interface FollowService {
    List<FollowerResponse> getUserFollowers(int userId);

    List<FollowerResponse> getUserFollowings(int userId);
}
