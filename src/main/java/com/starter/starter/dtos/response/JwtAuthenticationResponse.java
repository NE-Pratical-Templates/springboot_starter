package com.starter.starter.dtos.response;

import com.starter.starter.models.User;
import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class JwtAuthenticationResponse {
    private String accessToken;
    private String tokenType = "Bearer";
    private User user;

    public JwtAuthenticationResponse(String accessToken, User user) {
        this.accessToken = accessToken;
        this.user = user;
    }
}