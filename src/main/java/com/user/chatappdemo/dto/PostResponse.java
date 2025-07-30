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
public class PostResponse {
    private int id;
    private String title;
    private String body;
    private String status;
    private LocalDateTime createAt;
    private String username;
    private int userId;

}
