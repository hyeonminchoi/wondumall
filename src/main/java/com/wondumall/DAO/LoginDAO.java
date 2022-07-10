package com..DAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

}
