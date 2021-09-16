package com.sally.airbnb.web.auth.service;

import com.sally.airbnb.web.auth.OAuthType;
import com.sally.airbnb.web.auth.controller.response.UserInfoResponse;
import com.sally.airbnb.web.auth.jwt.JwtUtil;
import com.sally.airbnb.web.user.OAuthInfo;
import com.sally.airbnb.web.user.domain.User;
import com.sally.airbnb.web.user.mapper.UserMapper;
import com.sally.airbnb.web.user.repository.UserRepository;
import com.sally.airbnb.web.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class OauthService {

    private final UserRepository userRepository;
    private final JwtUtil jwtUtil;

    private final Map<String, Oauth> oauthMap;

    public UserInfoResponse getUserInfo(OAuthType type, String code) {
        Oauth oauth = oauthMap.get(type.name().toLowerCase());
        return oauth.readUserInfo(code, type);
    }

    public String login(OAuthType type, String code) {
        UserInfoResponse userInfo = getUserInfo(type, code);
        Optional<User> optionalUser = userRepository.findByOAuthInfo(new OAuthInfo(userInfo.getOAuthType(), userInfo.getResourceServerId()));
        User user = optionalUser.orElseGet(() -> userRepository.save(UserMapper.INSTANCE.UserInfoToUser(userInfo)));
        return jwtUtil.getJWT(user);
    }
}
