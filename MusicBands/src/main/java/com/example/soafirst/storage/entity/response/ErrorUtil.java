package com.example.soafirst.storage.entity.response;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import java.time.Instant;

@Component
public class ErrorUtil {
    public ResponseEntity<Error> buildResponseWithMessage(HttpStatus status, String message){
        return ResponseEntity
                .status(status)
                .contentType(MediaType.APPLICATION_JSON)
                .body(Error.builder()
                        .message(message)
                        .code(String.valueOf(status.value()))
                        .build()
                );
    }
}
