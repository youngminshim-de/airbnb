package com.sally.airbnb.web.auth.controller;

import com.sally.airbnb.web.auth.OAuthType;
import com.sally.airbnb.web.auth.controller.response.UserInfoResponse;
import com.sally.airbnb.web.auth.service.OauthService;
import com.sally.airbnb.web.user.domain.User;
import com.sally.airbnb.web.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class OauthController {

    private final OauthService oauthService;

    @GetMapping("/oauth/userInfo")
    public String login(@RequestParam("type") OAuthType type, @RequestParam("code") String code) {
        return oauthService.login(type, code);
    }
}
