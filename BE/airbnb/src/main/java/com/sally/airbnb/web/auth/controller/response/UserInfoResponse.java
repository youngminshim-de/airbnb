package com.sally.airbnb.web.auth.controller.response;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.sally.airbnb.web.auth.OAuthType;
import com.sally.airbnb.web.user.OAuthInfo;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class UserInfoResponse {

    private String resourceServerId;

    private String login;

    private String avatarUrl;

    private String name;

    private OAuthType oAuthType;
}
