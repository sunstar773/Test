package com.fh.exception;

import com.fh.po.common.ServerResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class HandleException {
    @ExceptionHandler(Exception.class)
    @ResponseBody
    private ServerResponse handleExcp(Exception e){
            return ServerResponse.error();
    }
}
