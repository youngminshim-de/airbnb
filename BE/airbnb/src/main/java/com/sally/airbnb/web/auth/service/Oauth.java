package com.sally.airbnb.web.auth.service;

import com.sally.airbnb.web.auth.OAuthType;
import com.sally.airbnb.web.auth.controller.response.TokenResponse;
import com.sally.airbnb.web.auth.controller.response.UserInfoResponse;
import org.springframework.web.reactive.function.client.WebClient;

public interface Oauth {

    WebClient webClient = WebClient.create();

    TokenResponse getToken(String code);

    UserInfoResponse getUserInfo(String token, OAuthType type);

    UserInfoResponse readUserInfo(String code, OAuthType type);
}
