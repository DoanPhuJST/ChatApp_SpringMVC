package com.user.chatappdemo.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FollowerResponse {
    private int userId;
    private String username;
    private String role;
    private LocalDateTime followedAt;

}
