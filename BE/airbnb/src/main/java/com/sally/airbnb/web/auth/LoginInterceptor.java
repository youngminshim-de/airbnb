package com.sally.airbnb.web.auth;

import com.sally.airbnb.web.auth.annotation.LoginRequired;
import com.sally.airbnb.web.auth.exception.LoginRequiredException;
import com.sally.airbnb.web.auth.jwt.JwtUtil;
import com.sally.airbnb.web.user.domain.User;
import com.sally.airbnb.web.user.exception.UserNotFoundException;
import com.sally.airbnb.web.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequiredArgsConstructor
@Component
public class LoginInterceptor implements HandlerInterceptor {

    private final JwtUtil jwtUtil;
    private final UserRepository userRepository;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (handler instanceof HandlerMethod) {
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            String header = request.getHeader("Authorization");
            if (handlerMethod.hasMethodAnnotation(LoginRequired.class) && header.isEmpty()) {
                throw new LoginRequiredException();
            }
            String token = header.substring("Bearer ".length());
            Long loggedInUserId = jwtUtil.getSubjectFromToken(token);
            User user = userRepository.findById(loggedInUserId).orElseThrow(UserNotFoundException::new);
            request.setAttribute("user", user);
        }
        return true;
    }
}
