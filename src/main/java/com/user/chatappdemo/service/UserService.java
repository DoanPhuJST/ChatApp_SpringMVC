package com.user.chatappdemo.service;

import com.user.chatappdemo.entity.User;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface UserService {
    List<User> getAllUsers(); // Add this method for consistency

    User getUserById(int id); // Add this method to get user by ID

    User add(User user);

    User update(User user);

    void delete(int id);
}
