package com.sally.airbnb.web.auth.service;

import com.sally.airbnb.web.auth.OAuthType;
import com.sally.airbnb.web.auth.controller.request.AccessTokenRequest;
import com.sally.airbnb.web.auth.controller.response.TokenResponse;
import com.sally.airbnb.web.auth.controller.response.UserInfoResponse;
import com.sally.airbnb.web.auth.exception.OAuthRequestNotValidException;
import com.sally.airbnb.web.auth.exception.OAuthTokenNotValidException;
import com.sally.airbnb.web.auth.exception.TokenNotFoundException;
import com.sally.airbnb.web.auth.service.Oauth;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

@PropertySource(value = "classpath:application.auth.properties")
@Service("github")
public class GithubOauth implements Oauth {

    @Value("${github.access.token.uri}")
    private String accessTokenUri;

    @Value("${github.user.uri}")
    private String userInfoUri;

    @Value("${github.web.client.id}")
    private String clientId;

    @Value("${github.web.client.secret}")
    private String clientSecret;

    @Override
    public TokenResponse getToken(String code) {
        System.out.println(clientId);
        AccessTokenRequest accessTokenRequest = AccessTokenRequest.builder()
                                                                  .clientId(clientId)
                                                                  .clientSecret(clientSecret)
                                                                  .code(code)
                                                                  .build();

        return webClient.post()
                        .uri(accessTokenUri)
                        .accept(MediaType.APPLICATION_JSON)
                        .bodyValue(accessTokenRequest)
                        .retrieve()
                        .onStatus(HttpStatus::is4xxClientError, error -> Mono.error(OAuthRequestNotValidException::new))
                        .bodyToMono(TokenResponse.class)
                        .blockOptional()
                        .orElseThrow(TokenNotFoundException::new);
    }

    @Override
    public UserInfoResponse getUserInfo(String token, OAuthType type) {
        UserInfoResponse userInfoResponse = webClient.get()
                                                     .uri(userInfoUri)
                                                     .accept(MediaType.APPLICATION_JSON)
                                                     .header(HttpHeaders.AUTHORIZATION, "token " + token)
                                                     .retrieve()
                                                     .onStatus(HttpStatus::is4xxClientError, error -> Mono.error(OAuthTokenNotValidException::new))
                                                     .bodyToMono(UserInfoResponse.class)
                                                     .blockOptional()
                                                     .orElseThrow(TokenNotFoundException::new);
        userInfoResponse.setOAuthType(type);
        return userInfoResponse;
    }

    @Override
    public UserInfoResponse readUserInfo(String code, OAuthType type) {
        TokenResponse tokenResponse = getToken(code);
        return getUserInfo(tokenResponse.getAccessToken(), type);
    }
}
