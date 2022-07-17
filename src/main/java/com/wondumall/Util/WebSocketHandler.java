package com..Util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com..Config.MyUserDetails;

public class WebSocketHandler extends TextWebSocketHandler{
	
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
		JsonParser jsonParser = new JsonParser();
		Gson gson = new Gson();
		Map<String, Object> data = gson.fromJson((String)message.getPayload(), Map.class);
		
		if(data.get("from").equals(""))
			return;
		// 보낸 사람 (나)
		MyUserDetails sender = (MyUserDetails)session.getAttributes().get("user");
		String senderNickname = sender.getNickname();
		int senderNo = sender.getNo();
		String msg = data.get("message").toString();
		if(!msg.equals("")) {
			System.out.println(msg);
		}
//		if(jsonObject.get("handle").toString().equals("message")) {
//			
//			// 채팅 메세지
//			message = new TextMessage("message" + "," + sender.getNickname() + "," + jsonObject.get("content").toString() + "," + sender.getNo());
//			// 메세지 전송
//			userList.get(userList.get(jsonObject.get("no"))).sendMessage(message);
//			
//		}
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
