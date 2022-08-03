package com.wondumall.DAO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wondumall.DTO.ChatDTO;
import com.wondumall.DTO.LoginDTO;

@Repository
public class ChattingDAO {
	@Autowired private SqlSession sqlSession;

	public List<LoginDTO> getAdminList(Map<String, Object> data) {
		return sqlSession.selectList("chatting.getAdminList", data);
	}

	public List<LoginDTO> getRoomList(Map<String, Object> data) {
		return sqlSession.selectList("chatting.getRoomList", data);
	}

	public List<ChatDTO> getChattingList(Map<String, Object> data) {
		return sqlSession.selectList("chatting.getChattingList", data);
	}

	public int containRoom(Map<String, Object> data) {
		return sqlSession.selectOne("chatting.containRoom", data);
	}

	public void createRoom(Map<String, Object> data) {
		sqlSession.insert("chatting.createRoom",data);
	}

	public int addChatting(Map<String, Object> map) {
		return sqlSession.insert("chatting.addChatting", map);
	}

	public int getAdminNo(String receive) {
		return sqlSession.selectOne("chatting.getAdminNo", receive);
	}

	public void setRoomCountMinus(Map<String, Object> map) {
		sqlSession.update("chatting.setRoomCountMinus", map);
	}

	public void setRoomCountPlus(Map<String, Object> map) {
		sqlSession.update("chatting.setRoomCountPlus", map);
	}

	public void resetRoomCountPlus(Map<String, Object> map) {
		sqlSession.update("chatting.resetRoomCountPlus", map);
	}

	public void resetRoomCountMinus(Map<String, Object> map) {
		sqlSession.update("chatting.resetRoomCountMinus", map);
	}
	
	
}
