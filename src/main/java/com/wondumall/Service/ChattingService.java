package com..Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.ChattingDAO;
import com..DTO.ChatDTO;
import com..DTO.LoginDTO;

@Service
public class ChattingService {
	@Autowired ChattingDAO chattingDAO;

	public List<LoginDTO> getAdminList(int u_no) {
		return chattingDAO.getAdminList(u_no);
	}

	public List<LoginDTO> getRoomList(int u_no) {
		return chattingDAO.getRoomList(u_no);
	}

	public List<ChatDTO> getChattingList(Map<String, Object> data) {
		return chattingDAO.getChattingList(data);
	}

	public int containRoom(Map<String, Object> data) {
		return chattingDAO.containRoom(data);
	}

	public void createRoom(Map<String, Object> data) {
		chattingDAO.createRoom(data);
	}
}
