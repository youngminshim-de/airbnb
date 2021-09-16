package com.sally.airbnb.web.auth.annotation;

import java.lang.annotation.*;

/*
* 로그인 필요한 요청에 사용
* @author Sally Oh
*/
@Target({ElementType.METHOD, ElementType.ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface LoginRequired {
}
