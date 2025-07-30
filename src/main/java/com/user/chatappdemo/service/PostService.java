package com.user.chatappdemo.service;

import com.user.chatappdemo.dto.CreatePostRequest;
import com.user.chatappdemo.dto.PostResponse;

import java.util.List;

public interface PostService {
    PostResponse createPost(int userId, CreatePostRequest request);

    List<PostResponse> getUserPosts(int userId);

    List<PostResponse> getAllPosts();
}
