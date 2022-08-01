package com..DAO;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.ModelAndView;

import com..DTO.LoginDTO;

@Repository
public class LoginDAO {
	@Autowired
	private  SqlSession sqlSession;

	public LoginDTO login(LoginDTO dto) {
		return sqlSession.selectOne("login.login", dto);
	}

	public int join(LoginDTO dto) {
		return sqlSession.insert("login.join", dto);
	}

	public LoginDTO findByUserid(LoginDTO user) {
		return sqlSession.selectOne("login.findByUserid", user);
	}

	public int emailCheck(String email) {
		return sqlSession.selectOne("login.emailCheck", email);
	}

	public int nicknameCheck(String nickname) {
		return sqlSession.selectOne("login.nicknameCheck", nickname);
	}

	public int gradeCheck(String grade) {
		return sqlSession.selectOne("login.gradeCheck", grade);
	}
	public int update(LoginDTO dto) {
		return sqlSession.update("login.update", dto);
			
	}

	public void SNSjoin(LoginDTO user) {
		sqlSession.insert("login.SNSjoin", user);
	}

	public int snsInfoUpdate(LoginDTO loginDTO) {
		return sqlSession.update("login.snsInfoUpdate", loginDTO);
	}

	public ModelAndView mypage(LoginDTO dto) {
		return sqlSession.selectOne("login.mypage", dto);
	}

	public Object resign(int u_no) {
		return sqlSession.update("login.resign", u_no);
	}

	public int changepw(LoginDTO user) {
		return sqlSession.update("login.changepw", user);	
	}

	public String checkpw(int u_no) {
		return sqlSession.selectOne("login.checkpw", u_no);
	}

	public int contain(LoginDTO user) {
		return sqlSession.selectOne("login.contain", user);
	}

	public int resetpw(LoginDTO user) {
		return sqlSession.update("login.resetpw", user);
	}

	public String findid(Map<String, Object> map) {
		return sqlSession.selectOne("login.findid", map);
	}

}
