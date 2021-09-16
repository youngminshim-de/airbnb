package com.sally.airbnb.web.user.repository;

import com.sally.airbnb.web.user.OAuthInfo;
import com.sally.airbnb.web.user.domain.User;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface UserRepository extends CrudRepository<User, Long> {

    boolean existsById(Long id);

    Optional<User> findByOAuthInfo(OAuthInfo oAuthInfo);
}
