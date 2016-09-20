package com.daverokita.blog;

import org.jose4j.jws.AlgorithmIdentifiers;
import org.jose4j.jws.JsonWebSignature;
import org.jose4j.jwt.JwtClaims;
import org.jose4j.jwt.MalformedClaimException;
import org.jose4j.jwt.consumer.InvalidJwtException;
import org.jose4j.keys.HmacKey;
import org.jose4j.lang.JoseException;
import org.jose4j.jwt.consumer.JwtConsumerBuilder;
import org.jose4j.jwt.consumer.JwtConsumer;
import java.security.Key;
import java.io.UnsupportedEncodingException;

public class JWT {
    public static String createJWT(String id, String subject, long expiry) {
        // Generate the sigining key pair
        String jwt = null;
        String issuer = "http://daverokita.com";
        String audience = "bloguser";

        try {
            String apiKey = "fc8eeaba10c789964cf321ea9f83e7ba9afe7aa6dd1c0173b3bf2e464db6d0aa";
            Key key = new HmacKey(apiKey.getBytes("UTF-8"));

            // Create claims
            JwtClaims claims = new JwtClaims();
            claims.setIssuer(issuer);
            claims.setAudience(audience);
            claims.setExpirationTimeMinutesInTheFuture(expiry);
            claims.setGeneratedJwtId();
            claims.setIssuedAtToNow();
            claims.setNotBeforeMinutesInThePast(2);
            claims.setSubject(id);

            // Create signing package
            JsonWebSignature jws = new JsonWebSignature();

            // Add payload to the jws package
            jws.setPayload(claims.toJson());

            // Sign the jws with the private key that was generated earlier
            //jws.setKey(rsaJsonWebKey.getPrivateKey());
            jws.setKey(key);

            // Set the Key ID in the header.  This will help later if the key needs to be rolled over
            // Additionally, it could also help in scenarios where multiple keys are used for differenet
            // Different situations.

            // Set the signature algorithm on the JWT/JWS that will protect the integrity of the claims
            jws.setAlgorithmHeaderValue(AlgorithmIdentifiers.HMAC_SHA256);

            // Compact the JWS into a Baase64 encoded websafe string
            jwt = jws.getCompactSerialization();

        } catch (JoseException | UnsupportedEncodingException e) {
            System.out.println("There was a problem creating the token");
            System.out.println(e.getMessage());
        }

        return jwt;
    }

    public static String checkJWT(String jwt) {
        String valid = null;

        try {
        String apiKey = "fc8eeaba10c789964cf321ea9f83e7ba9afe7aa6dd1c0173b3bf2e464db6d0aa";
        Key key = new HmacKey(apiKey.getBytes("UTF-8"));

            JwtConsumer jwtConsumer = new JwtConsumerBuilder()
                .setExpectedIssuer("http://daverokita.com")
                .setExpectedAudience("bloguser")
                .setRequireExpirationTime()
                .setRequireSubject()
                .setRequireJwtId()
                .setRequireExpirationTime()
                .setRequireIssuedAt()
                .setVerificationKey(key)
                .build();

            JwtClaims jwtClaims = jwtConsumer.processToClaims(jwt);
            valid = jwtClaims.getSubject();
        } catch (InvalidJwtException | UnsupportedEncodingException | MalformedClaimException e) {
            valid =null;
        }
        return valid;
    }
}
