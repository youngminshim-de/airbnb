package com.sally.airbnb.web.user.mapper;

import com.sally.airbnb.web.auth.controller.response.UserInfoResponse;
import com.sally.airbnb.web.user.domain.User;
import org.mapstruct.AfterMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UserMapper {

    UserMapper INSTANCE = Mappers.getMapper(UserMapper.class);

    @Mapping(source = "id", target = "oauthResourceId")
    @Mapping(source = "login", target = "username")
    User UserInfoToUser(UserInfoResponse userInfoResponse);
}
