package com..Util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.ptl.mvc.filter.HTMLTagFilterRequestWrapper;

public class HTMLTagFilter implements Filter {

	@SuppressWarnings("unused")
	private FilterConfig config;

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		if (checkUrl(req)) {
			chain.doFilter(request, response);
		} else {
			chain.doFilter(new HTMLTagFilterRequestWrapper((HttpServletRequest) request), response);
		}
	}

	public void init(FilterConfig config) throws ServletException {
		this.config = config;
	}

	public void destroy() {

	}

	private boolean checkUrl(HttpServletRequest req) {
		String uri = req.getRequestURI().toString().trim();
		if (uri.startsWith("//noticeWrite.do") || uri.startsWith("//noticeEdit.do")
				|| uri.startsWith("//boardWrite.do") || uri.startsWith("//boardEdit.do")
				|| uri.startsWith("//questionWrite.do") || uri.startsWith("//questionEdit.do")
				|| uri.startsWith("//faqWrite.do")) {
			return true;
		} else {
			return false;
		}
	}
}