package com..Controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com..Config.MyUserDetails;

@Controller
public class ChattingController {
	@Autowired SessionRegistry sessionRegistry;
	
	@GetMapping("/chatting.do")
	public String chattingIndex(HttpSession session, @AuthenticationPrincipal MyUserDetails myUserDetails) {
		session.setAttribute("user", myUserDetails);
		return "chatting";
	}
	
	@ResponseBody
	@PostMapping("/userList.do")
	public List<String> userList(HttpSession session, @AuthenticationPrincipal MyUserDetails myUserDetails) {
		List<String> userList = new ArrayList<>();
		for(Object user : sessionRegistry.getAllPrincipals()) {
			if(myUserDetails.getNickname().equals(((MyUserDetails)user).getNickname()))
					continue;
			userList.add(((MyUserDetails)user).getNickname());
		}
		return userList;
	}
	
	/**
	 * 3. 유저 목록
	 * @param session
	 * @return
	 */
	@PostMapping(value = "/chatRecord.do")
	public ModelAndView chatRecord(HttpSession session, @RequestBody HashMap<String, String> map) {
		
		ModelAndView mav = null;
		
		// ArrayList<UserDTO> chatList = userSerivce.selectChatList();
		
		mav = new ModelAndView("message");
		
		return mav;
	}
	
	

	
	/**
	 * 3. 메세지 HTML 전송
	 * JSON 타입의 파라미터를 받기 위해서는 @RequestBody 어노테이션을 붙여줘야 한다.
	 * 
	 * @param session
	 * @param map
	 * @return
	 */
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
	
	
	/**
	 * 4. 채팅룸 HTML 전송
	 * JSON 타입의 파라미터를 받기 위해서는 @RequestBody 어노테이션을 붙여줘야 한다.
	 * @param session
	 * @param map
	 * @return
	 */
	@PostMapping(value = "/room.do")
	public ModelAndView room(HttpSession session, @RequestBody HashMap<String, String> map) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("h:mm a | MMM d", new Locale("en", "US"));
		
		ModelAndView mav = null;
		
		mav = new ModelAndView("room"); 
		
		// 날짜 추가         
		mav.addObject("date", sdf.format(new Date()));
		
		if(map.get("handle").equals("roomList")) {     
			map.remove("handle");
			mav.addObject("map", map);
			return mav;
		}

		// uuid 추가
		mav.addObject("uuid", map.get("uuid"));
		
		String sender = map.get("sender");
		
		mav.addObject("sender", sender);
		return mav;
	}	
}
