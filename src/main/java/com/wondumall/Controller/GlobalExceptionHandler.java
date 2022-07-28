package com..Controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {
	@ExceptionHandler(Exception.class)
	public void exceptionHandler(Exception exception) {
		System.out.println(exception);
//		return "error";
	}
}
