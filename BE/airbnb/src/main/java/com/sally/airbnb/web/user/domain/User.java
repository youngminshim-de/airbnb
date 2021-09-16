package com.sally.airbnb.web.user.domain;

import com.sally.airbnb.web.common.BaseEntity;
import com.sally.airbnb.web.user.OAuthInfo;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;

@NoArgsConstructor
@Getter
@Entity
public class User extends BaseEntity {

    @Column
    private String username;

    @Column
    private String name;

    @Column
    private String avatarUrl;

    @Column
    private OAuthInfo oAuthInfo;

    private User(String username, String name, String avatarUrl, OAuthInfo oAuthInfo) {
        this.username = username;
        this.name = name;
        this.avatarUrl = avatarUrl;
        this.oAuthInfo = oAuthInfo;
    }

    @Builder
    public static User of(String username, String name, String avatarUrl, OAuthInfo oAuthInfo) {
        return new User(username, name, avatarUrl, oAuthInfo);
    }
}
