package com..Util;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;
import org.springframework.stereotype.Component;

@Component
public class Util {
	// 1. string에서 int타입으로 반환
	public int str2Int(String str) {
		return Integer.parseInt(str);
	}

	public static String xss_clean_check(String value) {
		String safe_value = Jsoup.clean(value, Safelist.none());
		if (safe_value.equals("") || safe_value == null) {
			safe_value = "XSS 공격이 감지되었습니다.";
		}
		return safe_value;
	}
	
	public static String xss_clean_check(String value, HttpServletRequest request) {
		String safe_value = Jsoup.clean(value, request.getRequestURL().toString(), Safelist.relaxed().preserveRelativeLinks(true));
		if (safe_value.equals("") || safe_value == null) {
			safe_value = "XSS 공격이 감지되었습니다.";
		}
		return safe_value;
	}
}
