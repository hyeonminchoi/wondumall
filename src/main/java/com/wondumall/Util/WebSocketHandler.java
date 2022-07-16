package com..Util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com..Config.MyUserDetails;

public class WebSocketHandler extends TextWebSocketHandler{
	@Autowired private SessionRegistry sessionRegistry;
	
	private Map<MyUserDetails, WebSocketSession> userList = new HashMap<>();
	private Map<Integer ,MyUserDetails> roomList = new HashMap<>();
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		MyUserDetails user = (MyUserDetails)session.getAttributes().get("user");
		
		userList.put(user, session);
		
		roomList.put(user.getNo(), user);
	}

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		JsonParser jParser = new JsonParser();
		JsonObject jObject = (JsonObject) jParser.parse((String)message.getPayload());
		
		// 보낸 사람 (나)
		MyUserDetails sender = (MyUserDetails)session.getAttributes().get("user");
		String senderName = sender.getNickname();
		int senderNo = sender.getNo();
				
		if(jObject.get("handle").toString().equals("message")) {
			
			// 채팅 메세지
			message = new TextMessage("message" + "," + sender.getNickname() + "," + jObject.get("content").toString() + "," + sender.getNo());
			// 메세지 전송
			userList.get(userList.get(jObject.get("no"))).sendMessage(message);
			
		}else if(jObject.get("handle").toString().equals("login")) {
			
			// [나 → 상대방] 로그인 알림 메세지
			message = new TextMessage("login" + "," + senderNo);
			// [로그인목록 → 나]
			String loginedUsers = "onLineList";
			
			// 로그인 되어 있는 유저들의 채팅방 화면에 전송하여 로그인 알림
			for (MyUserDetails users : userList.keySet()) {
				// 자기 자신은 제외
				if(users.getNo() == senderNo) continue;
				userList.get(users).sendMessage(message); 
				loginedUsers += "," + users.getNo();
			}
			
			message = new TextMessage(loginedUsers);
			userList.get(sender).sendMessage(message);  
			
		}else if(jObject.get("handle").toString().equals("logout")) {
			
			// [나 → 상대방] 로그아웃 알림 메세지
			message = new TextMessage("logout" + "," + senderNo);                 
			                      
			// 로그인 되어 있는 유저들의 채팅방 화면에 전송하여 로그아웃 알림
			for (MyUserDetails users : userList.keySet()) {
				// 자기 자신은 제외 (아직 로그인 session 종료 X)
				if(users.getNickname().equals(senderName)) continue;
				userList.get(users).sendMessage(message);
			}
			
		}else if(jObject.get("handle").toString().equals("onLineList")) {	
			
			String loginedUsers = "onLineList";
			// 로그인 되어 있는 유저 불러오기
			for (MyUserDetails users : userList.keySet()) {
				// 자기 자신은 제외
				if(users.getNickname().equals(senderName)) continue;
				loginedUsers += "," + users.getNo();
			}
			message = new TextMessage(loginedUsers);
			userList.get(sender).sendMessage(message);
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		MyUserDetails user = (MyUserDetails)session.getAttributes().get("user");
		userList.remove(user);
		roomList.remove(user.getNo());
	}

	@Override
	public boolean supportsPartialMessages() {
		return false;
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
	}
	
}
