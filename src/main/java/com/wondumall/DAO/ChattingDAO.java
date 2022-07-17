package com..DAO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com..DTO.ChatDTO;
import com..DTO.LoginDTO;

@Repository
public class ChattingDAO {
	@Autowired private SqlSession sqlSession;

	public List<LoginDTO> getAdminList(int u_no) {
		return sqlSession.selectList("chatting.getAdminList", u_no);
	}

	public List<LoginDTO> getRoomList(int u_no) {
		return sqlSession.selectList("chatting.getRoomList", u_no);
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
	
	
}
