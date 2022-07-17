package com..Controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com..Config.MyUserDetails;
import com..DTO.ChatDTO;
import com..DTO.LoginDTO;
import com..Service.ChattingService;

@Controller
public class ChattingController {
	@Autowired private ChattingService chattingService;
	
	@GetMapping("/chatting.do")
	public String chattingIndex(HttpSession session, @AuthenticationPrincipal MyUserDetails myUserDetails) {
		session.setAttribute("user", myUserDetails); //WebSocketHandler에서 스프링시큐리티 세션에 접근을 못함
		return "chatting";
	}
	
	@ResponseBody
	@PostMapping("/userList.do")
	public List<LoginDTO> userList(@AuthenticationPrincipal MyUserDetails myUserDetails) {
		
		if(myUserDetails.getAuthorities().stream().anyMatch(a->a.getAuthority().equals("ROLE_ADMIN"))) { //관리자일 경우 마지막 채팅 순으로 방 리스트 출력
			return chattingService.getRoomList(myUserDetails.getNo());
		} else {
			return chattingService.getAdminList(myUserDetails.getNo());
		}
	}
	
	@ResponseBody
	@PostMapping("/changeRoom.do")
	public List<ChatDTO> changeRoom(@AuthenticationPrincipal MyUserDetails myUserDetails, @RequestBody Map<String, Object> data) {
		if(myUserDetails.getAuthorities().stream().anyMatch(a->a.getAuthority().equals("ROLE_ADMIN"))) { //관리자일 경우 채팅 목록 리턴
			return chattingService.getChattingList(data);
		} else { //사용자일 경우 방이 없다면 생성, 있다면 채팅 리스트 리턴
			if(chattingService.containRoom(data)==0) {
				chattingService.createRoom(data);
				return null;
			} else
				return chattingService.getChattingList(data);
		}
	}

	@PostMapping(value = "/message.do")
	public ModelAndView message(HttpSession session, @RequestBody HashMap<String, String> map, @AuthenticationPrincipal MyUserDetails myUserDetails) { 
		
		SimpleDateFormat sdf = new SimpleDateFormat("h:mm a | MMM d", new Locale("en", "US"));
		
		ModelAndView mav = null;
		
		mav = new ModelAndView("message"); 
		
		String sender = map.get("sender");

		if(!myUserDetails.getNickname().equals(sender)) {
			mav.addObject("sender", sender);
		}
		
		mav.addObject("content", map.get("content"));
		mav.addObject("date", sdf.format(new Date()));
		return mav;
	}	
	
}
