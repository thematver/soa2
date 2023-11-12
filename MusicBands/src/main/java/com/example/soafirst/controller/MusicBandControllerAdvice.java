package com.example.soafirst.controller;

import com.example.soafirst.storage.entity.response.Error;
import com.example.soafirst.storage.entity.response.ErrorUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import javax.persistence.NoResultException;

@ControllerAdvice
public class MusicBandControllerAdvice {
    @Autowired
    ErrorUtil errorUtil;

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public ResponseEntity<Error> validationException(MethodArgumentNotValidException e) {
        return errorUtil.buildResponseWithMessage(HttpStatus.BAD_REQUEST, e.getBindingResult().getAllErrors().get(0).getDefaultMessage());
    }

    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    public ResponseEntity<Error> validationParamException(){
        return errorUtil.buildResponseWithMessage(HttpStatus.BAD_REQUEST, "Invalid param supplied");
    }

    @ExceptionHandler(NoResultException.class)
    public ResponseEntity<Error> noResultException(){
        return errorUtil.buildResponseWithMessage(HttpStatus.NOT_FOUND, "Not Found");
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<Error> validationException(){
        return errorUtil.buildResponseWithMessage(HttpStatus.METHOD_NOT_ALLOWED, "Validation exception");
    }

    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public ResponseEntity<Error> methodNotFound(){
        return errorUtil.buildResponseWithMessage(HttpStatus.NOT_FOUND, "Not Found");
    }

    @ExceptionHandler(Throwable.class)
    public ResponseEntity<Error> handleThrowable(Throwable e) {
        return errorUtil.buildResponseWithMessage(HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage());
    }
}
