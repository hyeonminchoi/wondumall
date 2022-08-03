package com.wondumall.Util;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;

import com.wondumall.DTO.LoginDTO;

@Component
public class Util {
	// 1. string에서 int타입으로 반환
	public int str2Int(String str) {
		return Integer.parseInt(str);
	}

	public static String xss_clean_check(String value) {
		if(value.equals("") || value==null)
			return null;
		String safe_value = Jsoup.clean(value, Safelist.none());
		if (safe_value.equals("") || safe_value == null) {
			safe_value = "XSS 공격이 감지되었습니다.";
		}
		return safe_value;
	}
	
	public static String xss_clean_check(String value, HttpServletRequest request) {
		if(value.equals("") || value==null)
			return null;
		String safe_value = Jsoup.clean(value, request.getRequestURL().toString(), Safelist.relaxed().preserveRelativeLinks(true));
		if (safe_value.equals("") || safe_value == null) {
			safe_value = "XSS 공격이 감지되었습니다.";
		}
		return safe_value;
	}
	
	public static void userInfoRegex(String method, LoginDTO user) throws Exception{
		if(method.equals("join")) {
			if(!user.getU_email().matches("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$"))
				throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
			if(!user.getU_pw().matches("^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$"))
				throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
		}
		if(!user.getU_name().matches("^[가-힣]{2,20}|[a-zA-Z]{2,20}\\s[a-zA-Z]{2,20}$"))
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
		if(!user.getU_nickname().matches("^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$"))
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
		if(user.getU_tel().equals("") || user.getU_tel()==null)
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
		if(user.getU_postcode().equals("") || user.getU_postcode()==null)
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
		if(user.getU_roadAddress().equals("") || user.getU_roadAddress()==null)
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
		if(user.getU_extraAddress().equals("") || user.getU_extraAddress()==null)
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
		if(user.getU_detailAddress().equals("") || user.getU_detailAddress()==null)
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
	}
}
