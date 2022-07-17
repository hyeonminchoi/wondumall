package com..Util;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonParser;
import com..Config.MyUserDetails;
import com..Service.ChattingService;

public class WebSocketHandler extends TextWebSocketHandler{
	
	private Map<MyUserDetails, WebSocketSession> userList = new HashMap<>();
	private Map<Integer ,MyUserDetails> roomList = new HashMap<>();
	@Autowired ChattingService chattingService;
	
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
		String from = data.get("from").toString();
		MyUserDetails sender = (MyUserDetails)session.getAttributes().get("user");
		String senderNickname = sender.getNickname();
		int senderNo = sender.getNo();
		String msg = data.get("message").toString();
		Map<String, Object> map = new HashMap<>();
		map.put("message", msg);
		map.put("sender_no", senderNo);
		int receiveNo = chattingService.getAdminNo(from);
		map.put("receive_no", receiveNo);
		
		if(!msg.equals("")) { //메시지가 있다면 저장 및 전송
			int result = chattingService.addChatting(map);
			if(result>0) { //관리자 및 사업자가 채팅 친 경우
				Timestamp date = (Timestamp) map.get("chat_date");
				if(sender.getAuthorities().stream().anyMatch(a->a.getAuthority().equals("ROLE_ADMIN") || a.getAuthority().equals("ROLE_BUSINESS"))) {
					chattingService.setRoomCountMinus(map);
				} else { //사용자가 채팅 친 경우
					chattingService.setRoomCountPlus(map);
				}
				message = new TextMessage(senderNickname +"," + msg + "," + date.toString());
				if(userList.containsKey(roomList.get(receiveNo))) //사용자가 로그인 해 있을 경우 메시지 전송
					userList.get(roomList.get(receiveNo)).sendMessage(message);
			}
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
