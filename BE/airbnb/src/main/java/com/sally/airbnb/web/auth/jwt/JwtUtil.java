package com.sally.airbnb.web.auth.jwt;

import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.JWSObject;
import com.nimbusds.jose.JWSSigner;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import com.sally.airbnb.web.auth.exception.JwtVerificationFailedException;
import com.sally.airbnb.web.user.domain.User;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.sql.Date;
import java.time.LocalDate;

@Component
public class JwtUtil {

    @Value("${jwt.secret.mac}")
    private String jwtSecret;

    @SneakyThrows
    public String getJWT(User user) {
        JWSHeader jwsHeader = new JWSHeader(JWSAlgorithm.HS256);
        JWSSigner jwsSigner = new MACSigner(jwtSecret);

        JWTClaimsSet claimsSet = new JWTClaimsSet.Builder()
                                         .subject(user.getId().toString())
                                         .expirationTime(Date.valueOf(LocalDate.now().plusDays(2)))
                                         .build();
        SignedJWT signedJWT = new SignedJWT(jwsHeader, claimsSet);
        signedJWT.sign(jwsSigner);
        return signedJWT.serialize();
    }

    @SneakyThrows
    public Long getSubjectFromToken(String token) {
        SignedJWT signedJWT = SignedJWT.parse(token);
        verifyJWT(signedJWT);
        return Long.parseLong(signedJWT.getJWTClaimsSet().getSubject());
    }

    @SneakyThrows
    public void verifyJWT(SignedJWT signedJWT) {
        if (!signedJWT.verify(new MACVerifier(jwtSecret))) {
            throw new JwtVerificationFailedException();
        }
    }
}
