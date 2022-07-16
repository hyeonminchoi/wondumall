package com..Controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com..Config.MyUserDetails;

@Controller
public class ChattingController {
	
	@GetMapping("/chatting.do")
	public String chattingIndex() {
		return "chatting";
	}
}
