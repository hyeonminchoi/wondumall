package com..Controller;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class GlobalExceptionHandler {
	@ExceptionHandler(Exception.class)
	public ModelAndView exceptionHandler(Exception exception) {
		ModelAndView mv = new ModelAndView("error");
		mv.addObject("error", "에러가 발생하였습니다.");
		return mv;
	}
	@ExceptionHandler(AccessDeniedException.class)
	public ModelAndView accessDeniedExceptionHandler(AccessDeniedException exception) {
		ModelAndView mv = new ModelAndView("error");
		mv.addObject("error", "접근 권한이 없습니다.");
		return mv;
	}
	@ExceptionHandler(ResponseStatusException.class)
	public ModelAndView responseStatusExceptionHandler(ResponseStatusException exception) {
		ModelAndView mv = new ModelAndView("error");
		if(exception.getRawStatusCode()==403)
			mv.addObject("error", "접근 권한이 없습니다.");
		else
			mv.addObject("error", "에러가 발생하였습니다.");
		return mv;
	}
}
