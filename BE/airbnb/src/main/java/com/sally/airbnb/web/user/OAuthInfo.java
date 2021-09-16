package com.sally.airbnb.web.user;

import com.sally.airbnb.web.auth.OAuthType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Embeddable
public class OAuthInfo {

    private OAuthType oAuthType;

    private String resourceId;
}
