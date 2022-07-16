package com..Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ChattingController {
	
	@GetMapping("/chatting.do")
	public String chattingIndex() {
		return "chatting";
	}
}
