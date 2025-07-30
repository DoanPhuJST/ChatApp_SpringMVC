package com.user.chatappdemo.service.impl;

import com.user.chatappdemo.dto.CreatePostRequest;
import com.user.chatappdemo.dto.PostResponse;
import com.user.chatappdemo.entity.Post;
import com.user.chatappdemo.entity.User;
import com.user.chatappdemo.repository.PostRepository;
import com.user.chatappdemo.repository.UserRepository;
import com.user.chatappdemo.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class PostServiceImpl implements PostService {

    @Autowired
    private PostRepository postRepository;

    @Autowired
    private UserRepository userRepository;

    @Override
    public PostResponse createPost(int userId, CreatePostRequest request) {
        User user = userRepository.findById(userId);
        if (user == null) {
            throw new RuntimeException("User not found with id: " + userId);
        }

        Post post = new Post();
        post.setTitle(request.getTitle());
        post.setBody(request.getBody());
        post.setStatus(request.getStatus());
        post.setCreateAt(LocalDateTime.now());
        post.setUser(user);

        Post savedPost = postRepository.save(post);

        return convertToPostResponse(savedPost);
    }

    @Override
    public List<PostResponse> getUserPosts(int userId) {
        List<Post> posts = postRepository.findByUserId(userId);
        return posts.stream()
                .map(this::convertToPostResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<PostResponse> getAllPosts() {
        List<Post> posts = postRepository.findAll();
        return posts.stream()
                .map(this::convertToPostResponse)
                .collect(Collectors.toList());
    }

    private PostResponse convertToPostResponse(Post post) {
        PostResponse response = new PostResponse();
        response.setId(post.getId());
        response.setTitle(post.getTitle());
        response.setBody(post.getBody());
        response.setStatus(post.getStatus());
        response.setCreateAt(post.getCreateAt());
        response.setUsername(post.getUser().getUserName());
        response.setUserId(post.getUser().getId());
        return response;
    }
}
